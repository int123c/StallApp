//
//  ListViewController.m
//  Stall
//
//  Created by Inti Guo on 06/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import "ListViewController.h"
#import "Douban.h"
#import "UIAlertController+ErrorAlert.h"
#import "STNavigationBar.h"
#import "STButton.h"
#import "BookCollectionViewCell.h"
#import "DetailViewController.h"


typedef NS_ENUM(NSInteger, ListViewState) {
    ListViewStateNormal = 0,
    ListViewStateSelection
};


@interface ListViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableIndexSet *selectedBookIndexSet;

@property (weak, nonatomic) IBOutlet STNavigationBar *naviBar;

@property (strong, nonatomic) UIButton *doneButton;
@property (strong, nonatomic) STButton *barcodeButton;
@property (strong, nonatomic) STButton *trashBinButton;
@property (strong, nonatomic) STButton *heartButton;
@property (nonatomic) ListViewState state;

@end

@implementation ListViewController

static void * observerContext = &observerContext;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [ListViewModel new];
    [self.viewModel setupObservers];
    [self.viewModel loadData];
    self.selectedBookIndexSet = [NSMutableIndexSet new];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
    self.collectionView.scrollEnabled = YES;
    
    if ([[UIScreen mainScreen] bounds].size.width >= 375) {
        [[self getFlowLayout] setItemSize:CGSizeMake(180, 180)];
    } else {
        [[self getFlowLayout] setItemSize:CGSizeMake(150, 150)];
    }
    
    [[self getFlowLayout] setMinimumLineSpacing:2];
    [[self getFlowLayout] setMinimumInteritemSpacing:2];
    [self.collectionView reloadData];
    
    self.state = ListViewStateNormal;
    
    [self setupNavigationBarButtons];
    [self setupNavigationBarToNormal];
    
    UILongPressGestureRecognizer *lp = [UILongPressGestureRecognizer new];
    lp.minimumPressDuration = 1;
    lp.delaysTouchesBegan = true;
    [lp addTarget:self action:@selector(onLongPress:)];
    lp.delegate = self;
    
    [self.collectionView addGestureRecognizer:lp];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(onItemChanged) name:ITEM_CHANGED object:self.viewModel];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(handleBookNotFound) name:ERROR_BOOK_NOT_FOUND object:NULL];
    [self.selectedBookIndexSet addObserver:self forKeyPath:@"count" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:observerContext];
}

- (void)viewWillDisappear:(BOOL)animated {
    [NSNotificationCenter.defaultCenter removeObserver:self name:ERROR_BOOK_NOT_FOUND object:NULL];
    [self.selectedBookIndexSet removeObserver:self forKeyPath:@"count"];
    [super viewWillDisappear:animated];
}

- (void)dealloc {
    [self.viewModel removeObservers];
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)setupNavigationBarButtons {
    self.trashBinButton = [STButton buttonWithIconName:@"TrashBinIcon"];
    [self.trashBinButton addTarget:self action:@selector(onTrashBinButtonTap) forControlEvents:UIControlEventTouchUpInside];
    
    self.barcodeButton = [STButton buttonWithIconName:@"BarcodeIcon"];
    [self.barcodeButton addTarget:self action:@selector(onBarcodeButtonTap) forControlEvents:UIControlEventTouchUpInside];
    
    self.heartButton = [STButton buttonWithIconName:@"HeartOutlineIcon"];
    [self.heartButton addTarget:self action:@selector(onHeartButtonTap) forControlEvents:UIControlEventTouchUpInside];
    
    self.doneButton = [UIButton new];
    [self.doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [self.doneButton setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
    [self.doneButton addTarget:self action:@selector(onDoneButtonTap) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupNavigationBarToSelection {
    self.naviBar.rightActionView = self.doneButton;
    self.naviBar.leftActionView = self.trashBinButton;
    self.naviBar.title = @"Selected";
}

- (void)setupNavigationBarToNormal {
    self.naviBar.rightActionView = self.barcodeButton;
    self.naviBar.leftActionView = NULL;
    self.naviBar.title = @"Stall";
}

- (void)setState:(ListViewState)state {
    if (_state != state) {
        _state = state;
        if (state == ListViewStateNormal) {
            [self setupNavigationBarToNormal];
        } else {
            [self setupNavigationBarToSelection];
        }
    }
}

- (UICollectionViewFlowLayout *)getFlowLayout {
    if ([self.collectionView.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
        UICollectionViewFlowLayout *l = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
        return l;
    }
    return NULL;
}

#pragma mark - Actions

- (void)onTrashBinButtonTap {
    [self.viewModel removeBooksAtIndexSet:self.selectedBookIndexSet];
    NSMutableArray *indexPathes = [NSMutableArray new];
    [self.selectedBookIndexSet enumerateIndexesUsingBlock:^(NSUInteger index, BOOL *stop) {
        [indexPathes addObject:[NSIndexPath indexPathForRow:index inSection:0]];
    }];
    [self.collectionView deleteItemsAtIndexPaths:indexPathes];
}

- (void)onBarcodeButtonTap {
    [self.navigationController performSegueWithIdentifier:@"SHOW_SCAN_VIEW" sender:self];
}

- (void)onDoneButtonTap {
    [self.selectedBookIndexSet removeAllIndexes];
    [self.collectionView.visibleCells enumerateObjectsUsingBlock:^(UICollectionViewCell *obj, NSUInteger index, BOOL *stop) {
        BookCollectionViewCell *c = (BookCollectionViewCell *)obj;
        c.state = BookCollectionViewCellStateNormal;
    }];
    self.state = ListViewStateNormal;
}

- (void)onHeartButtonTap {
    // like those books, implemented in future!
}

- (void)onLongPress:(UILongPressGestureRecognizer *)lp {
    CGPoint location = [lp locationInView:self.collectionView];
    __block BOOL found = false;
    
    [self.collectionView.indexPathsForVisibleItems enumerateObjectsUsingBlock:^(NSIndexPath *obj, NSUInteger idx, BOOL *stop) {
        BookCollectionViewCell *c = (BookCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:obj];
        BOOL inside = [c hitTest:location withEvent:NULL];
        if (inside) {
            *stop = true;
            found = true;
            [self.selectedBookIndexSet addIndex:obj.row];
            c.state = BookCollectionViewCellStateSelected;
        }
    }];
    
    self.state = ListViewStateSelection;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.state == ListViewStateNormal) {
        return true;
    }
    return false;
}

#pragma mark - Observation

- (void)onItemChanged {
    switch (self.viewModel.manipulation) {
        case Add:
            [self.collectionView insertItemsAtIndexPaths:@[self.viewModel.manipulatingIndexPath]];
            break;
        case Edit:
            [self.collectionView reloadItemsAtIndexPaths:@[self.viewModel.manipulatingIndexPath]];
            break;
        case Remove:
            [self.collectionView deleteItemsAtIndexPaths:@[self.viewModel.manipulatingIndexPath]];
            break;
    }
}

- (void)handleBookNotFound {
    UIAlertController *alert = [UIAlertController errorAlertWithMessage:@"Book not found." completion:NULL];
    [self presentViewController:alert animated:YES completion:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == observerContext) {
        
        if (object == self.selectedBookIndexSet) {
            if (change[NSKeyValueChangeNewKey] == 0 && change[NSKeyValueChangeOldKey] > 0) {
                self.state = ListViewStateNormal;
            } else if (change[NSKeyValueChangeNewKey] > 0 && change[NSKeyValueChangeOldKey] == 0) {
                self.state = ListViewStateSelection;
            }
        }
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BookCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BOOK_CELL" forIndexPath:indexPath];
    Book *displayingBook = self.viewModel.bookList[indexPath.row];
    [cell applyBook:displayingBook];
    
    if ([self.selectedBookIndexSet containsIndex:indexPath.row]) {
        cell.state = BookCollectionViewCellStateSelected;
    }
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.viewModel numberOfBooks];
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.state == BookCollectionViewCellStateNormal) {
        [self performSegueWithIdentifier:@"SHOW_DETAIL" sender:((Book *)self.viewModel.bookList[indexPath.row]).isbn];
    } else {
        if ([self.selectedBookIndexSet containsIndex:indexPath.row]) {
            [self.selectedBookIndexSet removeIndex:indexPath.row];
            BookCollectionViewCell *c = (BookCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
            c.state = BookCollectionViewCellStateNormal;
        } else {
            [self.selectedBookIndexSet addIndex:indexPath.row];
            BookCollectionViewCell *c = (BookCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
            c.state = BookCollectionViewCellStateSelected;
        }
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SHOW_DETAIL"]) {
        DetailViewController *vc = (DetailViewController *)segue.destinationViewController;
        if ([sender isKindOfClass:[NSString class]]) {
            vc.viewModel.currentISBN = sender;
        }
    }
}

@end

//
//  ListViewController.m
//  Stall
//
//  Created by Inti Guo on 06/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import "ListViewController.h"
#import "ListViewModel.h"



@interface ListViewController ()

@property (nonatomic, strong) ListViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.viewModel loadData];
    [self.collectionView reloadData];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.viewModel = [[ListViewModel alloc] init];
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(onItemChanged) name:ITEM_CHANGED object:self.viewModel];
    }
    return self;
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

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

#pragma mark - UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"asd" forIndexPath:indexPath];
    Book *displayingBook = self.viewModel.bookList[indexPath.row];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_viewModel numberOfBooks];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // performSegue
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    
}


@end

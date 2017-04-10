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


@interface ListViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableIndexSet *selectedBookIndexSet;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [ListViewModel new];
    [self.viewModel loadData];
    [self.collectionView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(onItemChanged) name:ITEM_CHANGED object:self.viewModel];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(handleBookNotFound) name:ERROR_BOOK_NOT_FOUND object:NULL];
    [self.viewModel setupObservers];
}

- (void)viewWillDisappear:(BOOL)animated {
    [NSNotificationCenter.defaultCenter removeObserver:self];
    [self.viewModel removeObservers];
    [super viewWillDisappear:animated];
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

- (void)handleBookNotFound {
    UIAlertController *alert = [UIAlertController errorAlertWithMessage:@"Book not found."];
    [self presentViewController:alert animated:YES completion:NULL];
}

#pragma mark - UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"asd" forIndexPath:indexPath];
    Book *displayingBook = self.viewModel.bookList[indexPath.row];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.viewModel numberOfBooks];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"SHOW_DETAIL" sender:self];
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.selectedBookIndexSet addIndex:indexPath.row];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.selectedBookIndexSet removeIndex:indexPath.row];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

@end

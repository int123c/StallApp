//
//  ListViewModel.m
//  Stall
//
//  Created by Inti Guo on 09/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import "ListViewModel.h"
#import <MagicalRecord/MagicalRecord.h>
#import "Douban.h"

NSString * const ITEM_CHANGED = @"ITEM_CHANGED";

@implementation ListViewModel

- (NSInteger)numberOfBooks {
    return self.bookList.count;
}

- (void)loadData {
    self.bookList = [[Book MR_findAll] mutableCopy];
    if (self.bookList == NULL) { self.bookList = [NSMutableArray new]; }
    NSLog(@"%lu book found", (unsigned long)self.bookList.count);
}

- (void)removeBooksAtIndexSet:(NSIndexSet *)indexSet {
    [indexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop){
        Book *b = [self.bookList objectAtIndex:idx];
        [b MR_deleteEntity];
    }];
    [self.bookList removeObjectsAtIndexes:indexSet];
}

#pragma mark - Observing

- (void)setupObservers {
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(onNewItemFetched:) name:SUCCESS_ON_FETCH object:NULL];
}

- (void)removeObservers {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)onNewItemFetched:(NSNotification *)notification {
    NSString *isbn = notification.userInfo[@"isbn"];
    Book *newBook = [Book MR_findFirstByAttribute:@"isbn" withValue:isbn];
    [self.bookList insertObject:newBook atIndex:0];
    NSLog(@"%lu book found", (unsigned long)self.bookList.count);
    self.manipulation = Add;
    self.manipulatingIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    self.manipulatingBook = newBook;
    [NSNotificationCenter.defaultCenter postNotificationName:ITEM_CHANGED object:self];
}

@end

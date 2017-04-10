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
    return _bookList.count;
}

- (void)loadData {
    self.bookList = [[Book MR_findAll] mutableCopy];
}

- (void)onNewItemFetched:(NSNotification *)notification {
    NSString *isbn = notification.userInfo[@"isbn"];
    Book *newBook = [Book MR_findFirstByAttribute:@"isbn" withValue:isbn];
    [self.bookList insertObject:newBook atIndex:0];
    self.manipulation = Add;
    self.manipulatingIndexPath = [[NSIndexPath alloc] initWithIndex:0];
    self.manipulatingBook = newBook;
    [NSNotificationCenter.defaultCenter postNotificationName:ITEM_CHANGED object:self];
}

- (void)removeBooksAtIndexPath:(NSIndexSet *)indexSet {
    [indexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop){
        Book *b = [self.bookList objectAtIndex:idx];
        [b MR_deleteEntity];
    }];
    [self.bookList removeObjectsAtIndexes:indexSet];
}

- (instancetype)init {
    self = [super init];
    if (self != NULL) {
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(onNewItemFetched:) name:SUCCESS_ON_FETCH object:NULL];
    }
    
    return self;
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

@end

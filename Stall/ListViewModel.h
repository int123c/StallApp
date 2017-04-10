//
//  ListViewModel.h
//  Stall
//
//  Created by Inti Guo on 09/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Book+CoreDataClass.h"

typedef NS_ENUM(NSInteger, Manipulation) {
    Add,
    Remove,
    Edit
};

extern NSString * const ITEM_CHANGED;

@interface ListViewModel : NSObject

@property (nonatomic, copy) NSMutableArray *bookList;
@property (nonatomic, strong) Book *manipulatingBook;
@property (nonatomic) Manipulation manipulation;
@property (nonatomic, strong) NSIndexPath *manipulatingIndexPath;

- (NSInteger)numberOfBooks;
- (void)loadData;

@end

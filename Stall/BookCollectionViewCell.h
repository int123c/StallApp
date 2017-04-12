//
//  BookCollectionViewCell.h
//  Stall
//
//  Created by Inti Guo on 11/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book+CoreDataClass.h"

typedef NS_ENUM(NSInteger, BookCollectionViewCellState) {
    BookCollectionViewCellStateNormal = 0,
    BookCollectionViewCellStateLiked,
    BookCollectionViewCellStateSelected
};

@interface BookCollectionViewCell : UICollectionViewCell

@property (nonatomic) BookCollectionViewCellState state;
- (void)applyBook:(Book *)book;

@end

//
//  BookCoverTableViewCell.h
//  Stall
//
//  Created by Inti Guo on 11/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book+Stall.h"

@interface BookCoverTableViewCell : UITableViewCell

- (void)applyBook:(Book *)book;
- (void)animateIn;

@end

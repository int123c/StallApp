//
//  DetailViewModel.h
//  Stall
//
//  Created by Inti Guo on 10/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Book+CoreDataClass.h"

@interface DetailViewModel : NSObject

@property (nonatomic, strong) Book * book;
@property (nonatomic, strong) NSString *currentISBN;

- (NSString *)getPubdateString;
- (NSString *)getRatingString;
- (NSString *)getPageCountString;

@end

//
//  DetailViewModel.m
//  Stall
//
//  Created by Inti Guo on 10/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import "DetailViewModel.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation DetailViewModel

- (NSString *)getPubdateString {
    return [NSDateFormatter localizedStringFromDate:self.book.pubdate
                                          dateStyle:NSDateFormatterShortStyle
                                          timeStyle:NSDateFormatterNoStyle];
}

- (NSString *)getRatingString {
    NSInteger ratingRounded = (NSInteger)(self.book.rating / 2);
    
    NSString *s = [NSString stringWithFormat:@"%.1f ", self.book.rating];
    for (NSInteger i = 0; i < ratingRounded; i += 1) {
        s = [s stringByAppendingString:@"★"];
    }
    for (NSInteger i = 0; i < 5 - ratingRounded; i +=1) {
        s = [s stringByAppendingString:@"☆"];
    }
    
    return s;
}

- (NSString *)getPageCountString {
    return [NSString stringWithFormat:@"%lld", self.book.pages];
}

@end

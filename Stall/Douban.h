//
//  Douban.h
//  Stall
//
//  Created by Inti Guo on 09/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const ERROR_ON_FETCH;

@interface Douban : NSObject

- (void)fetchBookValueForISBN:(NSString *)isbn;

@end

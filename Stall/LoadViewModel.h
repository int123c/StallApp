//
//  LoadViewModel.h
//  Stall
//
//  Created by Inti Guo on 09/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoadViewModel : NSObject

@property (nonatomic, copy) NSString * currentISBN;

- (void)fetchBookInfo;

@end

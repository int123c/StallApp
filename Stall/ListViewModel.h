//
//  ListViewModel.h
//  Stall
//
//  Created by Inti Guo on 09/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListViewModel : NSObject

@property (nonatomic, copy) NSArray *bookList;

- (NSInteger)numberOfBooks;

@end

//
//  LoadViewModel.m
//  Stall
//
//  Created by Inti Guo on 09/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import "LoadViewModel.h"
#import "Douban.h"

@implementation LoadViewModel

- (void)fetchBookInfo {
    Douban *douban = [[Douban alloc] init];
    [douban fetchBookValueForISBN:_currentISBN];
}

- (void)handleSuccess:(NSNotification *)notification {
    self.state = LoadingViewStateFinished;
}

- (void)handleFailure:(NSNotification *)notification {
    if (notification.name == ERROR_BOOK_NOT_FOUND) {
        self.state = LoadingViewStateBookNotFound;
    } else if (notification.name == ERROR_BOOK_ALREADY_EXIST) {
        self.state = LoadingViewStateExist;
    }else {
        self.state = LoadingViewStateError;
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [NSNotificationCenter.defaultCenter addObserver:self
                                               selector:@selector(handleSuccess:)
                                                   name:SUCCESS_ON_FETCH object:nil];
        [NSNotificationCenter.defaultCenter addObserver:self
                                               selector:@selector(handleFailure:)
                                                   name:ERROR_ON_FETCH object:nil];
        [NSNotificationCenter.defaultCenter addObserver:self
                                               selector:@selector(handleFailure:)
                                                   name:ERROR_ON_IMAGE_DOWNLOAD object:nil];
        [NSNotificationCenter.defaultCenter addObserver:self
                                               selector:@selector(handleFailure:)
                                                   name:ERROR_BOOK_NOT_FOUND object:nil];
        [NSNotificationCenter.defaultCenter addObserver:self
                                               selector:@selector(handleFailure:)
                                                   name:ERROR_BOOK_ALREADY_EXIST object:nil];
        self.state = LoadingViewStateLoading;
    }
    return self;
}

- (void)dealloc
{
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

@end

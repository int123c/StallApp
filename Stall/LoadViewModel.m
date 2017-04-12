//
//  LoadViewModel.m
//  Stall
//
//  Created by Inti Guo on 09/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import "LoadViewModel.h"
#import "Douban.h"
#import <MagicalRecord/MagicalRecord.h>

@interface LoadViewModel()

@property (strong, nonatomic) NSTimer *timer;

@end

@implementation LoadViewModel

- (void)fetchBookInfo {
    Douban *douban = [Douban new];
    [douban fetchBookValueForISBN:self.currentISBN];
}

- (void)setupTimer {
    self.timesup = NO;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(onTimerFire:) userInfo:NULL repeats:NO];
}

- (void)onTimerFire:(NSTimer *)timer {
    self.timesup = YES;
}

- (void)handleSuccess:(NSNotification *)notification {
    self.book = [Book MR_findFirstByAttribute:@"isbn" withValue:self.currentISBN];
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

- (void)setupObservers {
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
}

- (void)removeObservers {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.state = LoadingViewStateLoading;
    }
    return self;
}

@end

//
//  LoadViewModel.h
//  Stall
//
//  Created by Inti Guo on 09/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LoadingViewState) {
    LoadingViewStateLoading,
    LoadingViewStateBookNotFound,
    LoadingViewStateError,
    LoadingViewStateFinished,
    LoadingViewStateExist
};

@interface LoadViewModel : NSObject

@property (nonatomic, copy) NSString * currentISBN;
@property (nonatomic) LoadingViewState state;

- (void)fetchBookInfo;

@end

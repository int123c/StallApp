//
//  ListViewController.h
//  Stall
//
//  Created by Inti Guo on 06/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListViewModel.h"

@interface ListViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, strong) ListViewModel *viewModel;

@end


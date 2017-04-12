//
//  LoadViewController.h
//  Stall
//
//  Created by Inti Guo on 10/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadViewModel.h"

@interface LoadViewController : UIViewController

@property (nonatomic, strong) LoadViewModel *viewModel;
@property (nonatomic, strong) NSString *currentISBN;

@end

//
//  STNavigationBar.h
//  Stall
//
//  Created by Inti Guo on 11/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface STNavigationBar : UIView

@property (strong, nonatomic) UIView *leftActionView;
@property (strong, nonatomic) UIView *rightActionView;
@property (strong, nonatomic) NSString *title;

@end

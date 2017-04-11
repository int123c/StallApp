//
//  STNavigationBar.m
//  Stall
//
//  Created by Inti Guo on 11/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import "STNavigationBar.h"

@interface STNavigationBar()

@property (strong, nonatomic) IBInspectable UILabel *titleLabel;
@property (strong, nonatomic, readonly) UIControl *leftActionView;
@property (strong, nonatomic, readonly) UIControl *rightActionView;
@property (nonatomic, copy, readonly) void (^leftAction)(void);
@property (nonatomic, copy, readonly) void (^rightAction)(void);

@end

@implementation STNavigationBar

- (void)setup {
    self.backgroundColor = UIColor.whiteColor;
    
    self.titleLabel = [UILabel new];
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    self.titleLabel.textColor = UIColor.blackColor;
    [self addSubview:self.titleLabel];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.titleLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor] setActive:YES];
    [[self.titleLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor] setActive:YES];
}

- (void)setLeftActionView:(UIControl *)leftActionView {
    [_leftActionView removeFromSuperview];
    _leftActionView = leftActionView;
    [[leftActionView.centerYAnchor constraintEqualToAnchor:self.titleLabel.centerYAnchor] setActive:YES];
    [[leftActionView.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:8] setActive:YES];
}

- (void)setRightActionView:(UIControl *)rightActionView {
    [_rightActionView removeFromSuperview];
    _rightActionView = rightActionView;
    [self addSubview:rightActionView];
    rightActionView.translatesAutoresizingMaskIntoConstraints = NO;
    [[rightActionView.centerYAnchor constraintEqualToAnchor:self.titleLabel.centerYAnchor] setActive:YES];
    [[rightActionView.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:8] setActive:YES];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

@end

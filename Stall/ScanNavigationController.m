//
//  ScanNavigationController.m
//  Stall
//
//  Created by Inti Guo on 11/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import "ScanNavigationController.h"
#import "STNavigationBar.h"
#import "STBackButton.h"

@interface ScanNavigationController ()

@property (strong, nonatomic) STNavigationBar *naviBar;
@property (strong, nonatomic) UIButton *backButton;

@end

@implementation ScanNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarHidden:YES];
    self.naviBar = [STNavigationBar new];
    self.naviBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.naviBar];
    [[self.naviBar.topAnchor constraintEqualToAnchor:self.view.topAnchor] setActive:YES];
    [[self.naviBar.widthAnchor constraintEqualToAnchor:self.view.widthAnchor] setActive:YES];
    [[self.naviBar.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor] setActive:YES];
    [[self.naviBar.heightAnchor constraintEqualToConstant:64] setActive:YES];
    self.naviBar.title = @"Scan";
    
    self.backButton = [UIButton new];

    [self.backButton setTitle:@"← Stall" forState:UIControlStateNormal];
    [self.backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.backButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [self.backButton addTarget:self action:@selector(onBackButtonTap) forControlEvents:UIControlEventTouchUpInside];
    self.naviBar.leftActionView = self.backButton;
}

- (void)onBackButtonTap {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}

@end

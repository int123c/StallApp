//
//  STVectorButton.m
//  Stall
//
//  Created by Inti Guo on 11/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import "STVectorButton.h"

@interface STVectorButton()

@property (strong, nonatomic) UIImageView *icon;

@end

@implementation STVectorButton

+ (instancetype)buttonWithVectorIconFileName:(NSString *)name frame:(CGRect)frame {
    STVectorButton *button = [[STVectorButton alloc] initWithFrame:CGRectZero];
    button.fileName = name;
    
    UIImage *i = [UIImage imageNamed:name];
    button.icon = [[UIImageView alloc] initWithImage:i];
    [button setFrame:CGRectMake(0, 0, i.size.width, i.size.height)];
    
    [button addSubview:button.icon];
    button.icon.translatesAutoresizingMaskIntoConstraints = NO;
    [[button.icon.topAnchor constraintEqualToAnchor:button.topAnchor] setActive:YES];
    [[button.icon.leftAnchor constraintEqualToAnchor:button.leftAnchor] setActive:YES];
    [[button.icon.rightAnchor constraintEqualToAnchor:button.rightAnchor] setActive:YES];
    [[button.icon.bottomAnchor constraintEqualToAnchor:button.bottomAnchor] setActive:YES];
    
    return button;
}

@end

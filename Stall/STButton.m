//
//  STVectorButton.m
//  Stall
//
//  Created by Inti Guo on 11/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import "STButton.h"

@interface STButton()

@property (strong, nonatomic) UIImageView *icon;

@end

@implementation STButton

+ (instancetype)buttonWithIconName:(NSString *)name {
    UIImage *i = [UIImage imageNamed:name];
    
    STButton *button = [[STButton alloc] initWithFrame:CGRectMake(0, 0, i.size.width, i.size.height)];
    button.name = name;
    
    button.icon = [[UIImageView alloc] initWithImage:i];
    
    [button addSubview:button.icon];
    button.icon.translatesAutoresizingMaskIntoConstraints = NO;
    [[button.icon.topAnchor constraintEqualToAnchor:button.topAnchor] setActive:YES];
    [[button.icon.leftAnchor constraintEqualToAnchor:button.leftAnchor] setActive:YES];
    [[button.icon.rightAnchor constraintEqualToAnchor:button.rightAnchor] setActive:YES];
    [[button.icon.bottomAnchor constraintEqualToAnchor:button.bottomAnchor] setActive:YES];
    
    return button;
}

@end

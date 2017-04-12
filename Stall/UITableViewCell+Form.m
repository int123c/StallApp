//
//  UITableViewCell+Form.m
//  Stall
//
//  Created by Inti Guo on 12/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import "UITableViewCell+Form.h"

@implementation UITableViewCell (Form)

+ (UITableViewCell *)formCellWithTitle:(NSString *)title value:(NSString *)value {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NULL];
    cell.textLabel.text = title;
    cell.detailTextLabel.text = value;
    
    return cell;
}

@end

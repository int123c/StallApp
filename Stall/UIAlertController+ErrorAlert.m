//
//  UIAlertController+ErrorAlert.m
//  Stall
//
//  Created by Inti Guo on 10/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import "UIAlertController+ErrorAlert.h"

@implementation UIAlertController (ErrorAlert)

+ (UIAlertController *)errorAlertWithMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NULL message:@"Book not found." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *handler){
        [alert dismissViewControllerAnimated:YES completion:NULL];
    }];
    
    [alert addAction:ok];
    return alert;
}

@end

//
//  UIAlertController+ErrorAlert.m
//  Stall
//
//  Created by Inti Guo on 10/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import "UIAlertController+ErrorAlert.h"

@implementation UIAlertController (ErrorAlert)

+ (instancetype)errorAlertWithMessage:(NSString *)message completion:(void (^ __nullable)())completionHandler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NULL message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *handler){
        [alert dismissViewControllerAnimated:YES completion:NULL];
        if (completionHandler != NULL) {
            completionHandler();
        }
    }];
    
    [alert addAction:ok];
    return alert;
}

@end

//
//  UIAlertController+ErrorAlert.h
//  Stall
//
//  Created by Inti Guo on 10/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (ErrorAlert)

+ (instancetype _Nonnull)errorAlertWithMessage:(NSString * _Nonnull)message completion:(void (^ __nullable)())completionHandler;

@end

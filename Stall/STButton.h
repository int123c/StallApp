//
//  STVectorButton.h
//  Stall
//
//  Created by Inti Guo on 11/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STButton : UIControl

@property (strong, nonatomic) NSString * fileName;

+ (instancetype)buttonWithVectorIconFileName:(NSString *)name frame:(CGRect)frame;

@end

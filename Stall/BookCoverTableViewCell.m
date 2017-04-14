//
//  BookCoverTableViewCell.m
//  Stall
//
//  Created by Inti Guo on 11/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import "BookCoverTableViewCell.h"
#import "BookView.h"

@interface BookCoverTableViewCell ()

@property (strong, nonatomic) BookView *bookView;
@property (strong, nonatomic) UIView *backdrop;

@end

@implementation BookCoverTableViewCell

- (UIColor *)backdropColorNormal { return [UIColor colorWithRed:247.0/255 green:247.0/255 blue:247.0/255 alpha:1]; }
- (UIColor *)backdropColorSelected { return [UIColor colorWithRed:226.0/255 green:234.0/255 blue:218.0/255 alpha:1]; }
- (UIColor *)backdropColorLiked { return [UIColor colorWithRed:255.0/255 green:233.0/255 blue:233.0/255 alpha:1]; }

- (void)setup {
    self.backdrop = [UIView new];
    self.backdrop.backgroundColor = [self backdropColorNormal];
    [self.contentView addSubview:self.backdrop];
    self.backdrop.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.backdrop.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor] setActive:YES];
    [[self.backdrop.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:20] setActive:YES];
    [[self.backdrop.widthAnchor constraintEqualToConstant:270] setActive:YES];
    [[self.backdrop.heightAnchor constraintEqualToConstant:180] setActive:YES];
    
    self.bookView = [BookView new];
    [self.contentView addSubview:self.bookView];
    self.bookView.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.bookView.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:20] setActive:YES];
    [[self.bookView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:40] setActive:YES];
    [[self.bookView.widthAnchor constraintEqualToConstant:200] setActive:YES];
    [[self.bookView.heightAnchor constraintEqualToConstant:200] setActive:YES];
    
    self.backdrop.transform = CGAffineTransformMakeTranslation(-300, 0);
    self.bookView.transform = CGAffineTransformMakeTranslation(-300, 0);
}

- (void)animateIn {
    [UIView animateWithDuration:0.4 animations:^(){
        self.backdrop.transform = CGAffineTransformIdentity;
    }];
    [UIView animateWithDuration:0.4 delay:0.1 options:0 animations:^() {
        self.bookView.transform = CGAffineTransformIdentity;
    } completion:NULL];
}

- (void)applyBook:(Book *)book {
    NSURL *baseurl = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:false error:nil];
    NSURL *url = [baseurl URLByAppendingPathComponent:book.cover];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    [self layoutIfNeeded];
    self.bookView.cover = image;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end

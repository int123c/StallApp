//
//  BookCollectionViewCell.m
//  Stall
//
//  Created by Inti Guo on 11/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import "BookCollectionViewCell.h"
#import "BookView.h"

@interface BookCollectionViewCell()

@property (strong, nonatomic) BookView *bookView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIView *backdrop;
@property (strong, nonatomic) UIView *bookWrapper;

@end

@implementation BookCollectionViewCell

- (UIColor *)backdropColorNormal { return [UIColor colorWithRed:247.0/255 green:247.0/255 blue:247.0/255 alpha:1]; }
- (UIColor *)backdropColorSelected { return [UIColor colorWithRed:226.0/255 green:234.0/255 blue:218.0/255 alpha:1]; }
- (UIColor *)backdropColorLiked { return [UIColor colorWithRed:255.0/255 green:233.0/255 blue:233.0/255 alpha:1]; }

- (void)setup {
    self.backdrop = [UIView new];
    self.backdrop.backgroundColor = [self backdropColorNormal];
    [self.contentView addSubview:self.backdrop];
    self.backdrop.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.backdrop.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor] setActive:YES];
    [[self.backdrop.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor] setActive:YES];
    [[self.backdrop.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor multiplier:144.0/180] setActive:YES];
    [[self.backdrop.heightAnchor constraintEqualToAnchor:self.contentView.heightAnchor multiplier:68.0/180] setActive:YES];
    
    self.bookWrapper = [BookView new];
    [self.contentView addSubview:self.bookWrapper];
    self.bookWrapper.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.bookWrapper.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor] setActive:YES];
    [[self.bookWrapper.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor] setActive:YES];
    [[self.bookWrapper.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor multiplier:16.0/18] setActive:YES];
    [[self.bookWrapper.heightAnchor constraintEqualToAnchor:self.contentView.heightAnchor multiplier:16.0/18] setActive:YES];
    
    self.bookView = [BookView new];
    [self.bookWrapper addSubview:self.bookView];
    self.bookView.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.bookView.centerXAnchor constraintEqualToAnchor:self.bookWrapper.centerXAnchor] setActive:YES];
    [[self.bookView.topAnchor constraintEqualToAnchor:self.bookWrapper.topAnchor constant:10] setActive:YES];
    [[self.bookView.widthAnchor constraintEqualToAnchor:self.bookWrapper.widthAnchor multiplier:12.0/16] setActive:YES];
    [[self.bookView.heightAnchor constraintEqualToAnchor:self.bookWrapper.heightAnchor multiplier:12.0/16] setActive:YES];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    self.titleLabel.textColor = [UIColor colorWithRed:106/255.0 green:106/255.0 blue:106/255.0 alpha:1];
    [self.bookWrapper addSubview:self.titleLabel];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.titleLabel.centerXAnchor constraintEqualToAnchor:self.bookWrapper.centerXAnchor] setActive:YES];
    [[self.titleLabel.bottomAnchor constraintEqualToAnchor:self.bookWrapper.bottomAnchor constant:8] setActive:YES];
}

- (void)applyBook:(Book *)book {
    NSURL *url = [NSURL URLWithString:book.cover];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    [self layoutIfNeeded];
    self.bookView.cover = image;
    self.titleLabel.text = book.title;
}


#pragma mark - Initializers

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self != NULL) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != NULL) {
        [self setup];
    }
    return self;
}

@end

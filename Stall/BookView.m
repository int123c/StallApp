//
//  BookView.m
//  Stall
//
//  Created by Inti Guo on 11/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import "BookView.h"

@interface BookView()

@property (strong, nonatomic) CALayer * coverLayer;
@property (strong, nonatomic) CAShapeLayer * cropLayer;
@property (strong, nonatomic) CALayer * highlightLayer;
@property (strong, nonatomic) CAGradientLayer * darkenLayer;
@property (strong, nonatomic) CAGradientLayer * reflectionLayer;
@property (strong, nonatomic) CAGradientLayer * innerShadowLayer;
//@property (strong, nonatomic) CAShapeLayer * shadowLayer;

@property (strong, nonatomic) CALayer *bookLayer;

@end

@implementation BookView

static void * observerContext = &observerContext;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != NULL) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.bookLayer = [CALayer new];
    self.bookLayer.frame = self.layer.bounds;
    self.bookLayer.shadowColor = [[UIColor blackColor] CGColor];
    self.bookLayer.shadowOffset = CGSizeMake(-1, 3);
    self.bookLayer.shadowRadius = 2;
    [self.layer addSublayer:self.bookLayer];
    
    self.cropLayer = [CAShapeLayer new];
    [self.bookLayer setMask:self.cropLayer];
    [self.bookLayer setMasksToBounds:YES];
    
    self.coverLayer = [CALayer new];
    self.coverLayer.frame = self.bounds;
    [self.bookLayer addSublayer:self.coverLayer];
    
    self.highlightLayer = [CALayer new];
    self.highlightLayer.backgroundColor = ([[UIColor colorWithWhite:1 alpha:0.4] CGColor]);
    [self.bookLayer addSublayer:self.highlightLayer];
    
    self.darkenLayer = [CAGradientLayer new];
    self.darkenLayer.colors = @[[UIColor colorWithWhite:0 alpha:0.1], [UIColor colorWithWhite:0 alpha:30]];
    self.darkenLayer.startPoint = CGPointMake(0, 0);
    self.darkenLayer.endPoint = CGPointMake(1, 1);
    [self.bookLayer addSublayer:self.darkenLayer];
    
    self.reflectionLayer = [CAGradientLayer new];
    self.reflectionLayer.colors = @[[UIColor colorWithWhite:0.8 alpha:0.18], [UIColor colorWithWhite:1 alpha:0.3]];
    self.reflectionLayer.startPoint = CGPointMake(0, 0.5);
    self.reflectionLayer.endPoint = CGPointMake(1, 0.3);
    [self.bookLayer addSublayer:self.reflectionLayer];
    
    self.innerShadowLayer = [CAGradientLayer new];
    self.innerShadowLayer.colors = @[[UIColor colorWithWhite:0 alpha:0], [UIColor colorWithWhite:0 alpha:0.1]];
    self.innerShadowLayer.startPoint = CGPointMake(0, 0);
    self.innerShadowLayer.endPoint = CGPointMake(1, 1);
    [self.bookLayer addSublayer:self.innerShadowLayer];
}

- (void)setCover:(UIImage *)cover {
    if (_cover == cover) { return; }
    _cover = cover;
    [self regenerate];
}

- (void)regenerate {
    if (self.cover == NULL) { return; }
    
    CGSize coverSize = self.cover.size;
    CGSize wrapperSize = self.frame.size;
    CGFloat ratio = MIN(coverSize.width / wrapperSize.width, coverSize.height / wrapperSize.height);
    coverSize = CGSizeMake(coverSize.width * ratio, coverSize.height * ratio);
    
    // set bookLayer
    CGFloat bookX = (wrapperSize.width - coverSize.width) / 2;
    CGFloat bookY = (wrapperSize.height - coverSize.height) / 2;
    
    self.bookLayer.frame = CGRectMake(bookX, bookY, coverSize.width, coverSize.height);
    
    // set coverLayer
    self.coverLayer.frame = CGRectMake(0, 0, coverSize.width, coverSize.height);
    self.coverLayer.contents = (id)self.cover;
    
    // set textures
    self.highlightLayer.frame = CGRectMake(3, 0, 2, coverSize.height);
    self.darkenLayer.frame = CGRectMake(0, 0, 3, coverSize.height);
    self.reflectionLayer.frame = CGRectMake(5, 0, coverSize.width - 5, coverSize.height);
    self.innerShadowLayer.frame = CGRectMake(0, coverSize.height - 2, coverSize.width, 2);
}

@end

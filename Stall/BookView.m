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
@property (strong, nonatomic) CALayer * lightLayer;
@property (strong, nonatomic) CAGradientLayer * darkenLayer;
@property (strong, nonatomic) CAGradientLayer * reflectionLayer;
@property (strong, nonatomic) CAGradientLayer * innerShadowLayer;
@property (strong, nonatomic) CALayer * shadowLayer;

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
    self.shadowLayer = [CALayer new];
    self.shadowLayer.frame = CGRectZero;
    self.shadowLayer.backgroundColor = [[UIColor clearColor] CGColor];
    self.shadowLayer.shadowColor = [[UIColor colorWithRed:160.0/255 green:160.0/255 blue:160.0/255 alpha:1] CGColor];
    self.shadowLayer.shadowOffset = CGSizeMake(-1, 3);
    self.shadowLayer.shadowRadius = 4;
    self.shadowLayer.shadowOpacity = 1;
    [self.layer addSublayer:self.shadowLayer];
    
    self.bookLayer = [CALayer new];
    self.bookLayer.frame = CGRectZero;
    [self.layer addSublayer:self.bookLayer];
    
    self.cropLayer = [CAShapeLayer new];
    self.cropLayer.frame = CGRectZero;
    [self.bookLayer setMask:self.cropLayer];
    [self.bookLayer setMasksToBounds:YES];
    
    self.coverLayer = [CALayer new];
    self.coverLayer.frame = CGRectZero;
    self.coverLayer.backgroundColor = [[[UIColor redColor] colorWithAlphaComponent:0.5] CGColor];
    [self.bookLayer addSublayer:self.coverLayer];
    
    self.reflectionLayer = [CAGradientLayer new];
    self.reflectionLayer.frame = CGRectZero;
    self.reflectionLayer.colors = @[(__bridge id)[[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.18] CGColor], (__bridge id)[[UIColor colorWithWhite:1 alpha:0.3] CGColor]];
    self.reflectionLayer.startPoint = CGPointMake(0, 0.5);
    self.reflectionLayer.endPoint = CGPointMake(1, 0.3);
    [self.bookLayer addSublayer:self.reflectionLayer];
    
    self.highlightLayer = [CALayer new];
    self.highlightLayer.frame = CGRectZero;
    self.highlightLayer.backgroundColor = ([[UIColor colorWithWhite:1 alpha:0.4] CGColor]);
    [self.bookLayer addSublayer:self.highlightLayer];
    
    self.lightLayer = [CALayer new];
    self.lightLayer.frame = CGRectZero;
    self.lightLayer.backgroundColor = ([[UIColor colorWithWhite:1 alpha:0.3] CGColor]);
    [self.bookLayer addSublayer:self.lightLayer];
    
    self.darkenLayer = [CAGradientLayer new];
    self.darkenLayer.frame = CGRectZero;
    self.darkenLayer.colors = @[(__bridge id)[[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor], (__bridge id)[[[UIColor blackColor] colorWithAlphaComponent:0.24] CGColor]];
    self.darkenLayer.startPoint = CGPointMake(0, 0.5);
    self.darkenLayer.endPoint = CGPointMake(1, 0.5);
    [self.bookLayer addSublayer:self.darkenLayer];
    
    self.innerShadowLayer = [CAGradientLayer new];
    self.innerShadowLayer.frame = CGRectZero;
    self.innerShadowLayer.colors = @[(__bridge id)[[[UIColor blackColor] colorWithAlphaComponent:0] CGColor], (__bridge id)[[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor]];
    self.innerShadowLayer.startPoint = CGPointMake(0.5, 0);
    self.innerShadowLayer.endPoint = CGPointMake(0.5, 1);
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
    CGFloat ratio = MIN(wrapperSize.width / coverSize.width, wrapperSize.height / coverSize.height);
    coverSize = CGSizeMake(coverSize.width * ratio, coverSize.height * ratio);
    UIImage *new = [UIImage imageWithCGImage:[self.cover CGImage] scale:ratio orientation:UIImageOrientationUp];
    // set bookLayer
    CGFloat bookX = (wrapperSize.width - coverSize.width) / 2;
    CGFloat bookY = (wrapperSize.height - coverSize.height) / 2;
    
    self.bookLayer.frame = CGRectMake(bookX, bookY, coverSize.width, coverSize.height);
    
    // set coverLayer
    self.coverLayer.frame = CGRectMake(0, 0, coverSize.width, coverSize.height);
    self.cropLayer.frame = CGRectMake(0, 0, coverSize.width, coverSize.height);
    UIBezierPath *path = [UIBezierPath new];
    [path addArcWithCenter:CGPointMake(3, 3) radius:3 startAngle:M_PI
                  endAngle:M_PI*3/2 clockwise:YES];
    [path addArcWithCenter:CGPointMake(coverSize.width-1, 1) radius:1 startAngle:M_PI*3/2
                  endAngle:0 clockwise:YES];
    [path addArcWithCenter:CGPointMake(coverSize.width-1, coverSize.height-1) radius:1 startAngle:0
                  endAngle:M_PI/2 clockwise:YES];
    [path addArcWithCenter:CGPointMake(3, coverSize.height-3) radius:3 startAngle:M_PI/2
                  endAngle:M_PI clockwise:YES];
    self.cropLayer.path = [path CGPath];
    self.bookLayer.shadowPath = [path CGPath];
    self.coverLayer.contents = (id)new.CGImage;
    
    // set textures
    self.highlightLayer.frame = CGRectMake(3, 0, 2, coverSize.height);
    self.lightLayer.frame = CGRectMake(coverSize.width - 1, 0, 1, coverSize.height);
    self.darkenLayer.frame = CGRectMake(0, 0, 3, coverSize.height);
    self.reflectionLayer.frame = CGRectMake(5, 0, coverSize.width - 5, coverSize.height);
    self.innerShadowLayer.frame = CGRectMake(0, coverSize.height - 2, coverSize.width, 2);
    
    // set shadow
    self.shadowLayer.frame = CGRectMake(bookX, bookY, coverSize.width, coverSize.height);
    self.shadowLayer.shadowPath = [path CGPath];
}

@end

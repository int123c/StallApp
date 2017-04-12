//
//  LoadViewController.m
//  Stall
//
//  Created by Inti Guo on 10/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import "LoadViewController.h"
#import "Douban.h"
#import "UIAlertController+ErrorAlert.h"

@interface LoadViewController()

@property (weak, nonatomic) IBOutlet UIView *barcodeView;
@property (weak, nonatomic) IBOutlet UIView *bookView;
@property (weak, nonatomic) IBOutlet UIView *laser;
@property (weak, nonatomic) IBOutlet UILabel *isbnLabel;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation LoadViewController

static void * observerContext = &observerContext;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.viewModel setupTimer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.viewModel addObserver:self
                     forKeyPath:@"state"
                        options:NSKeyValueObservingOptionNew
                        context:observerContext];
    [self.viewModel addObserver:self
                     forKeyPath:@"timesup"
                        options:NSKeyValueObservingOptionNew
                        context:observerContext];
    [self.viewModel setupObservers];
    [self.isbnLabel setText:self.viewModel.currentISBN];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.viewModel fetchBookInfo];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animation.fromValue = [NSNumber numberWithDouble:0];
    animation.toValue = [NSNumber numberWithDouble:self.barcodeView.frame.size.height];
    animation.duration = 0.8;
    animation.autoreverses = true;
    animation.repeatCount = 100;
    [self.laser.layer addAnimation:animation forKey:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if (context == observerContext) {
        if (!self.viewModel.timesup) { return; }
        
        switch (self.viewModel.state) {
            case LoadingViewStateFinished: {
                [UIView animateWithDuration:0.1 animations:^(){
                    self.barcodeView.alpha = 0;
                }];
                break;
            }
            case LoadingViewStateLoading: {
                break;
            }
            case LoadingViewStateError: {
                UIAlertController *alert = [UIAlertController errorAlertWithMessage: @"Error in fetching book data." completion:NULL];
                [self presentViewController:alert animated:YES completion:NULL];
                break;
            }
            case LoadingViewStateBookNotFound: {
                UIAlertController *alert = [UIAlertController errorAlertWithMessage: @"Book not found." completion:NULL];
                [self presentViewController:alert animated:YES completion:NULL];
                break;
            }
            case LoadingViewStateExist: {
                UIAlertController *alert = [UIAlertController errorAlertWithMessage: @"Book already exist." completion:NULL];
                [self presentViewController:alert animated:YES completion:NULL];
                break;
            }
        }
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.viewModel removeObserver:self forKeyPath:@"state"];
    [self.viewModel removeObserver:self forKeyPath:@"timesup"];
    [self.viewModel removeObservers];
    [super viewWillDisappear:animated];
}

- (void)setup {
    self.viewModel = [LoadViewModel new];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}
                              
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

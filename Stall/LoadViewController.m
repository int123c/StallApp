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


@end

@implementation LoadViewController

static void * observerContext = &observerContext;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [LoadViewModel new];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.viewModel addObserver:self
                     forKeyPath:@"state"
                        options:NSKeyValueObservingOptionNew
                        context:observerContext];
    [self.viewModel setupObservers];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.viewModel fetchBookInfo];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if (context == observerContext) {
        
        switch (self.viewModel.state) {
            case LoadingViewStateFinished: {
                // show book
                break;
            }
            case LoadingViewStateLoading: {
                // show barcode animation
                break;
            }
            case LoadingViewStateError: {
                UIAlertController *alert = [UIAlertController errorAlertWithMessage: @"Error in fetching book data."];
                [self presentViewController:alert animated:YES completion:NULL];
                break;
            }
            case LoadingViewStateBookNotFound: {
                UIAlertController *alert = [UIAlertController errorAlertWithMessage: @"Book not found."];
                [self presentViewController:alert animated:YES completion:NULL];
                break;
            }
            case LoadingViewStateExist: {
                UIAlertController *alert = [UIAlertController errorAlertWithMessage: @"Book already exist."];
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
    [self.viewModel removeObservers];
    [super viewWillDisappear:animated];
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

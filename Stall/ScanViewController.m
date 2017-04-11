//
//  ScanViewController.m
//  Stall
//
//  Created by Inti Guo on 10/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import "ScanViewController.h"
#import <MTBBarcodeScanner/MTBBarcodeScanner.h>
#import "LoadViewController.h"
#import "UIAlertController+ErrorAlert.h"

@interface ScanViewController ()

@property (nonatomic, strong) MTBBarcodeScanner *scanner;
@property (weak, nonatomic) IBOutlet UIView *scannerView;
@property (nonatomic, strong) NSString *isbn;

@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scanner = [[MTBBarcodeScanner alloc] initWithMetadataObjectTypes:@[AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code] previewView:self.scannerView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [MTBBarcodeScanner requestCameraPermissionWithSuccess:^(BOOL success) {
        if (success) {
            NSError *error = nil;
            [self.scanner startScanningWithResultBlock:^(NSArray *codes) {
                AVMetadataMachineReadableCodeObject *code = [codes firstObject];
                NSLog(@"Found code: %@", code.stringValue);
                [self.scanner stopScanning];
                
                __weak ScanViewController *weakSelf = self;
                [weakSelf presentLoadView];
                
            } error:&error];
            
        } else {
            UIAlertController *alert = [UIAlertController errorAlertWithMessage:@"The app requires camera access to work, please turn it on in setting" completion:^(){
                __weak ScanViewController *weakSelf = self;
                [weakSelf dismissViewControllerAnimated:YES completion:NULL];
            }];
            [self presentViewController:alert animated:YES completion:NULL];
        }
    }];
}

- (void)presentLoadView {
    [self performSegueWithIdentifier:@"SHOW_LOAD_VIEW" sender:self];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[LoadViewController class]]) {
        LoadViewController *loadViewController = segue.destinationViewController;
        loadViewController.viewModel.currentISBN = self.isbn;
    }
}


@end

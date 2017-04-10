//
//  ScanViewController.m
//  Stall
//
//  Created by Inti Guo on 10/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import "ScanViewController.h"
#import "ScanViewModel.h"
#import <MTBBarcodeScanner/MTBBarcodeScanner.h>

@interface ScanViewController ()

@property (nonatomic, strong) ScanViewModel *viewModel;
@property (nonatomic, strong) MTBBarcodeScanner *scanner;

@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scanner = [[MTBBarcodeScanner alloc] initWithMetadataObjectTypes:@[AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code] previewView:self.view];
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
            // The user denied access to the camera
        }
    }];
}

- (void)presentLoadView {
    
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

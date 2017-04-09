//
//  Douban.m
//  Stall
//
//  Created by Inti Guo on 09/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import "Douban.h"
#import <AFNetworking/AFNetworking.h>
#import "BookValue.h"

NSString * const ERROR_ON_FETCH = @"ERROR_ON_FETCH";
NSString * const ERROR_ON_IMAGE_DOWNLOAD = @"ERROR_ON_IMAGE_DOWNLOAD";
NSString * const SUCCESS_ON_FETCH = @"SUCCESS_ON_FETCH";

@implementation Douban

- (void)fetchBookValueForISBN:(NSString *)isbn {
    NSString *url = [NSString stringWithFormat:@"https://api.douban.com/v2/book/isbn/:%@", isbn];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [manager GET:url parameters:nil progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             
             NSLog(@"%@", responseObject);
             if ([responseObject isKindOfClass:[NSDictionary class]]) {
                 NSDictionary *json = responseObject;
                 NSDictionary *images = json[@"images"];
                 NSString *url = images[@"large"];
                 if (url == nil) { url = images[@"medium"]; }
                 if (url == nil) { url = images[@"small"]; }
                 [self fetchBookCoverAtURL:url underJSON:json isbn:isbn];
             }
             
         } failure:^(NSURLSessionTask *operation, NSError *error) {
             [self postErrorNotificationWithName:ERROR_ON_FETCH];
         }];
}

- (void)fetchBookCoverAtURL:(NSString *)urlString underJSON:(NSDictionary *)json isbn:(NSString *)isbn {
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:nil
        destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
            
            NSURL *documentsDirectoryURL =
                [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory
                                                       inDomain:NSUserDomainMask
                                              appropriateForURL:nil
                                                         create:NO
                                                          error:nil];
            
            return [documentsDirectoryURL URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg", isbn]];
            
        } completionHandler:^(NSURLResponse *respone, NSURL *filePath, NSError *error) {
            
            if (error != nil) {
                NSLog(@"Error: %@", error);
                [self postErrorNotificationWithName:ERROR_ON_IMAGE_DOWNLOAD];
            } else {
                [self postSuccessNitificationWithJson:json coverURL:filePath];
            }
            
        }];
    
    [task resume];
}

- (void)postSuccessNitificationWithJson:(NSDictionary *)json coverURL:(NSURL *)cover {
    BookValue *value = [[BookValue alloc] initWithJSON:json coverURL:cover.absoluteString];
    [[NSNotificationCenter defaultCenter] postNotificationName:SUCCESS_ON_FETCH
                                                        object:self
                                                      userInfo:@{@"value" : value}];
}

- (void)postErrorNotificationWithName:(NSString *)name {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil];
}

@end

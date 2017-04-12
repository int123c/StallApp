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
#import <MagicalRecord/MagicalRecord.h>
#import "Book+Stall.h"

NSString * const ERROR_ON_FETCH = @"ERROR_ON_FETCH";
NSString * const ERROR_ON_IMAGE_DOWNLOAD = @"ERROR_ON_IMAGE_DOWNLOAD";
NSString * const ERROR_ON_SAVE = @"ERROR_ON_SAVE";
NSString * const ERROR_BOOK_NOT_FOUND = @"ERROR_BOOK_NOT_FOUND";
NSString * const ERROR_BOOK_ALREADY_EXIST = @"ERROR_BOOK_ALREADY_EXIST";
NSString * const SUCCESS_ON_FETCH = @"SUCCESS_ON_FETCH";

@implementation Douban

- (void)fetchBookValueForISBN:(NSString *)isbn {
    if ([self isbnAlreadyExist:isbn]) {
        [NSNotificationCenter.defaultCenter postNotificationName:ERROR_BOOK_ALREADY_EXIST object:self];
        return;
    }
    
    if ([isbn length] == 0) {
        NSLog(@"No ISBN found.");
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"https://api.douban.com/v2/book/isbn/:%@", isbn];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [manager GET:url parameters:nil progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {

             if ([responseObject isKindOfClass:[NSDictionary class]]) {
                 NSDictionary *json = responseObject;
                 
                 NSNumber *errorCode = json[@"code"];
                 if (errorCode.integerValue == 6000) {
                     [self postErrorNotificationWithName:ERROR_BOOK_NOT_FOUND];
                     return;
                 }
                 
                 NSDictionary *images = json[@"images"];
                 NSString *url = images[@"large"];
                 if (url == nil) { url = images[@"medium"]; }
                 if (url == nil) { url = images[@"small"]; }
                 [self fetchBookCoverAtURL: url underJSON:json isbn:isbn];
             }
             
         } failure:^(NSURLSessionTask *operation, NSError *error) {
             [self postErrorNotificationWithName:ERROR_ON_FETCH];
         }];
}

- (BOOL)isbnAlreadyExist:(NSString *)isbn {
    Book *exist = [Book MR_findFirstByAttribute:@"isbn" withValue:isbn];
    return exist != NULL;
}

- (void)fetchBookCoverAtURL:(NSString *)urlString underJSON:(NSDictionary *)json isbn:(NSString *)isbn {
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:NSURLSessionConfiguration.defaultSessionConfiguration];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:nil
        destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
            
            NSURL *documentsDirectoryURL =
                [NSFileManager.defaultManager URLForDirectory:NSDocumentDirectory
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
    Book *newBook = [Book MR_createEntity];
    
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *context) {
        [newBook applyBookValue:value];
    } completion:^(BOOL contextDidSave, NSError *error) {
        if (error != nil) {
            [NSNotificationCenter.defaultCenter postNotificationName:ERROR_ON_SAVE object:self];
            [NSFileManager.defaultManager removeItemAtURL:cover error:nil];
        } else {
            [NSNotificationCenter.defaultCenter postNotificationName:SUCCESS_ON_FETCH object:self userInfo:@{@"isbn": newBook.isbn}];
            NSLog(@"New book《%@》successfully fetched.", newBook.title);
        }
    }];
    
}

- (void)postErrorNotificationWithName:(NSString *)name {
    [NSNotificationCenter.defaultCenter postNotificationName:name object:nil];
}

@end

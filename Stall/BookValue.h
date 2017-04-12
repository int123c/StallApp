//
//  BookValue.h
//  Stall
//
//  Created by Inti Guo on 09/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookValue : NSObject

@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSDate *instockDate;
@property (nonatomic) float rating;
@property (nullable, nonatomic, copy) NSString *subtitle;
@property (nullable, nonatomic, copy) NSString *authors;
@property (nullable, nonatomic, copy) NSDate *pubdate;
@property (nullable, nonatomic, copy) NSString *cover;
@property (nullable, nonatomic, copy) NSString *binding;
@property (nullable, nonatomic, copy) NSString *publisher;
@property (nullable, nonatomic, copy) NSString *translators;
@property (nullable, nonatomic, copy) NSString *originTitle;
@property (nonatomic) int64_t pages;
@property (nullable, nonatomic, copy) NSString *isbn;
@property (nullable, nonatomic, copy) NSString *summary;
@property (nullable, nonatomic, copy) NSString *category;
@property (nullable, nonatomic, copy) NSString *price;

- (id _Nonnull)initWithJSON:(NSDictionary *_Nonnull)json coverURL:(NSString *_Nullable)cover;

@end

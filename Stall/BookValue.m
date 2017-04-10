//
//  BookValue.m
//  Stall
//
//  Created by Inti Guo on 09/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import "BookValue.h"

@implementation BookValue

- (instancetype)initWithJSON:(NSDictionary *)json coverURL:(NSString *)cover {
    self = [super init];
    
    if (self != nil) {
        NSString *title = json[@"title"];
        
        NSDate *instockDate = [[NSDate alloc] init];
        
        float rating = 0;
        id responseRating = json[@"rating"];
        if ([responseRating isKindOfClass:[NSDictionary class]]) {
            NSDictionary *d = responseRating;
            NSString *ratingString = d[@"average"];
            rating = ratingString.floatValue;
        }
        
        NSString *subtitle = json[@"subtitle"];
        
        NSArray *authorArray = json[@"author"];
        NSString *authors = [authorArray componentsJoinedByString:@", "];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-M";
        NSDate *pubdate = [dateFormatter dateFromString:json[@"pubdate"]];
        
        NSString *binding = json[@"binding"];
        
        NSArray *translatorArray = json[@"translator"];
        NSString *translators = [translatorArray componentsJoinedByString:@", "];
        
        NSString *originTitle = json[@"originTitle"];
        
        NSString *pageString = json[@"pages"];
        int64_t pages = pageString.intValue;
        
        NSString *isbn = json[@"isbn13"];
        
        NSString *summary = json[@"summary"];
        
        NSDictionary *series = json[@"series"];
        NSString *category = series[@"title"];
        
        NSString *price = json[@"price"];
        
        self.title = title;
        self.instockDate = instockDate;
        self.rating = rating;
        self.subtitle = subtitle;
        self.authors = authors;
        self.pubdate = pubdate;
        self.cover = cover;
        self.binding = binding;
        self.translators = translators;
        self.originTitle = originTitle;
        self.pages = pages;
        self.isbn = isbn;
        self.summary = summary;
        self.category = category;
        self.price = price;
    }
    
    return self;
}

@end

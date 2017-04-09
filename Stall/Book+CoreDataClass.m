//
//  Book+CoreDataClass.m
//  Stall
//
//  Created by Inti Guo on 09/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import "Book+CoreDataClass.h"

@implementation Book

/**
    Apply the values in `BookValue` into `self`. 
 */
- (void)applyBookValue:(BookValue *)value {
    self.title = value.title;
    self.instockDate = value.instockDate;
    self.rating = value.rating;
    self.subtitle = value.subtitle;
    self.authors = value.authors;
    self.pubdate = value.pubdate;
    self.cover = value.cover;
    self.binding = value.binding;
    self.translators = value.translators;
    self.originTitle = value.originTitle;
    self.pages = value.pages;
    self.isbn = value.isbn;
    self.summary = value.summary;
    self.category = value.category;
    self.price = value.price;
}

@end

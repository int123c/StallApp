//
//  Book+CoreDataProperties.h
//  Stall
//
//  Created by Inti Guo on 09/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import "Book+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Book (CoreDataProperties)

+ (NSFetchRequest<Book *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSDate *instockDate;
@property (nonatomic) float rating;
@property (nullable, nonatomic, copy) NSString *subtitle;
@property (nullable, nonatomic, copy) NSString *authors;
@property (nullable, nonatomic, copy) NSDate *pubdate;
@property (nullable, nonatomic, copy) NSString *cover;
@property (nullable, nonatomic, copy) NSString *binding;
@property (nullable, nonatomic, copy) NSString *translators;
@property (nullable, nonatomic, copy) NSString *originTitle;
@property (nonatomic) int64_t pages;
@property (nullable, nonatomic, copy) NSString *isbn;
@property (nullable, nonatomic, copy) NSString *summary;
@property (nullable, nonatomic, copy) NSString *category;
@property (nullable, nonatomic, copy) NSString *price;

@end

NS_ASSUME_NONNULL_END

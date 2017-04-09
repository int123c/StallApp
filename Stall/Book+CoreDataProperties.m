//
//  Book+CoreDataProperties.m
//  Stall
//
//  Created by Inti Guo on 09/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import "Book+CoreDataProperties.h"

@implementation Book (CoreDataProperties)

+ (NSFetchRequest<Book *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Book"];
}

@dynamic title;
@dynamic instockDate;
@dynamic rating;
@dynamic subtitle;
@dynamic authors;
@dynamic pubdate;
@dynamic cover;
@dynamic binding;
@dynamic translators;
@dynamic originTitle;
@dynamic pages;
@dynamic isbn;
@dynamic summary;
@dynamic category;
@dynamic price;

@end

//
//  Book+CoreDataClass.h
//  Stall
//
//  Created by Inti Guo on 09/04/2017.
//  Copyright © 2017 Inti Guo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BookValue.h"

NS_ASSUME_NONNULL_BEGIN

@interface Book : NSManagedObject

- (void)applyBookValue:(BookValue *)value;

@end

NS_ASSUME_NONNULL_END

#import "Book+CoreDataProperties.h"

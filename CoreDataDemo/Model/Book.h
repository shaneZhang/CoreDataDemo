//
//  Book.h
//  CoreDataDemo
//
//  Created by 张毓庆 on 13-12-7.
//  Copyright (c) 2013年 张毓庆. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Person;

@interface Book : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSSet *persons;
@end

@interface Book (CoreDataGeneratedAccessors)

- (void)addPersonsObject:(Person *)value;
- (void)removePersonsObject:(Person *)value;
- (void)addPersons:(NSSet *)values;
- (void)removePersons:(NSSet *)values;

@end

//
//  Transformer+CoreDataProperties.h
//  TransforCoreData
//
//  Created by Arron Zhu on 16/1/15.
//  Copyright © 2016年 ArronZ. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Transformer.h"
#import <UIKit/UIKit.h>

@class Person;

NS_ASSUME_NONNULL_BEGIN

@interface Transformer (CoreDataProperties)

@property (nullable, nonatomic, retain) Person *person;
@property (nullable, nonatomic, retain) NSData *image;
@property (nullable, nonatomic, retain) UIColor *color;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *available;
@property (nullable, nonatomic, retain) UIImage *logo;
@property (nullable, nonatomic, retain) NSNumber *testId;

@end

NS_ASSUME_NONNULL_END

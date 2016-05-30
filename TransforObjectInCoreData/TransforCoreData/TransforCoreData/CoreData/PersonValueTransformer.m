//
//  PersonValueTransformer.m
//  TransforCoreData
//
//  Created by Arron Zhu on 16/1/15.
//  Copyright © 2016年 ArronZ. All rights reserved.
//

#import "PersonValueTransformer.h"
#import "Person.h"

@implementation PersonValueTransformer

+ (BOOL)allowsReverseTransformation {
    return YES;
}

+ (Class)transformedValueClass {
    return [NSData class];
}

- (id)transformedValue:(id)value {
    Person *person = (Person *)value;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:person];
    return data;
}

- (id)reverseTransformedValue:(id)value {
    NSData *data = (NSData *)value;
    Person *person = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return person;
}

@end

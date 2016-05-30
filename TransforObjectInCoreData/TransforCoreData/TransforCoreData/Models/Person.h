//
//  Person.h
//  TransforCoreData
//
//  Created by Arron Zhu on 16/1/15.
//  Copyright © 2016年 ArronZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject<NSCoding>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, strong) NSString *gender;

@end

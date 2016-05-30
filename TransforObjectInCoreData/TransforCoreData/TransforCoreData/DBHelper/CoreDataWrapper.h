//
//  CoreDataWrapper.h
//  TransforCoreData
//
//  Created by Arron Zhu on 16/1/15.
//  Copyright © 2016年 ArronZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface CoreDataWrapper : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *mainContext;
@property (readonly, strong, nonatomic) NSManagedObjectContext *privateContext;

+ (CoreDataWrapper *)instance;

- (NSManagedObjectContext *)childContext;
- (void)saveContext;

@end

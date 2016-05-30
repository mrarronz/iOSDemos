//
//  DBHelper.m
//  TransforCoreData
//
//  Created by Arron Zhu on 16/1/15.
//  Copyright © 2016年 ArronZ. All rights reserved.
//

#import "DBHelper.h"
#import "CoreDataWrapper.h"

@implementation DBHelper

+ (Transformer *)findTransformerById:(NSInteger)testId {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Transformer class])];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"testId = %@", @(testId)];
    fetchRequest.fetchLimit = 1;
    NSManagedObjectContext *context = [[CoreDataWrapper instance] mainContext];
    NSError *error;
    NSArray *resultArray = [context executeFetchRequest:fetchRequest error:&error];
    if (resultArray.count > 0) {
        return [resultArray firstObject];
    }
    return nil;
}

@end

//
//  DBHelper.h
//  TransforCoreData
//
//  Created by Arron Zhu on 16/1/15.
//  Copyright © 2016年 ArronZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataWrapper.h"
#import "Transformer.h"

@interface DBHelper : NSObject

+ (Transformer *)findTransformerById:(NSInteger)testId;

@end

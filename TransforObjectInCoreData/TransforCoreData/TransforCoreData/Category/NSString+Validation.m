//
//  NSString+Validation.m
//  TransforCoreData
//
//  Created by Arron Zhu on 16/1/15.
//  Copyright © 2016年 ArronZ. All rights reserved.
//

#import "NSString+Validation.h"

static NSString *numberRegexp = @"[0-9]*";
static NSString *validCharSet = @"0123456789abcdefABCDEF";

@implementation NSString (Validation)

- (BOOL)regularExpressionCheck:(NSString *)regexp {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexp];
    BOOL result = NO;
    @try {
        result = [predicate evaluateWithObject:self];
    }
    @catch (NSException *exception) {
        NSLog(@"Util-Regexp exception: %@", exception);
    }
    return result;
}

- (BOOL)isPureNumber {
    return [self regularExpressionCheck:numberRegexp];
}

- (BOOL)isValidColorValue {
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:validCharSet] invertedSet];
    NSString *filtered = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL result = [self isEqualToString:filtered];
    return result;
}

@end

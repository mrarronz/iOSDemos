//
//  ColorValueTransformer.m
//  TransforCoreData
//
//  Created by Arron Zhu on 16/1/15.
//  Copyright © 2016年 ArronZ. All rights reserved.
//

#import "ColorValueTransformer.h"

@implementation ColorValueTransformer

+ (BOOL)allowsReverseTransformation {
    return YES;
}

+ (Class)transformedValueClass {
    return [NSData class];
}

- (id)transformedValue:(id)value {
    UIColor *color = (UIColor *)value;
    CGFloat red, green, blue, alpha;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    CGFloat component[4] = {red, green, blue, alpha};
    NSData *data = [[NSData alloc] initWithBytes:component length:sizeof(component)];
    return data;
}

- (id)reverseTransformedValue:(id)value {
    NSData *data = (NSData *)value;
    CGFloat component[4] = {0.0, 0.0, 0.0, 0.0};
    [data getBytes:component length:sizeof(component)];
    UIColor *color = [UIColor colorWithRed:component[0] green:component[1] blue:component[2] alpha:component[3]];
    return color;
}

@end

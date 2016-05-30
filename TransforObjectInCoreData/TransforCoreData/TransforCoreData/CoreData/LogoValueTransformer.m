//
//  LogoValueTransformer.m
//  TransforCoreData
//
//  Created by Arron Zhu on 16/1/15.
//  Copyright © 2016年 ArronZ. All rights reserved.
//

#import "LogoValueTransformer.h"

@implementation LogoValueTransformer

+ (BOOL)allowsReverseTransformation {
    return YES;
}

+ (Class)transformedValueClass {
    return [NSData class];
}

- (id)transformedValue:(id)value {
    UIImage *image = (UIImage *)value;
    NSData *data = UIImagePNGRepresentation(image);
    return data;
}

- (id)reverseTransformedValue:(id)value {
    NSData *data = (NSData *)value;
    UIImage *image = [UIImage imageWithData:data];
    return image;
}

@end

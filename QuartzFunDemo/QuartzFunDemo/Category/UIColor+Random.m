//
//  UIColor+Random.m
//  QuartzFunDemo
//
//  Created by Arron Zhu on 16/6/3.
//  Copyright © 2016年 arronz. All rights reserved.
//

#import "UIColor+Random.h"

#define ARC4RANDOM_MAX (0x100000000LL)

@implementation UIColor (Random)

+ (UIColor *)randomColor {
    CGFloat red = arc4random() / ARC4RANDOM_MAX;
    CGFloat blue = arc4random() / ARC4RANDOM_MAX;
    CGFloat green = arc4random() / ARC4RANDOM_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end

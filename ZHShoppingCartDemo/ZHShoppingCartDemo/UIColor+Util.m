//
//  UIColor+Util.m
//  ZHShoppingCartDemo
//
//  Created by Arron Zhu on 16/6/22.
//  Copyright © 2016年 arronz. All rights reserved.
//

#import "UIColor+Util.h"

@implementation UIColor (Util)

- (UIImage *)colorToImage {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    return [self colorToImageWithRect:rect];
}

- (UIImage *)colorToImageWithRect:(CGRect)rect {
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.0];
}

@end

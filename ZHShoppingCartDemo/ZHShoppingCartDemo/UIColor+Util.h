//
//  UIColor+Util.h
//  ZHShoppingCartDemo
//
//  Created by Arron Zhu on 16/6/22.
//  Copyright © 2016年 arronz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Util)

- (UIImage *)colorToImage;
- (UIImage *)colorToImageWithRect:(CGRect)rect;

+ (UIColor *)randomColor;

@end

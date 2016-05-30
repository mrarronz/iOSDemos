//
//  UIColor+Utils.h
//  CollectionDemo
//
//  Created by XMD001 on 16/4/15.
//  Copyright © 2016年 XMD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Utils)

+ (UIColor *)colorWithHexString:(NSString *)color;

- (UIImage *)imageWithColorInRect:(CGRect)rect;

@end

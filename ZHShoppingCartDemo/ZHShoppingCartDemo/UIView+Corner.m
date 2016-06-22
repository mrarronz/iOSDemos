//
//  UIView+Corner.m
//  ZHShoppingCartDemo
//
//  Created by Arron Zhu on 16/6/22.
//  Copyright © 2016年 arronz. All rights reserved.
//

#import "UIView+Corner.h"

@implementation UIView (Corner)

- (void)addCornerRadius:(CGFloat)radius {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                     byRoundingCorners:UIRectCornerAllCorners
                                                           cornerRadii:CGSizeMake(radius, radius)];
    shapeLayer.path = bezierPath.CGPath;
    self.layer.mask = shapeLayer;
}

@end

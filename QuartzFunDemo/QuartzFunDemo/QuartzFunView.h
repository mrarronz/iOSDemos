//
//  QuartzFunView.h
//  QuartzFunDemo
//
//  Created by Arron Zhu on 16/6/3.
//  Copyright © 2016年 arronz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface QuartzFunView : UIView

@property (nonatomic) CGPoint firstTouch;
@property (nonatomic) CGPoint lastTouch;
@property (nonatomic) ShapeType shapeType;
@property (nonatomic) BOOL useRandomColor;
@property (nonatomic, strong) UIColor *currentColor;
@property (nonatomic, strong) UIImage *drawImage;
@property (readonly) CGRect currentRect;
@property CGRect redrawRect;

@end

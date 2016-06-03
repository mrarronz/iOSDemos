//
//  Constant.h
//  QuartzFunDemo
//
//  Created by Arron Zhu on 16/6/3.
//  Copyright © 2016年 arronz. All rights reserved.
//

typedef NS_ENUM(NSInteger, ShapeType) {
    kLineShape = 0,
    kRectShape,
    kEllipseShape,
    kImageShape
};

typedef NS_ENUM(NSInteger, ColorTabIndex) {
    kRedColorTab = 0,
    kBlueColorTab,
    kGreenColorTab,
    kYellowColorTab,
    kRandomColorTab
};

#define degreesToRadian(x) (M_PI * (x) / 180.0f)
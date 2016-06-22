//
//  ZHBadgeView.h
//  ZHUIComponents
//
//  Created by Arron Zhu on 16/5/16.
//  Copyright © 2016年 arronz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHBadgeView : UIView

@property (nonatomic, copy)   NSString *badgeValue;
@property (nonatomic, strong) UIColor *badgeBkgColor;
@property (nonatomic, strong) UIColor *badgeTextColor;
@property (nonatomic, strong) UIFont *badgeTextFont;
@property (nonatomic, assign) BOOL needWhiteCircle;

@end

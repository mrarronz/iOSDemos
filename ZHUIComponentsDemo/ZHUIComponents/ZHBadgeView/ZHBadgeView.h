//
//  ZHBadgeView.h
//  ZHUIComponents
//
//  Created by Arron Zhu on 16/5/16.
//  Copyright © 2016年 arronz. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface ZHBadgeView : UIView

@property (nonatomic, copy)   IBInspectable NSString *badgeValue;
@property (nonatomic, strong) IBInspectable UIColor *badgeBkgColor;
@property (nonatomic, strong) IBInspectable UIColor *badgeTextColor;
@property (nonatomic, strong) IBInspectable UIFont *badgeTextFont;
@property (nonatomic, assign) IBInspectable BOOL needWhiteCircle;

@end

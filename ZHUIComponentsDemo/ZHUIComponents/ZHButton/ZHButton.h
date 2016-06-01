//
//  ZHButton.h
//  ZHUIComponents
//
//  Created by Arron Zhu on 16/5/13.
//  Copyright © 2016年 arronz. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface ZHButton : UIButton

@property (nonatomic, assign) IBInspectable CGFloat btnRadius;
@property (nonatomic, strong) IBInspectable UIFont *labelFont;
@property (nonatomic, strong) IBInspectable UIColor *btnTextColor;
@property (nonatomic, strong) IBInspectable UIColor *borderColor;
@property (nonatomic, strong) IBInspectable UIImage *btnImage;
@property (nonatomic, strong) IBInspectable UIImage *bkgImage;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, assign) IBInspectable BOOL isRoundCorner;
@property (nonatomic, assign) IBInspectable BOOL fitSize;
@property (nonatomic, assign) IBInspectable BOOL underLined;
@property (nonatomic, copy)   IBInspectable NSString *normalText;

+ (ZHButton *)buttonWithTitle:(NSString *)title
                   titleColor:(UIColor *)color
                      bgColor:(UIColor *)bgColor
                         font:(UIFont *)font;

@end

//
//  ZHAlertView.h
//  ZHAlertView
//
//  Created by Arron Zhu on 16/6/23.
//  Copyright © 2016年 arronz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZHAlertView;

@protocol ZHAlertViewDelegate <NSObject>

@optional
/**
 *  点击button之后的代理方法
 *
 *  @param alert ZHAlertView对象
 *  @param index button的index，点击的是哪一个button，ZHAlertView只提供最多两个button的情况，index的值为0或1
 */
- (void)alert:(ZHAlertView *)alert didClickButtonAtIndex:(NSInteger)index;

@end

@interface ZHAlertView : UIView

/**
 *  标题栏左侧小图标
 */
@property (nonatomic, strong) UIImage *headerImage;

/**
 *  内容区域左侧小图标
 */
@property (nonatomic, strong) UIImage *alertImage;

/**
 *  主题颜色，设置这个值来更改标题栏和button的颜色
 */
@property (nonatomic, strong) UIColor *themeColor;

/**
 *  底部footer(button所在区域)的颜色
 */
@property (nonatomic, strong) UIColor *footerColor;

/**
 *  ZHAlertViewDelegate的代理对象
 */
@property (nonatomic, assign) id<ZHAlertViewDelegate> delegate;

/**
 *  ZHAlertView的初始化方法
 *
 *  @param title             标题
 *  @param message           message
 *  @param delegate          delegate
 *  @param cancelButtonTitle cancelButton的标题
 *  @param otherButtonTitle  其它button的标题
 */
- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                     delegate:(id)delegate
            cancelButtonTitle:(NSString *)cancelButtonTitle
             otherButtonTitle:(NSString *)otherButtonTitle;

/**
 *  显示alertView
 */
- (void)show;

@end

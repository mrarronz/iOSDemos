//
//  ZHAlertView.m
//  ZHAlertView
//
//  Created by Arron Zhu on 16/6/23.
//  Copyright © 2016年 arronz. All rights reserved.
//

#import "ZHAlertView.h"
#import <Masonry.h>

#define kDefaultContentHeight 80
#define kDefaultLabelHeight 20
#define kAlertHorizontalPadding 40
#define kHeaderHeight 44
#define kFooterHeight 60
#define kButtonHeight 36

#define kMaxContentHeight 200
#define kCommonViewMargin 10

/**
 *  alertView的button数量
 */
typedef NS_ENUM(NSInteger, ZHButtonType) {
    /**
     *  默认两个button，一个取消，一个确定
     */
    ZHButtonTypeDefault,
    /**
     *  一个button，通常只显示为确定
     */
    ZHButtonTypeSingle,
    /**
     *  无button的情况，不显示底部区域
     */
    ZHButtonTypeNone,
};

@interface ZHAlertView ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIView *topSeparatorView;

@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UIImageView *alertImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *okButton;
@property (nonatomic, strong) UIButton *closeButton;

@property (nonatomic, assign) ZHButtonType buttonType;

@end

@implementation ZHAlertView

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                     delegate:(id)delegate
            cancelButtonTitle:(NSString *)cancelButtonTitle
             otherButtonTitle:(NSString *)otherButtonTitle {
    self = [super initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    if (self) {
        self.titleLabel.text = title;
        self.messageLabel.text = message;
        self.delegate = delegate;
        _themeColor = [UIColor colorWithRed:0.222 green:0.658 blue:0.266 alpha:1.0];
        _footerColor = [UIColor colorWithRed:0.888 green:0.898 blue:0.886 alpha:1.0];
        
        [self setupButtonsWithCancelTitle:cancelButtonTitle
                               otherTitle:otherButtonTitle];
        [self setupContainerView];
        [self setupHeaderView];
        [self setupContentView];
        [self setupFooterView];
        [self applyMotionEffects];
        [self addDeviceRotationObserver];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  设置alertView的弹出框
 */
- (void)setupContainerView {
    // 添加header
    [self.containerView addSubview:self.headerView];
    
    // 添加contentView
    [self.containerView addSubview:self.contentView];
    
    // 添加分割线
    [self.containerView addSubview:self.topSeparatorView];
    
    UIView *bottomSeparatorView = [self separatorView];
    
    // 判断有无footer的情况
    CGFloat totalHeight = kHeaderHeight + self.contentHeight;
    if (self.buttonType != ZHButtonTypeNone) {
        [self.containerView addSubview:bottomSeparatorView];
        [self.containerView addSubview:self.footerView];
        totalHeight += kFooterHeight;
    }
    [self addSubview:self.containerView];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        if ([self isOrientationLandscape]) {
            make.width.equalTo(@(CGRectGetHeight(self.bounds) - 2*kAlertHorizontalPadding));
            make.height.equalTo(@(totalHeight));
            make.center.equalTo(self);
        } else {
            make.left.equalTo(self).offset(kAlertHorizontalPadding);
            make.right.equalTo(self).offset(-kAlertHorizontalPadding);
            make.height.equalTo(@(totalHeight));
            make.center.equalTo(self);
        }
    }];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containerView);
        make.left.equalTo(self.containerView);
        make.right.equalTo(self.containerView);
        make.height.equalTo(@(kHeaderHeight));
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom);
        make.left.equalTo(self.containerView);
        make.right.equalTo(self.containerView);
        make.height.equalTo(@(self.contentHeight));
    }];
    [self.topSeparatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView);
        make.right.equalTo(self.containerView);
        make.top.equalTo(self.headerView.mas_bottom);
        make.height.equalTo(@0.5);
    }];
    if (self.buttonType != ZHButtonTypeNone) {
        [bottomSeparatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.containerView);
            make.right.equalTo(self.containerView);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.height.equalTo(@(0.5));
        }];
        [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_bottom);
            make.left.equalTo(self.containerView);
            make.right.equalTo(self.containerView);
            make.height.equalTo(@(kFooterHeight));
        }];
    }
}

/**
 *  设置alertView的头部标题和图片
 */
- (void)setupHeaderView {
    [self.headerView addSubview:self.titleLabel];
    [self.headerView addSubview:self.closeButton];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView);
        make.right.equalTo(self.headerView);
        make.bottom.equalTo(self.headerView);
        make.width.equalTo(@44);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(kCommonViewMargin));
        make.height.equalTo(@(kDefaultLabelHeight));
        make.right.equalTo(self.closeButton.mas_left).offset(-5);
        make.centerY.equalTo(self.headerView);
    }];
}

/**
 *  设置alertView的尾部，这部分主要放置button
 */
- (void)setupFooterView {
    if (self.buttonType == ZHButtonTypeDefault) {
        [self.footerView addSubview:self.cancelButton];
        [self.footerView addSubview:self.okButton];
        
        CGFloat buttonWidth = 80;
        CGFloat buttonMargin = (CGRectGetWidth(self.bounds) - 2*kAlertHorizontalPadding - 2*buttonWidth)/3;
        if ([self isOrientationLandscape]) {
            buttonMargin = (CGRectGetHeight(self.bounds) - 2*kAlertHorizontalPadding - 2*buttonWidth)/3;
        }
        
        [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(buttonWidth));
            make.left.equalTo(self.footerView).offset(buttonMargin);
            make.centerY.equalTo(self.footerView);
            make.height.equalTo(@(kButtonHeight));
        }];
        [self.okButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(buttonWidth));
            make.right.equalTo(self.footerView).offset(-buttonMargin);
            make.centerY.equalTo(self.footerView);
            make.height.equalTo(@(kButtonHeight));
        }];
        
    } else {
        // 只显示一个button的情况下设置约束
        [self.footerView addSubview:self.cancelButton];
        [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@20);
            make.right.equalTo(self.footerView).offset(-20);
            make.height.equalTo(@(kButtonHeight));
            make.centerY.equalTo(self.footerView);
        }];
    }
}

/**
 *  设置alertView的内容区域，这部分放置显示消息的label和图片提示
 */
- (void)setupContentView {
    [self.contentView addSubview:self.messageLabel];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@([self alertViewContentWidth]));
        make.height.equalTo(@([self messageHeight]));
        make.centerY.equalTo(self.contentView);
        make.centerX.equalTo(self.contentView);
    }];
}

/**
 *  设置两个button的文字
 *
 *  @param cancelTitle 取消button
 *  @param otherTitle  其它button，一般显示“确定”
 */
- (void)setupButtonsWithCancelTitle:(NSString *)cancelTitle otherTitle:(NSString *)otherTitle {
    
    self.cancelButton.hidden = NO;
    self.okButton.hidden = NO;
    
    if (cancelTitle.length > 0 && otherTitle.length > 0) {
        [self.cancelButton setTitle:cancelTitle forState:UIControlStateNormal];
        [self.okButton setTitle:otherTitle forState:UIControlStateNormal];
        self.buttonType = ZHButtonTypeDefault;
    }
    else if (cancelTitle.length > 0 && otherTitle.length == 0) {
        [self.cancelButton setTitle:cancelTitle forState:UIControlStateNormal];
        self.okButton.hidden = YES;
        self.buttonType = ZHButtonTypeSingle;
    }
    else if (cancelTitle.length == 0 && otherTitle.length > 0) {
        [self.cancelButton setTitle:otherTitle forState:UIControlStateNormal];
        self.okButton.hidden = YES;
        self.buttonType = ZHButtonTypeSingle;
    }
    else {
        self.cancelButton.hidden = YES;
        self.okButton.hidden = YES;
        self.buttonType = ZHButtonTypeNone;
    }
    if (self.buttonType == ZHButtonTypeSingle) {
        self.cancelButton.backgroundColor = _themeColor;
        [self setImagesForButton:self.cancelButton];
        [self setTitleColorForButton:self.cancelButton];
    }
}

/**
 *  添加motionEffect
 */
- (void)applyMotionEffects {
    UIInterpolatingMotionEffect *horizontalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    horizontalEffect.minimumRelativeValue = @(-10);
    horizontalEffect.maximumRelativeValue = @(10);
    
    UIInterpolatingMotionEffect *verticalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    verticalEffect.minimumRelativeValue = @(-10);
    verticalEffect.maximumRelativeValue = @(10);
    
    UIMotionEffectGroup *motionEffectGroup = [[UIMotionEffectGroup alloc] init];
    motionEffectGroup.motionEffects = @[horizontalEffect, verticalEffect];
    
    [self.containerView addMotionEffect:motionEffectGroup];
}

/**
 *  显示时添加动画
 */
- (void)applyShowupAnimation {
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.containerView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - Notification

- (void)addDeviceRotationObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(statusBarOrientationChanged:)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification
                                               object:nil];
}

/**
 *  屏幕旋转的处理
 *
 *  @param notification
 */
- (void)statusBarOrientationChanged:(NSNotification *)notification {
    
    self.frame = [UIApplication sharedApplication].keyWindow.bounds;
    
    if ([self isOrientationLandscape]) {
        CGFloat messageWidth = CGRectGetWidth(self.messageLabel.frame) + self.spacePadding;
        CGFloat contentHeight = CGRectGetHeight(self.messageLabel.frame) + self.spacePadding;
        
        if (self.alertImage != nil) {
            contentHeight = kDefaultContentHeight;
            messageWidth = CGRectGetHeight(self.frame) - 2 * kAlertHorizontalPadding - self.spacePadding;
        }
        CGFloat height = (self.buttonType != ZHButtonTypeNone) ? kHeaderHeight + contentHeight + kFooterHeight : kHeaderHeight + contentHeight;
        
        [self.containerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(messageWidth));
            make.height.equalTo(@(height));
            make.center.equalTo(self);
        }];
        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(messageWidth));
        }];
        [self.containerView layoutIfNeeded];
    }
    
}

#pragma mark - Show & Dismiss

- (void)show {
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    [window addSubview:self];
    self.containerView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    }];
    [self applyShowupAnimation];
}

- (void)dismiss {
    [UIView animateWithDuration:0.25 animations:^{
        self.containerView.alpha = 0;
        self.containerView.transform = CGAffineTransformMakeScale(0.3, 0.3);
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }];
}

- (void)dismissWithButtonIndex:(NSInteger)index {
    [UIView animateWithDuration:0.25 animations:^{
        self.containerView.alpha = 0;
        self.containerView.transform = CGAffineTransformMakeScale(0.3, 0.3);
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            if ([self.delegate respondsToSelector:@selector(alert:didClickButtonAtIndex:)]) {
                [self.delegate alert:self didClickButtonAtIndex:index];
            }
        }];
    }];
}

#pragma mark - Setters

/**
 *  设置标题左侧的图标，固定尺寸为24*24
 *
 *  @param headerImage
 */
- (void)setHeaderImage:(UIImage *)headerImage {
    _headerImage = headerImage;
    self.headerImageView.image = headerImage;
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerView).offset(kCommonViewMargin);
        make.width.height.equalTo(@24);
        make.centerY.equalTo(self.headerView);
    }];
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerImageView.mas_right).offset(5);
        make.height.equalTo(@(kDefaultLabelHeight));
        make.right.equalTo(self.closeButton.mas_left).offset(-5);
        make.centerY.equalTo(self.headerView);
    }];
}

/**
 *  设置内容区域左侧的图标，固定尺寸为24*24. 这里规定当设置内容图标时，messageLabel只显示一行
 *
 *  @param alertImage
 */
- (void)setAlertImage:(UIImage *)alertImage {
    _alertImage = alertImage;
    self.alertImageView.image = alertImage;
    CGFloat imageWidth = 24;
    
    CGFloat textWidth = [self.messageLabel.text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]}].width;
    CGFloat totalWidth = imageWidth + 5 + textWidth;
    CGFloat contentWidth = [self alertViewContentWidth];
    if (totalWidth > contentWidth) {
        totalWidth = contentWidth;
    }
    textWidth = totalWidth - 5 - imageWidth;
    CGFloat originX = (contentWidth - totalWidth)/2 + kCommonViewMargin;
    [self.alertImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(imageWidth));
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(originX);
    }];
    [self.messageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.alertImageView.mas_right).offset(5);
        make.width.equalTo(@(textWidth));
        make.height.equalTo(@(kDefaultLabelHeight));
        make.centerY.equalTo(self.contentView);
    }];
    
    // 重新计算alertView的高度
    CGFloat alertHeight = kHeaderHeight + kDefaultContentHeight + kFooterHeight;
    [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(alertHeight));
    }];
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(kDefaultContentHeight));
    }];
    [self.containerView layoutIfNeeded];
}

/**
 *  更改主题颜色
 */
- (void)setThemeColor:(UIColor *)themeColor {
    _themeColor = themeColor;
    [self updateHeaderColor:themeColor];
    [self updateTitleLabelColor:themeColor];
    
    if (self.buttonType == ZHButtonTypeSingle) {
        self.cancelButton.backgroundColor = themeColor;
        [self setImagesForButton:self.cancelButton];
        [self setTitleColorForButton:self.cancelButton];
    }
    self.okButton.backgroundColor = themeColor;
    [self setImagesForButton:self.okButton];
}

/**
 *  更改底部footer的颜色
 *
 *  @param footerColor
 */
- (void)setFooterColor:(UIColor *)footerColor {
    _footerColor = footerColor;
    self.footerView.backgroundColor = footerColor;
}

#pragma mark - Calculation

/**
 *  contentView的宽度
 */
- (CGFloat)alertViewContentWidth {
    if ([self isOrientationLandscape]) {
        return CGRectGetHeight(self.bounds) - 2 * kAlertHorizontalPadding - self.spacePadding;
    }
    return CGRectGetWidth(self.bounds) - 2 * kAlertHorizontalPadding - self.spacePadding;
}

/**
 * contentView的高度 = 消息文字高度 + 空白部分的高度
 */
- (CGFloat)contentHeight {
    return self.messageHeight + self.spacePadding;
}

/**
 *  消息label的文字高度
 */
- (CGFloat)messageHeight {
    CGFloat contentWidth = [self alertViewContentWidth];
    // 设置最高可以显示的高度
    CGFloat maxHeight = kMaxContentHeight;
    CGRect textRect = [self.messageLabel.text boundingRectWithSize:CGSizeMake(contentWidth, maxHeight)
                                                           options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                                                        attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]}
                                                           context:nil];
    if (textRect.size.height < 20) {
        // 设置默认的消息高度
        return kDefaultContentHeight - [self spacePadding];
    }
    return textRect.size.height;
}

/**
 *  空白处占位的高度
 */
- (CGFloat)spacePadding {
    return kCommonViewMargin * 2;
}

- (BOOL)isOrientationLandscape {
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    return UIInterfaceOrientationIsLandscape(orientation);
}

/**
 *  获取颜色透明度
 */
- (CGFloat)alphaForColor:(UIColor*)color {
    CGFloat r, g, b, a, w, h, s, l;
    BOOL compatible = [color getWhite:&w alpha:&a];
    if (compatible) {
        return a;
    } else {
        compatible = [color getRed:&r green:&g blue:&b alpha:&a];
        if (compatible) {
            return a;
        } else {
            [color getHue:&h saturation:&s brightness:&l alpha:&a];
            return a;
        }
    }
}

/**
 *  判断颜色的深浅
 */
- (BOOL)isDarkColor:(UIColor *)newColor {
    if ([self alphaForColor: newColor] < 10e-5) {
        return YES;
    }
    const CGFloat *componentColors = CGColorGetComponents(newColor.CGColor);
    CGFloat colorBrightness = ((componentColors[0] * 299) + (componentColors[1] * 587) + (componentColors[2] * 114)) / 1000;
    if (colorBrightness < 0.5) {
        return YES;
    }
    return NO;
}

#pragma mark - Init Property

- (UIImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] init];
        [self.headerView addSubview:_headerImageView];
    }
    return _headerImageView;
}

- (UIImageView *)alertImageView {
    if (!_alertImageView) {
        _alertImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_alertImageView];
    }
    return _alertImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:15];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.font = [UIFont systemFontOfSize:13];
        _messageLabel.textColor = [UIColor darkGrayColor];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.numberOfLines = 0;
    }
    return _messageLabel;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _cancelButton.backgroundColor = [UIColor whiteColor];
        [_cancelButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setImagesForButton:_cancelButton];
        _cancelButton.layer.cornerRadius = 3.0;
        _cancelButton.layer.masksToBounds = YES;
        _cancelButton.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5].CGColor;
        _cancelButton.layer.borderWidth = 0.5;
        [_cancelButton addTarget:self action:@selector(eventButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)okButton {
    if (!_okButton) {
        _okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _okButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _okButton.backgroundColor = self.themeColor;
        [_okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setImagesForButton:_okButton];
        _okButton.layer.cornerRadius = 3.0;
        _okButton.layer.masksToBounds = YES;
        _okButton.tag = 1;
        [_okButton addTarget:self action:@selector(eventButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _okButton;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_closeButton setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.layer.cornerRadius = 4.0;
        _containerView.layer.masksToBounds = YES;
    }
    return _containerView;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] init];
        [self updateHeaderColor:_themeColor];
    }
    return _headerView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] init];
        _footerView.backgroundColor = _footerColor;
    }
    return _footerView;
}

- (UIView *)topSeparatorView {
    if (!_topSeparatorView) {
        _topSeparatorView = [self separatorView];
    }
    return _topSeparatorView;
}

- (UIView *)separatorView {
    UIView *separatorView = [[UIView alloc] init];
    separatorView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    return separatorView;
}

#pragma mark - Drawing Image 

/**
 *  根据颜色绘制图片
 *
 *  @param color
 *
 *  @return
 */
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 *  设置button的背景图片
 *
 *  @param button
 */
- (void)setImagesForButton:(UIButton *)button {
    [button setBackgroundImage:[self imageWithColor:button.backgroundColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[self imageWithColor:[UIColor colorWithWhite:0 alpha:0.2]] forState:UIControlStateHighlighted];
}

/**
 *  设置button的标题颜色，更改border的宽度
 *
 *  @param button
 */
- (void)setTitleColorForButton:(UIButton *)button {
    if ([self isDarkColor:button.backgroundColor]) {
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.layer.borderWidth = 0;
    } else {
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        button.layer.borderWidth = 0.5;
        button.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5].CGColor;
    }
}

/**
 *  设置标题文字的颜色
 *
 *  @param headerBackgroundColor
 */
- (void)updateTitleLabelColor:(UIColor *)headerBackgroundColor {
    if ([self isDarkColor:headerBackgroundColor]) {
        self.titleLabel.textColor = [UIColor whiteColor];
    } else {
        self.titleLabel.textColor = [UIColor darkGrayColor];
    }
}

/**
 *  设置标题栏的背景色并决定是否隐藏标题栏的分割线，深色背景不显示分割线，浅色背景显示分割线
 *
 *  @param color
 */
- (void)updateHeaderColor:(UIColor *)color {
    self.headerView.backgroundColor = color;
    self.topSeparatorView.hidden = [self isDarkColor:color];
}

#pragma mark - Event

- (void)closeButtonClicked:(id)sender {
    [self dismiss];
}

- (void)eventButtonClicked:(id)sender {
    UIButton *button = (UIButton *)sender;
    [self dismissWithButtonIndex:button.tag];
}

@end

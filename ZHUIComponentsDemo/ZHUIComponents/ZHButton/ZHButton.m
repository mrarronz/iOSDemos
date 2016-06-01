//
//  ZHButton.m
//  ZHUIComponents
//
//  Created by Arron Zhu on 16/5/13.
//  Copyright © 2016年 arronz. All rights reserved.
//

#import "ZHButton.h"

@implementation ZHButton

+ (ZHButton *)buttonWithTitle:(NSString *)title
                   titleColor:(UIColor *)color
                      bgColor:(UIColor *)bgColor
                         font:(UIFont *)font {
    ZHButton *button = [[ZHButton alloc] init];
    button.backgroundColor = bgColor;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.titleLabel.font = font;
    return button;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

/// default setup
- (void)setup {
    self.layer.cornerRadius = 5.f;
    self.layer.masksToBounds = YES;
    self.btnTextColor = [UIColor whiteColor];
    self.fitSize = NO;
    self.underLined = NO;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (self.underLined) {
        CGRect textFrame = self.titleLabel.frame;
        CGFloat descender = self.titleLabel.font.descender;
        CGFloat shadowHeight = self.titleLabel.shadowOffset.height;
        CGFloat offset = descender + shadowHeight;
        offset = (fabs(offset) > 0) ? fabs(offset) : offset + 3;
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, textFrame.origin.x, textFrame.origin.y + textFrame.size.height + offset);
        CGContextAddLineToPoint(context, textFrame.origin.x + textFrame.size.width, textFrame.origin.y + textFrame.size.height + offset);
        CGContextSetStrokeColorWithColor(context, self.btnTextColor.CGColor);
        CGContextSetLineWidth(context, 1.0);
        CGContextStrokePath(context);
        
        self.backgroundColor = [UIColor clearColor];
    }
    UIColor *touchUpInsideColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2] ;
    [self setBackgroundImage:[self imageWithColor:self.backgroundColor rect:rect]
                    forState:UIControlStateNormal];
    [self setBackgroundImage:[self imageWithColor:touchUpInsideColor rect:rect]
                    forState:UIControlStateHighlighted];
}

- (void)setBtnRadius:(CGFloat)btnRadius {
    _btnRadius = btnRadius;
    self.layer.cornerRadius = btnRadius;
    self.layer.masksToBounds = YES;
}

- (void)setLabelFont:(UIFont *)labelFont {
    _labelFont = labelFont;
    self.titleLabel.font = labelFont;
}

- (void)setBtnTextColor:(UIColor *)btnTextColor {
    _btnTextColor = btnTextColor;
    [self setTitleColor:btnTextColor forState:UIControlStateNormal];
    if (self.underLined) {
        [self setNeedsDisplay];
    }
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setBtnImage:(UIImage *)btnImage {
    _btnImage = btnImage;
    [self setImage:btnImage forState:UIControlStateNormal];
}

- (void)setBkgImage:(UIImage *)bkgImage {
    _bkgImage = bkgImage;
    [self setBackgroundImage:bkgImage forState:UIControlStateNormal];
}

- (void)setNormalText:(NSString *)normalText {
    _normalText = normalText;
    [self setTitle:normalText forState:UIControlStateNormal];
}

- (void)setBorderWidth:(CGFloat )borderWidth {
    _borderWidth = borderWidth;
    self.layer.borderWidth = borderWidth;
}

- (void)setIsRoundCorner:(BOOL)isRoundCorner {
    _isRoundCorner = isRoundCorner;
    self.btnRadius = CGRectGetHeight(self.bounds)/2;
}

- (void)setFitSize:(BOOL)fitSize {
    _fitSize = fitSize;
    if (fitSize) {
        [self sizeToFit];
        CGRect frame = self.frame;
        frame.size.height = [self textSize].height;
        self.frame = frame;
    }
}

- (void)setUnderLined:(BOOL)underLined {
    _underLined = underLined;
    [self setNeedsDisplay];
}

- (UIImage *)imageWithColor:(UIColor *)color rect:(CGRect)rect {
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (CGSize)textSize {
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0) {
        return [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return [self.titleLabel.text sizeWithFont:self.titleLabel.font];
#pragma clang diagnostic pop
    }

}

@end

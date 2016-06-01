//
//  ZHBadgeView.m
//  ZHUIComponents
//
//  Created by Arron Zhu on 16/5/16.
//  Copyright © 2016年 arronz. All rights reserved.
//

#import "ZHBadgeView.h"

@interface ZHBadgeView ()

@property (nonatomic) CGFloat badgeTopPadding;
@property (nonatomic) CGFloat badgeLeftPadding;
@property (nonatomic) CGFloat whiteCircleWidth; //最外层白圈的宽度

@end

@implementation ZHBadgeView

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

- (void)setup {
    self.badgeBkgColor = [UIColor redColor];
    self.badgeTextColor = [UIColor whiteColor];
    self.badgeTextFont = [UIFont boldSystemFontOfSize:12];
    self.needWhiteCircle = NO;
    self.whiteCircleWidth = 2.f;
    self.backgroundColor = self.badgeBkgColor;
}

- (CGSize)badgeSizeWithStr:(NSString *)badgeValue{
    if (!badgeValue || badgeValue.length == 0) {
        return CGSizeZero;
    }
    CGSize size = [badgeValue sizeWithAttributes:@{NSFontAttributeName:self.badgeTextFont}];
    if (size.width < size.height) {
        size = CGSizeMake(size.height, size.height);
    }
    return size;
}

- (CGRect)frameWithStr:(NSString *)badgeValue{
    CGSize badgeSize = [self badgeSizeWithStr:badgeValue];
    CGRect badgeFrame = CGRectZero;
    if (self.needWhiteCircle) {
        badgeFrame = CGRectMake(self.frame.origin.x,
                                self.frame.origin.y,
                                badgeSize.width + self.badgeLeftPadding * 2 + self.whiteCircleWidth * 2,
                                badgeSize.height + self.badgeLeftPadding * 2 + self.whiteCircleWidth * 2);
    } else {
        badgeFrame = CGRectMake(self.frame.origin.x,
                                self.frame.origin.y,
                                badgeSize.width + self.badgeLeftPadding * 2,
                                badgeSize.height + self.badgeTopPadding * 2);
    }
    return badgeFrame;
}

- (void)setBadgeBkgColor:(UIColor *)badgeBkgColor {
    _badgeBkgColor = badgeBkgColor;
}

- (void)setBadgeTextFont:(UIFont *)badgeTextFont {
    _badgeTextFont = badgeTextFont;
}

- (void)setBadgeTextColor:(UIColor *)badgeTextColor {
    _badgeTextColor = badgeTextColor;
}

- (void)setNeedWhiteCircle:(BOOL)needWhiteCircle {
    _needWhiteCircle = needWhiteCircle;
    [self setNeedsDisplay];
}

- (void)setBadgeValue:(NSString *)badgeValue {
    _badgeValue = badgeValue;
    if (_badgeValue.integerValue > 9) {
        _badgeLeftPadding = 4.f;
    } else {
        _badgeLeftPadding = 2.f;
    }
    _badgeTopPadding = 2.f;
    
    self.frame = [self frameWithStr:badgeValue];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (self.badgeValue.length > 0) {
        [self drawWithContent:rect context:context];
    } else {
        [self drawWithOutContent:rect context:context];
    }
}

- (void)drawWithContent:(CGRect)rect context:(CGContextRef)context {
    CGRect bodyFrame = self.bounds;
    CGRect bkgFrame = CGRectInset(self.bounds, 0, 0);
    CGRect badgeSize = CGRectInset(self.bounds, self.badgeLeftPadding, self.badgeTopPadding);
    if (self.needWhiteCircle) {
        bkgFrame = CGRectInset(self.bounds, self.whiteCircleWidth, self.whiteCircleWidth);
        badgeSize = CGRectInset(self.bounds, self.whiteCircleWidth + self.badgeLeftPadding, self.whiteCircleWidth + self.badgeTopPadding);
        
        // 填充白色背景，作为最外层白圈
        CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
        
        // badgeValue为两个字符以上的长度时需要更大的宽度
        if (self.badgeValue.length > 1) {
            CGFloat circleWith = bodyFrame.size.height;
            CGFloat totalWidth = bodyFrame.size.width;
            CGFloat diffWidth = totalWidth - circleWith;
            CGPoint originPoint = bodyFrame.origin;
            CGRect leftCicleFrame = CGRectMake(originPoint.x, originPoint.y, circleWith, circleWith);
            CGRect centerFrame = CGRectMake(originPoint.x +circleWith/2, originPoint.y, diffWidth, circleWith);
            CGRect rightCicleFrame = CGRectMake(originPoint.x +(totalWidth - circleWith), originPoint.y, circleWith, circleWith);
            CGContextFillEllipseInRect(context, leftCicleFrame);
            CGContextFillRect(context, centerFrame);
            CGContextFillEllipseInRect(context, rightCicleFrame);
            
        } else {
            CGContextFillEllipseInRect(context, bodyFrame);
        }
        // badge背景色
        CGContextSetFillColorWithColor(context, [[self badgeBkgColor] CGColor]);
        if (self.badgeValue.length > 1) {
            CGFloat circleWith = bkgFrame.size.height;
            CGFloat totalWidth = bkgFrame.size.width;
            CGFloat diffWidth = totalWidth - circleWith;
            CGPoint originPoint = bkgFrame.origin;
            CGRect leftCicleFrame = CGRectMake(originPoint.x, originPoint.y, circleWith, circleWith);
            CGRect centerFrame = CGRectMake(originPoint.x +circleWith/2, originPoint.y, diffWidth, circleWith);
            CGRect rightCicleFrame = CGRectMake(originPoint.x +(totalWidth - circleWith), originPoint.y, circleWith, circleWith);
            CGContextFillEllipseInRect(context, leftCicleFrame);
            CGContextFillRect(context, centerFrame);
            CGContextFillEllipseInRect(context, rightCicleFrame);
        } else {
            CGContextFillEllipseInRect(context, bkgFrame);
        }
    } else {
        CGContextSetFillColorWithColor(context, [[self badgeBkgColor] CGColor]);
        if (self.badgeValue.length > 1) {
            CGFloat circleWith = bodyFrame.size.height;
            CGFloat totalWidth = bodyFrame.size.width;
            CGFloat diffWidth = totalWidth - circleWith;
            CGPoint originPoint = bodyFrame.origin;
            CGRect leftCicleFrame = CGRectMake(originPoint.x, originPoint.y, circleWith, circleWith);
            CGRect centerFrame = CGRectMake(originPoint.x +circleWith/2, originPoint.y, diffWidth, circleWith);
            CGRect rightCicleFrame = CGRectMake(originPoint.x +(totalWidth - circleWith), originPoint.y, circleWith, circleWith);
            CGContextFillEllipseInRect(context, leftCicleFrame);
            CGContextFillRect(context, centerFrame);
            CGContextFillEllipseInRect(context, rightCicleFrame);
            
        } else {
            CGContextFillEllipseInRect(context, bodyFrame);
        }
    }
    
    CGContextSetFillColorWithColor(context, [[self badgeTextColor] CGColor]);
    NSMutableParagraphStyle *badgeTextStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    [badgeTextStyle setLineBreakMode:NSLineBreakByWordWrapping];
    [badgeTextStyle setAlignment:NSTextAlignmentCenter];
    
    NSDictionary *badgeTextAttributes = @{NSFontAttributeName: [self badgeTextFont],
                                          NSForegroundColorAttributeName: [self badgeTextColor],
                                          NSParagraphStyleAttributeName: badgeTextStyle};
    if (self.needWhiteCircle) {
        [[self badgeValue] drawInRect:CGRectMake(self.whiteCircleWidth + self.badgeLeftPadding,
                                                 self.whiteCircleWidth + self.badgeTopPadding,
                                                 badgeSize.size.width,
                                                 badgeSize.size.height)
                       withAttributes:badgeTextAttributes];
    } else {
        [[self badgeValue] drawInRect:CGRectMake(self.badgeLeftPadding,
                                                 self.badgeTopPadding,
                                                 badgeSize.size.width,
                                                 badgeSize.size.height)
                       withAttributes:badgeTextAttributes];
    }
}

- (void)drawWithOutContent:(CGRect)rect context:(CGContextRef)context{
    CGRect bodyFrame = self.bounds;
    CGContextSetFillColorWithColor(context, [[UIColor redColor] CGColor]);
    CGContextFillEllipseInRect(context, bodyFrame);
}

@end
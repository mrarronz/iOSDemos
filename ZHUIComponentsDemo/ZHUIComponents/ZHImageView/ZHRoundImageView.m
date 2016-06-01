//
//  ZHRoundImageView.m
//  ZHUIComponents
//
//  Created by Arron Zhu on 16/5/13.
//  Copyright © 2016年 arronz. All rights reserved.
//

#import "ZHRoundImageView.h"

@implementation ZHRoundImageView

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

- (instancetype)initWithImage:(UIImage *)image {
    self = [super initWithImage:image];
    if (self) {
        CGRect frame = self.frame;
        frame.size.width = image.size.width;
        frame.size.height = image.size.height;
        self.frame = frame;
        self.layer.cornerRadius = image.size.height/2;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setup {
    self.layer.cornerRadius = CGRectGetHeight(self.frame)/2;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    self.layer.borderWidth = borderWidth;
}

- (void)setRadius:(CGFloat)radius {
    _radius = radius;
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

@end

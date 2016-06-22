//
//  CustomToolbar.m
//  ZHShoppingCartDemo
//
//  Created by Arron Zhu on 16/6/22.
//  Copyright © 2016年 arronz. All rights reserved.
//

#import "CustomToolbar.h"
#import "UIView+Corner.h"

@interface CustomToolbar ()

@property (nonatomic, strong) UIButton *shoppingCartButton;
@property (nonatomic, strong) UILabel *countLabel;

@end

@implementation CustomToolbar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.cartView];
        CGPoint centerPoint = CGPointMake(frame.size.width - 50, frame.size.height/2);
        self.cartView.center = centerPoint;
    }
    return self;
}

- (void)setItemCount:(NSInteger)itemCount {
    _itemCount = itemCount;
    self.countLabel.hidden = (itemCount == 0);
    [self resizeLabelFrame];
}

- (UIButton *)shoppingCartButton {
    if (!_shoppingCartButton) {
        _shoppingCartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shoppingCartButton setImage:[UIImage imageNamed:@"icon_cart"] forState:UIControlStateNormal];
        [_shoppingCartButton sizeToFit];
    }
    return _shoppingCartButton;
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _countLabel.font = [UIFont boldSystemFontOfSize:10];
        _countLabel.textColor = [UIColor whiteColor];
        _countLabel.backgroundColor = [UIColor redColor];
        _countLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _countLabel;
}

- (UIView *)cartView {
    if (!_cartView) {
        _cartView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 60)];
        _cartView.backgroundColor = [UIColor clearColor];
        [_cartView addSubview:self.shoppingCartButton];
        [_cartView addSubview:self.countLabel];
        
        self.shoppingCartButton.center = CGPointMake(CGRectGetMidX(_cartView.bounds), CGRectGetMidY(_cartView.bounds));
        [self resizeLabelFrame];
    }
    return _cartView;
}

- (void)resizeLabelFrame {
    if (_itemCount == 0) {
        return;
    }
    NSString *text = [NSString stringWithFormat:@"%zd", _itemCount];
    self.countLabel.text = text;
    CGSize textSize = [text sizeWithAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:10]}];
    CGFloat maxValue = MAX(textSize.width, textSize.height);
    CGSize labelSize = CGSizeMake(maxValue + 5, maxValue + 5);
    self.countLabel.frame = CGRectMake(self.countLabel.frame.origin.x, self.countLabel.frame.origin.y, labelSize.width, labelSize.height);
    CGFloat centerX = CGRectGetWidth(self.shoppingCartButton.bounds) + CGRectGetMinX(self.shoppingCartButton.frame);
    CGFloat centerY = CGRectGetMinY(self.shoppingCartButton.frame);
    self.countLabel.center = CGPointMake(centerX, centerY);
    [self.countLabel addCornerRadius:labelSize.height/2];
}

@end

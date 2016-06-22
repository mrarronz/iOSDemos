//
//  ShoppingItemCell.m
//  ZHShoppingCartDemo
//
//  Created by Arron Zhu on 16/6/22.
//  Copyright © 2016年 arronz. All rights reserved.
//

#import "ShoppingItemCell.h"
#import "UIView+Corner.h"
#import "UIColor+Util.h"

@implementation ShoppingItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 设置图片
    CGFloat cornerRadius = self.itemImageView.frame.size.width/2;
    [self.itemImageView addCornerRadius:cornerRadius];
    self.itemImageView.image = [self.itemImageView.backgroundColor colorToImage];
    
    // 设置button
    [self.buyButton addCornerRadius:3.0];
    UIColor *pressedColor = [UIColor colorWithWhite:0.2 alpha:0.5];
    [self.buyButton setBackgroundImage:[self.buyButton.backgroundColor colorToImage] forState:UIControlStateNormal];
    [self.buyButton setBackgroundImage:[pressedColor colorToImage] forState:UIControlStateHighlighted];
}

- (void)setItemColor:(UIColor *)itemColor {
    _itemColor = itemColor;
    self.itemImageView.image = [itemColor colorToImage];
}

- (IBAction)buyButtonClicked:(id)sender {
    if (self.shoppingCartBlock) {
        self.shoppingCartBlock(self.itemImageView);
    }
}

@end

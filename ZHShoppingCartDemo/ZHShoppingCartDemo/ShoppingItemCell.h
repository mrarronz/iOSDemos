//
//  ShoppingItemCell.h
//  ZHShoppingCartDemo
//
//  Created by Arron Zhu on 16/6/22.
//  Copyright © 2016年 arronz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShoppingCartBlock)(UIImageView *imageView);

@interface ShoppingItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
@property (copy, nonatomic) ShoppingCartBlock shoppingCartBlock;
@property (strong, nonatomic) UIColor *itemColor;

@end

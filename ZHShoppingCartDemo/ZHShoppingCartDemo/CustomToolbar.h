//
//  CustomToolbar.h
//  ZHShoppingCartDemo
//
//  Created by Arron Zhu on 16/6/22.
//  Copyright © 2016年 arronz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomToolbar : UIToolbar

@property (nonatomic, strong) UIView *cartView;
@property (nonatomic, assign) NSInteger itemCount;

@end

//
//  ZHRoundImageView.h
//  ZHUIComponents
//
//  Created by Arron Zhu on 16/5/13.
//  Copyright © 2016年 arronz. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface ZHRoundImageView : UIImageView

@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, strong) IBInspectable UIColor *borderColor;
@property (nonatomic, assign) IBInspectable CGFloat radius;

@end

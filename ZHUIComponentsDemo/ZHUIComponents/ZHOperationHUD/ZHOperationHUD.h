//
//  ZHOperationHUD.h
//  ZHUIComponents
//
//  Created by Arron Zhu on 16/5/16.
//  Copyright © 2016年 arronz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHOperationHUD : UIView

@property (nonatomic, strong) UIImage *closeImage;
@property (nonatomic, strong) UIImage *promptImage;
@property (nonatomic, strong) UIColor *labelColor;
@property (nonatomic, strong) UIFont *labelFont;
@property (nonatomic, copy) NSString *labelText;
@property (nonatomic, assign) BOOL isBlur;

@end

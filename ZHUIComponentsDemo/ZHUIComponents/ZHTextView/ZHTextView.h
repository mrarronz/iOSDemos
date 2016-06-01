//
//  ZHTextView.h
//  ZHUIComponents
//
//  Created by Arron Zhu on 16/5/13.
//  Copyright © 2016年 arronz. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface ZHTextView : UITextView

@property (nonatomic, copy)   IBInspectable NSString *placeholder;
@property (nonatomic, strong) IBInspectable UIColor *placeholderColor;

@end

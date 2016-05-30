//
//  BaseViewController.m
//  TransforCoreData
//
//  Created by Arron Zhu on 16/1/15.
//  Copyright © 2016年 ArronZ. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end

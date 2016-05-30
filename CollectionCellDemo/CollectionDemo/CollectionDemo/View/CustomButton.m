//
//  CustomButton.m
//  CollectionDemo
//
//  Created by AAA on 16/4/11.
//  Copyright © 2016年 AAA. All rights reserved.
//

#import "CustomButton.h"
#import "UIColor+Utils.h"

@implementation CustomButton

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self setBackgroundImage:[[UIColor colorWithHexString:@"#DCDCDC"] imageWithColorInRect:rect]
                    forState:UIControlStateHighlighted];
}

@end

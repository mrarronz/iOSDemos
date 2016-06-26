//
//  ViewController.m
//  ZHAlertView
//
//  Created by Arron Zhu on 16/6/22.
//  Copyright © 2016年 arronz. All rights reserved.
//

#import "ViewController.h"
#import "ZHAlertView.h"

@interface ViewController ()<ZHAlertViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClicked:(id)sender {
    ZHAlertView *alert = [[ZHAlertView alloc] initWithTitle:@"提示啦啦啦啦啦啦啦啦啦啦来来来啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦"
                                                    message:@"哔哩哔哩哔哩哔哩哗啦哗啦哗啦哗啦好了好了来来来啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦来来来啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦来来来啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦来来来啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦来来来啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦来来来啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦来来来啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦来来来啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦来来来啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦"
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                           otherButtonTitle:@"确定"];
//    alert.alertImage = [UIImage imageNamed:@"icon_delete"];
    [alert show];
}

- (IBAction)button2Clicked:(id)sender {
    ZHAlertView *alert = [[ZHAlertView alloc] initWithTitle:@"提示啦啦啦啦啦啦啦"
                                                    message:@"您确定要删除吗？删除后将无"
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                           otherButtonTitle:nil];
    alert.themeColor = [UIColor colorWithRed:0.898 green:0.16 blue:0.255 alpha:1.0];
//    alert.footerColor = [UIColor whiteColor];
//    alert.headerImage = [UIImage imageNamed:@"icon_delete"];
//    alert.alertImage = [UIImage imageNamed:@"icon_delete"];
    [alert show];
}

- (void)alert:(ZHAlertView *)alert didClickButtonAtIndex:(NSInteger)index {
    NSLog(@"ZHAlert button index = %zd", index);
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end

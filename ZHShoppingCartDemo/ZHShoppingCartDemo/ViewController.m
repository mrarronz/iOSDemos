//
//  ViewController.m
//  ZHShoppingCartDemo
//
//  Created by Arron Zhu on 16/6/22.
//  Copyright © 2016年 arronz. All rights reserved.
//

#import "ViewController.h"
#import "ShoppingItemCell.h"
#import "CustomToolbar.h"
#import "UIColor+Util.h"

#define UI_SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define UI_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

static NSString *const reuseIdentifier = @"ShoppingItemCell";

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate> {
    UIBezierPath *_animatePath;
    NSInteger _count;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) CALayer *imageLayer;
@property (strong, nonatomic) CustomToolbar *bottomBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 80;
    _bottomBar = [[CustomToolbar alloc] initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT - 60, UI_SCREEN_WIDTH, 60)];
    [self.view addSubview:_bottomBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShoppingItemCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ShoppingItemCell class])
                                              owner:self
                                            options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.itemColor = [UIColor randomColor];
    cell.descriptionLabel.text = [NSString stringWithFormat:@"商品%zd", indexPath.row];
    cell.shoppingCartBlock = ^(UIImageView *imageView) {
        CGRect cellRect = [tableView rectForRowAtIndexPath:indexPath];
        // 得到cell在tableView上的位置，tableView没有偏移时
        cellRect.origin.y -= tableView.contentOffset.y;
        CGRect itemImageRect = imageView.frame;
        
        // 获取itemImageView在tableView上的位置，纵坐标
        itemImageRect.origin.y += cellRect.origin.y;
        
        // 根据图片的位置开始显示动画
        [self beginAnimationWithRect:itemImageRect imageView:imageView];
    };
    return cell;
}

- (void)beginAnimationWithRect:(CGRect)rect imageView:(UIImageView *)imageView {
    if (!_imageLayer) {
        _imageLayer = [CALayer layer];
        _imageLayer.contents = (id)imageView.layer.contents;
        _imageLayer.contentsGravity = kCAGravityResizeAspectFill;
        _imageLayer.bounds = rect;
        _imageLayer.cornerRadius = rect.size.height/2;
        _imageLayer.masksToBounds = YES;
        // 设置初始位置
        _imageLayer.position = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
        [self.view.layer addSublayer:_imageLayer];
        
        _animatePath = [UIBezierPath bezierPath];
        [_animatePath moveToPoint:_imageLayer.position];
        
        // 计算终点位置
        CGRect cartViewRect = self.bottomBar.cartView.frame;
        CGFloat centerX = cartViewRect.origin.x + CGRectGetWidth(cartViewRect)/2;
        CGFloat centerY = UI_SCREEN_HEIGHT - CGRectGetHeight(self.bottomBar.frame);
        
        // 设置曲线的终点和基准点
        [_animatePath addQuadCurveToPoint:CGPointMake(centerX, centerY)
                             controlPoint:CGPointMake(UI_SCREEN_WIDTH/2, rect.origin.y - 80)];
    }
    [self addGroupAnimation];
}

- (void)addGroupAnimation {
    self.tableView.userInteractionEnabled = NO;
    
    // 设置动画路径
    CAKeyframeAnimation *keyframeAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyframeAnim.path = _animatePath.CGPath;
    keyframeAnim.rotationMode = kCAAnimationRotateAuto;
    keyframeAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    // 设置缩放动画
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnim.fromValue = @(1.0);
    scaleAnim.toValue = @(0.3);
    scaleAnim.duration = 0.8;
    scaleAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[keyframeAnim, scaleAnim];
    group.duration = 0.8;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.delegate = self;
    
    [_imageLayer addAnimation:group forKey:@"groupAnimation"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (anim == [_imageLayer animationForKey:@"groupAnimation"]) {
        self.tableView.userInteractionEnabled = YES;
        
        [_imageLayer removeFromSuperlayer];
        _imageLayer = nil;
        _count ++;
        self.bottomBar.itemCount = _count;
    }
}

@end

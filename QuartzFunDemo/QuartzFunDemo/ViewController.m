//
//  ViewController.m
//  QuartzFunDemo
//
//  Created by Arron Zhu on 16/5/30.
//  Copyright © 2016年 arronz. All rights reserved.
//

#import "ViewController.h"
#import "QuartzFunView.h"
#import "UIColor+Random.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *colorControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *shapeControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeShape:(id)sender {
    UISegmentedControl *segment = (UISegmentedControl *)sender;
    NSInteger index = segment.selectedSegmentIndex;
    QuartzFunView *funView = (QuartzFunView *)self.view;
    [funView setShapeType:index];
    if (index == kImageShape) {
        self.colorControl.hidden = YES;
    } else {
        self.colorControl.hidden = NO;
    }
}

- (IBAction)changeColor:(id)sender {
    UISegmentedControl *segment = (UISegmentedControl *)sender;
    NSInteger index = segment.selectedSegmentIndex;
    QuartzFunView *funView = (QuartzFunView *)self.view;
    funView.useRandomColor = NO;
    switch (index) {
        case kRedColorTab:
            funView.currentColor = [UIColor redColor];
            break;
        case kBlueColorTab:
            funView.currentColor = [UIColor blueColor];
            break;
        case kGreenColorTab:
            funView.currentColor = [UIColor greenColor];
            break;
        case kYellowColorTab:
            funView.currentColor = [UIColor yellowColor];
            break;
        case kRandomColorTab:
            funView.currentColor = [UIColor randomColor];
            funView.useRandomColor = YES;
            break;
        default:
            break;
    }
}


@end

//
//  ColorPickViewController.m
//  TransforCoreData
//
//  Created by Arron Zhu on 16/1/15.
//  Copyright © 2016年 ArronZ. All rights reserved.
//

#import "ColorPickViewController.h"
#import "NSString+Validation.h"
#import "UIColor+Hex.h"
#import "Transformer.h"
#import "DBHelper.h"

#define kColorValueLength 6

@interface ColorPickViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *colorTextField;

@end

@implementation ColorPickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self readColor];
}

- (IBAction)onClickAddColorButton:(id)sender {
    if (self.colorTextField.text.length < kColorValueLength) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Color Code length is 6 digit" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    [self saveColor];
}

- (void)saveColor {
    NSManagedObjectContext *context = [CoreDataWrapper instance].mainContext;
    Transformer *transform = [DBHelper findTransformerById:1];
    if (!transform) {
        transform = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Transformer class]) inManagedObjectContext:context];
        transform.testId = @(1);
        transform.available = @(YES);
        transform.name = @"Hello Color";
    }
    transform.color = [UIColor colorWithHexString:self.colorTextField.text];
    NSError *error;
    BOOL result = [context save:&error];
    if (result) {
        [self readColor];
    }
}

- (void)readColor {
    Transformer *transform = [DBHelper findTransformerById:1];
    if (transform) {
        self.view.backgroundColor = (UIColor *)transform.color;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if (![string isValidColorValue]) {
        return NO;
    }
    if (textField.text.length >= kColorValueLength) {
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end

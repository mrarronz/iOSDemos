//
//  EnterPersonInfoViewController.m
//  TransforCoreData
//
//  Created by Arron Zhu on 16/1/15.
//  Copyright © 2016年 ArronZ. All rights reserved.
//

#import "EnterPersonInfoViewController.h"
#import "NSString+Validation.h"
#import "Person.h"
#import "DBHelper.h"


#define UI_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define UI_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface EnterPersonInfoViewController ()<UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UITextField *genderTextField;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (strong, nonatomic) UIView *pickerView;
@property (strong, nonatomic) NSArray *genderArray;
@property (assign, nonatomic) NSInteger selectedIndex;

@end

@implementation EnterPersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.genderArray = @[@"male", @"female"];
    _selectedIndex = 0;
    [self readPerson];
}

- (void)savePerson {
    Person *person = [[Person alloc] init];
    person.name = self.nameTextField.text;
    person.age = self.ageTextField.text.integerValue;
    person.gender = self.genderTextField.text;
    Transformer *transform = [DBHelper findTransformerById:3];
    NSManagedObjectContext *context = [CoreDataWrapper instance].mainContext;
    if (!transform) {
        transform = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Transformer class]) inManagedObjectContext:context];
        transform.testId = @(3);
        transform.name = @"Hello Object";
        transform.available = @(NO);
    }
    transform.person = person;
    NSError *error;
    BOOL result = [context save:&error];
    if (result) {
        [self readPerson];
    }
}

- (void)readPerson {
    Transformer *transform = [DBHelper findTransformerById:3];
    if (transform) {
        self.nameLabel.text = [NSString stringWithFormat:@"名称：%@", transform.person.name];
        self.ageLabel.text = [NSString stringWithFormat:@"年龄：%zd", transform.person.age];
        self.genderLabel.text = [NSString stringWithFormat:@"性别：%@", transform.person.gender];
    }
}

- (IBAction)onClickAddPersonInfo:(id)sender {
    if (self.nameTextField.text.length == 0 || self.ageTextField.text.length == 0 || self.genderTextField.text == 0) {
        return;
    }
    [self savePerson];
}

- (void)doneButtonPressed:(id)sender {
    [self showPicker:NO];
    self.genderTextField.text = [self.genderArray objectAtIndex:_selectedIndex];
}

- (void)showPicker:(BOOL)show {
    if (show) {
        [self.view addSubview:self.pickerView];
    }
    CGFloat originY = show ? UI_SCREEN_HEIGHT - CGRectGetHeight(self.pickerView.bounds) : UI_SCREEN_HEIGHT;
    [UIView animateWithDuration:0.25 animations:^{
        CGRect pickerFrame = self.pickerView.frame;
        pickerFrame.origin.y = originY;
        self.pickerView.frame = pickerFrame;
    } completion:^(BOOL finished) {
        if (!show) {
            [self.pickerView removeFromSuperview];
        }
    }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if (textField == self.ageTextField && ![string isPureNumber]) {
        return NO;
    }
    if (textField == self.ageTextField && textField.text.length >= 3) {
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.nameTextField) {
        [self.ageTextField becomeFirstResponder];
    } else if (textField == self.ageTextField) {
        [textField resignFirstResponder];
        [self showPicker:YES];
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.genderTextField) {
        [self.view endEditing:YES];
        [self showPicker:YES];
        return NO;
    }
    return YES;
}

#pragma mark - UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.genderArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.genderArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _selectedIndex = row;
}

#pragma mark - Init Property

- (UIView *)pickerView {
    if (!_pickerView) {
        UIToolbar *toolBar = [self keyboardToolBar];
        UIPickerView *genderPicker = [self genderPicker];
        CGFloat totalHeight = CGRectGetHeight(toolBar.bounds) + CGRectGetHeight(genderPicker.bounds);
        
        _pickerView = [[UIView alloc] initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, totalHeight)];
        [_pickerView addSubview:toolBar];
        [_pickerView addSubview:genderPicker];
    }
    return _pickerView;
}

- (UIPickerView *)genderPicker {
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, UI_SCREEN_WIDTH, 180)];
    picker.backgroundColor = [UIColor whiteColor];
    picker.dataSource = self;
    picker.delegate = self;
    picker.showsSelectionIndicator = YES;
    return picker;
}

- (UIToolbar *)keyboardToolBar {
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 40)];
    toolBar.backgroundColor = [UIColor whiteColor];
    toolBar.barTintColor = [UIColor whiteColor];
    
    UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)];
    toolBar.items = @[flexibleItem, doneItem];
    return toolBar;
}

@end

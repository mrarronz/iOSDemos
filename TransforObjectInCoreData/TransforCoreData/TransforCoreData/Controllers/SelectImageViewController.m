//
//  SelectImageViewController.m
//  TransforCoreData
//
//  Created by Arron Zhu on 16/1/15.
//  Copyright © 2016年 ArronZ. All rights reserved.
//

#import "SelectImageViewController.h"
#import "UIColor+Hex.h"
#import "DBHelper.h"

@interface SelectImageViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;

@end

@implementation SelectImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView1.layer.borderWidth = 1;
    self.imageView1.layer.borderColor = [UIColor colorWithHexString:@"#CCCCCC"].CGColor;
    self.imageView1.layer.cornerRadius = 2.f;
    self.imageView1.layer.masksToBounds = YES;
    self.imageView1.contentMode = UIViewContentModeScaleAspectFill;
    
    self.imageView2.layer.borderWidth = 1;
    self.imageView2.layer.borderColor = [UIColor colorWithHexString:@"#CCCCCC"].CGColor;
    self.imageView2.layer.cornerRadius = 2.f;
    self.imageView2.layer.masksToBounds = YES;
    self.imageView1.contentMode = UIViewContentModeScaleAspectFit;
    
    [self readImage];
}

- (void)readImage {
    Transformer *transform = [DBHelper findTransformerById:2];
    if (transform) {
        self.imageView1.image = [UIImage imageWithData:transform.image];
        self.imageView2.image = transform.logo;
    }
}

- (void)saveImage:(UIImage *)image withLogo:(UIImage *)logo {
    Transformer *transform = [DBHelper findTransformerById:2];
    NSManagedObjectContext *context = [CoreDataWrapper instance].mainContext;
    if (!transform) {
        transform = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Transformer class]) inManagedObjectContext:context];
        transform.testId = @(2);
        transform.name = @"Hello Image";
        transform.available = @(YES);
    }
    if (image) {
        transform.image = UIImagePNGRepresentation(image);
    }
    if (logo) {
        transform.logo = logo;
    }
    NSError *error;
    BOOL result = [context save:&error];
    if (result) {
        [self readImage];
    }
}

- (IBAction)onClickTakePhotosButton:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = YES;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Camera is unavailable"
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (IBAction)onClickSelectImageButton:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Authorization to photos"
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:^{
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            [self saveImage:image withLogo:nil];
        } else {
            [self saveImage:nil withLogo:image];
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end

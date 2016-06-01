//
//  RootTableViewController.m
//  UIComponentsSample
//
//  Created by Arron Zhu on 16/5/23.
//  Copyright © 2016年 arronz. All rights reserved.
//

#import "RootTableViewController.h"

@interface RootTableViewController ()

@property (nonatomic, strong) NSArray *items;

@end

@implementation RootTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _items = @[@"Badge", @"Button", @"ImageView", @"OperationHUD", @"TextView"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellReuseIdentifier" forIndexPath:indexPath];
    cell.textLabel.text = [self.items objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"showBadge" sender:self];
    }
    else if (indexPath.row == 1) {
        [self performSegueWithIdentifier:@"showButton" sender:self];
    }
    else if (indexPath.row == 2) {
        [self performSegueWithIdentifier:@"showImageView" sender:self];
    }
    else if (indexPath.row == 3) {
        
    }
    else if (indexPath.row == 4) {
        [self performSegueWithIdentifier:@"showTextView" sender:self];
    }
}

@end

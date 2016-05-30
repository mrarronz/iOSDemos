//
//  ViewController.m
//  TransforCoreData
//
//  Created by Arron Zhu on 16/1/13.
//  Copyright © 2016年 ArronZ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *dataArray;

@end

static NSString *const reuseIdentifier = @"CellReuseIdentifier";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[@"Store color", @"Store image", @"Store custom object"];
    self.tableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"ColorSegueIdentifier" sender:self];
    } else if (indexPath.row == 1) {
        [self performSegueWithIdentifier:@"ImageSegueIdentifier" sender:self];
    } else {
        [self performSegueWithIdentifier:@"PersonSegueIdentifier" sender:self];
    }
}

@end

//
//  ViewController.m
//  CollectionDemo
//
//  Created by AAA on 16/4/8.
//  Copyright © 2016年 AAA. All rights reserved.
//

#import "ViewController.h"
#import "CollectionCell.h"

#define DEFAULT_COLLUMN 4

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, CollectionCellDelegate> {
    NSMutableArray *_array1;
    NSMutableArray *_array2;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initData {
    _array1 = [NSMutableArray arrayWithArray:@[@"sss", @"ddd", @"fff", @"ggg", @"hhh", @"kkk", @"lll", @"ooo", @"ppp", @"iii"]];
    _array2 = [NSMutableArray arrayWithArray:@[@"uuu", @"eee", @"222", @"333", @"555", @"666"]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"reuseIdentifier";
    CollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[CollectionCell alloc] initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:cellIdentifier
                                             collumn:DEFAULT_COLLUMN];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 0) {
        cell.items = _array1;
    } else {
        cell.items = _array2;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSInteger rows = [self divideCollumn:DEFAULT_COLLUMN withTotalCount:_array1.count];
        CGFloat height = rows * DEFAULT_ROW_HEIGHT;
        return height;
    } else {
        NSInteger rows = [self divideCollumn:DEFAULT_COLLUMN withTotalCount:_array2.count];
        CGFloat height = rows * DEFAULT_ROW_HEIGHT;
        return height;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 40;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
        headerView.backgroundColor = [UIColor yellowColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, self.view.frame.size.width - 30, 20)];
        label.text = @"This is the section header";
        label.font = [UIFont systemFontOfSize:15];
        [headerView addSubview:label];
        
        return headerView;
    }
    return nil;
}

- (void)cell:(CollectionCell *)cell didSelectIndex:(NSInteger)index inItems:(NSArray *)items {
    NSLog(@"%zd", index);
    NSLog(@"%@", items);
    NSString *title = [items objectAtIndex:index];
    NSString *message = [NSString stringWithFormat:@"index: %zd", index];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (NSInteger)divideCollumn:(NSInteger)collumn withTotalCount:(NSInteger)total {
    return (total % collumn == 0) ? total/collumn : total/collumn+1;
}

@end

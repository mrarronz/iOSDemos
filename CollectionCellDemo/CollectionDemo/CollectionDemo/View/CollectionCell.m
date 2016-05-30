//
//  CollectionCell.m
//  CollectionDemo
//
//  Created by AAA on 16/4/8.
//  Copyright © 2016年 AAA. All rights reserved.
//

#import "CollectionCell.h"
#import "CustomButton.h"
#import "UIColor+Utils.h"

#define UI_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define UI_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation CollectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier collumn:(NSInteger)collumn {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _collumn = collumn;
    }
    return self;
}

- (void)setItems:(NSArray *)items {
    _items = items;
    
    // button的行数
    NSInteger rowCount = (_items.count % _collumn == 0) ? _items.count/_collumn : _items.count/_collumn + 1;
    
    // 每个button的宽度
    CGFloat width = UI_SCREEN_WIDTH/_collumn;
    
    for (int i = 0; i < _items.count; i++) {
        CustomButton *button = [self generateButton];
        [button setTitle:_items[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        if (i < _collumn) {
            button.frame = CGRectMake(i * width, 0, width, DEFAULT_ROW_HEIGHT);
        } else {
            NSInteger j =  i - (i/_collumn) * _collumn;
            button.frame = CGRectMake(j * width, (i/_collumn)*DEFAULT_ROW_HEIGHT, width, DEFAULT_ROW_HEIGHT);
        }
        [self.contentView addSubview:button];
    }
    
    // 横线
    for (int i = 0; i <= rowCount; i ++) {
        UIView *lineView = [self lineView];
        CGFloat y = (i == rowCount) ? i * DEFAULT_ROW_HEIGHT - 0.5 : i * DEFAULT_ROW_HEIGHT;
        lineView.frame = CGRectMake(0, y, UI_SCREEN_WIDTH, 0.5);
        [self.contentView addSubview:lineView];
    }
    
    // 竖线
    for (int i = 1; i < _collumn; i ++) {
        UIView *lineView = [self lineView];
        lineView.frame = CGRectMake(i * width, 0, 0.5, rowCount * DEFAULT_ROW_HEIGHT);
        [self.contentView addSubview:lineView];
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier collumn:(NSInteger)collumn items:(NSArray *)items {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _collumn = collumn;
        self.items = items;
    }
    return self;
}

- (void)prepareForReuse {
    _items = nil;
    _collumn = 1;
    [super prepareForReuse];
}

- (CustomButton *)generateButton {
    CustomButton *button = [CustomButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    return button;
}

- (UIView *)lineView {
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#DCDCDC"];
    return lineView;
}

- (void)buttonClicked:(id)sender {
    CustomButton *button = (CustomButton *)sender;
    if ([self.delegate respondsToSelector:@selector(cell:didSelectIndex:inItems:)]) {
        [self.delegate cell:self didSelectIndex:button.tag inItems:_items];
    }
}

@end

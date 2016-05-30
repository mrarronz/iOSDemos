//
//  CollectionCell.h
//  CollectionDemo
//
//  Created by AAA on 16/4/8.
//  Copyright © 2016年 AAA. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DEFAULT_ROW_HEIGHT 80

@class CollectionCell;

@protocol CollectionCellDelegate <NSObject>

@optional
- (void)cell:(CollectionCell *)cell didSelectIndex:(NSInteger)index inItems:(NSArray *)items;

@end

@interface CollectionCell : UITableViewCell

@property (assign, nonatomic) NSInteger collumn;
@property (strong, nonatomic) NSArray *items;
@property (assign, nonatomic) id<CollectionCellDelegate> delegate;

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                      collumn:(NSInteger)collumn
                        items:(NSArray *)items;

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                      collumn:(NSInteger)collumn;

@end

//
//  HGTabCell.m
//  HGTabView
//
//  Created by  ZhuHong on 16/3/22.
//  Copyright © 2016年 HG. All rights reserved.
//

#import "HGTabCell.h"
#import "HGLineView.h"
#import "HGTabMode.h"

@interface HGTabCell ()

@property (nonatomic, weak) UILabel* label;

@end

@implementation HGTabCell

// 构造方法
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    // 设置选中状态下的backgroundView
    self.selectedBackgroundView = [[HGLineView alloc] init];
    
    UILabel* label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:16.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor darkGrayColor];
    
    label.text = @"测试";
    
    [self.contentView addSubview:label];
    self.label = label;
    
    return self;
}

// set方法
- (void)setMode:(HGTabMode *)mode {
    _mode = mode;
    
    self.label.text = mode.contentStr;
    self.label.textColor = mode.hgSelected?[UIColor redColor]:[UIColor darkGrayColor];
}

// 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.label.frame = self.contentView.bounds;
    
}

@end

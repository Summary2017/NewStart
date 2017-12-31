//
//  HGSelectCell.m
//  HGTabView
//
//  Created by  ZhuHong on 16/3/27.
//  Copyright © 2016年 HG. All rights reserved.
//

#import "HGSelectCell.h"

@interface HGSelectCell ()

@property (nonatomic, weak) UILabel* label;

@end

@implementation HGSelectCell

// 构造方法
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    UILabel* label = [[UILabel alloc] init];
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = 2.0;
    label.layer.borderColor = RGB(152, 170, 59).CGColor;
    label.layer.borderWidth = 1.0;
    label.font = [UIFont systemFontOfSize:16.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor darkGrayColor];
    
    
    label.text = @"测试";
    
    [self.contentView addSubview:label];
    self.label = label;
    
    return self;
}

- (void)setContenteStr:(NSString *)contenteStr {
    _contenteStr = [contenteStr copy];
    
    self.label.text = _contenteStr;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.label.frame = self.bounds;
}


@end

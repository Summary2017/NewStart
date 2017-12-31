//
//  HGLineView.m
//  HGTabView
//
//  Created by  ZhuHong on 16/3/22.
//  Copyright © 2016年 HG. All rights reserved.
//

#import "HGLineView.h"
#import "UIView+HG.h"

@interface HGLineView ()

/** 下划线 */
@property (nonatomic, weak) UIView* lineView;

@end

@implementation HGLineView

/** 构造方法 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    UIView* lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor redColor];
    [self addSubview:lineView];
    self.lineView = lineView;
    
    return self;
}

// 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    
    self.lineView.frame = CGRectMake(0, height-2.0, width, 2.0);
}

@end


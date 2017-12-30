//
//  HomeBottomView.m
//  NewStart
//
//  Created by  ZhuHong on 2017/12/30.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "HomeBottomView.h"
#import "BaseButton.h"
#import "HomeModel.h"

@interface HomeBottomView ()

/** 评论数 */
@property (nonatomic, weak) UILabel* commentsLabel;
/** 更多 */
@property (nonatomic, weak) BaseButton* moreBtn;

@end

@implementation HomeBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    /** 评论数 */
    UILabel* commentsLabel = [[UILabel alloc] init];
    commentsLabel.font = Font(10.0);
    commentsLabel.textColor = [UIColor grayColor];
    [self addSubview:commentsLabel];
    self.commentsLabel = commentsLabel;
    
    /** 更多 */
    BaseButton* moreBtn = [BaseButton okaButton];
    moreBtn.okaTitle = @"···";
    [moreBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    // 右对齐
    moreBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [moreBtn addTarget:self action:@selector(moreAction)];
    [self addSubview:moreBtn];
    self.moreBtn = moreBtn;
    
    return self;
}

- (void)setHomeModel:(HomeModel *)homeModel {
    _homeModel = homeModel;
    self.commentsLabel.text = homeModel.commentsSTR;
    
    self.frame = homeModel.bottomFrame;
}

#pragma mark -
#pragma mark - 点击事件
- (void)moreAction {
    DLog(@"你点击了 更多 的按钮")
}

// 系统子视图的布局方法
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    self.commentsLabel.frame = CGRectMake(0, 0, 100, height);
    self.moreBtn.frame = CGRectMake(width-80, 0, 80, height);
}

@end

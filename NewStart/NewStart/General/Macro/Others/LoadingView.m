//
//  LoadingView.m
//  NewStart
//
//  Created by  ZhuHong on 2017/12/27.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "LoadingView.h"
#import "UILabel+LockScreen.h"

@interface LoadingView ()

// 提示文本
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;

// 显示状态
@property (nonatomic, assign, getter=isShowing) BOOL showing;

@end

@implementation LoadingView

- (void)awakeFromNib {
    [super awakeFromNib];
    // 滑动效果
    [self.tipsLabel setLockScreen];
}

// 显示
- (void)loadingShow {
    if (self.isShowing) {
        return;
    }
    
    self.showing = YES;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

// 隐藏
- (void)loadingHidden {
    if (!self.isShowing || !self.superview) {
        return;
    }
    
    self.showing = NO;
    
    [self removeFromSuperview];
}

@end

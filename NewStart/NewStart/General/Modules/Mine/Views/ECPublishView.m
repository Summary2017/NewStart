//
//  ECPublishView.m
//  ElecCarManager
//
//  Created by XXL on 16/8/11.
//  Copyright © 2016年 BBDTek. All rights reserved.
//

#import "ECPublishView.h"
#import "NSString+Color.h"
#import "BaseButton.h"
#import "UIView+HG.h"

@interface ECPublishView ()

@property (strong, nonatomic) UIImageView *publishFrame;
@property (strong, nonatomic) UIImageView *publishLine;
@property (strong, nonatomic) UIControl *maskView;

@property (strong, nonatomic) BaseButton *publishSourceButton;
@property (strong, nonatomic) BaseButton *publishFindingButton;

@property (assign, nonatomic) CGPoint arowOrigin;

@end
@implementation ECPublishView

+ (instancetype)piblishViewWithArrowOrigin:(CGPoint)arrowOrigin {
    
    return [[self alloc] initWithArrowOrigin:arrowOrigin];
}

- (instancetype)initWithArrowOrigin:(CGPoint)arowOrigin {
    self = [super init];
    if (self) {

        self.arowOrigin = arowOrigin;
        
        [self createSubviews];

    }
    return self;

}

- (void)createSubviews {
    
    UIControl *maskView = [[UIControl alloc] init];
    [maskView addTarget:self action:@selector(maskAction:) forControlEvents:UIControlEventTouchUpInside];
    maskView.backgroundColor = [UIColor clearColor];
    [self addSubview:maskView];
    self.maskView = maskView;
    
    UIImage *image = [UIImage imageNamed:@"PublishFrame"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *publishFrame = [[UIImageView alloc] initWithImage:image];
    publishFrame.tintColor = [@"FFE44F" rgbColor];
    publishFrame.userInteractionEnabled = YES;
    [self addSubview:publishFrame];
    self.publishFrame = publishFrame;
    
    UIImageView *publishLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PublishLine"]];
    [self.publishFrame addSubview:publishLine];
    self.publishLine = publishLine;
    
    BaseButton *publishSourceButton = [BaseButton okaButton];
    [publishSourceButton setOkaTitle:@"我的代码"];
    [publishSourceButton setTitleColor:[@"333333" rgbColor] forState:UIControlStateNormal];
    [publishSourceButton addTarget:self action:@selector(publishAction:)];
    [self.publishFrame addSubview:publishSourceButton];
    self.publishSourceButton = publishSourceButton;
    
    BaseButton *publishFindingButton = [BaseButton okaButton];
    [publishFindingButton setOkaTitle:@"我的简书"];
    [publishFindingButton setTitleColor:[@"333333" rgbColor] forState:UIControlStateNormal];
    [publishFindingButton addTarget:self action:@selector(publishAction:)];
    [self.publishFrame addSubview:publishFindingButton];
    self.publishFindingButton = publishFindingButton;

}

- (void)publishAction:(BaseButton *)button {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didPressPublishName:)]) {
        
        [self.delegate didPressPublishName:[button okaTitle]];
    }
    
     [self disappear];
}

- (void)maskAction:(UIControl*)ctrl {

    [self disappear];
    
}

- (void)show {
    
     self.isShow = YES;
    
    self.publishFrame.layer.anchorPoint = CGPointMake(.5, 1);
    //初始弹出视图的很小的状态
    self.publishFrame.transform = CGAffineTransformMakeScale(0.000001, 0.000001);
    
    
    [UIView animateWithDuration:.425f delay:0 usingSpringWithDamping:.3f initialSpringVelocity:0.1 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.publishFrame.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
    
    UIWindow *win = [UIApplication sharedApplication].keyWindow;
    [win addSubview:self];
   
}

- (void)disappear {
     self.isShow = NO;
    [UIView animateWithDuration:.35 animations:^{
        self.publishFrame.transform = CGAffineTransformMakeScale(0.000001, 0.000001);
    } completion:^(BOOL finished) {
         [self removeFromSuperview];
        
    }];
   
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    
    self.publishFrame.origin = CGPointMake(self.arowOrigin.x - self.publishFrame.width/2, self.arowOrigin.y - self.publishFrame.height + 64);
    
    self.publishLine.origin = CGPointMake(7, 41);
    
    self.publishFindingButton.frame = CGRectMake(0, 0, 110, 40);
    
    self.publishSourceButton.frame = CGRectMake(0, 41, 110, 40);
    
    self.maskView.frame = self.bounds;
    
}



@end

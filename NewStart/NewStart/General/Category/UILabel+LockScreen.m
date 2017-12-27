//
//  UILabel+LockScreen.m
//  NewStart
//
//  Created by  ZhuHong on 2017/12/28.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "UILabel+LockScreen.h"

@implementation UILabel (LockScreen)

/** 设置滑动解锁动画效果 */
- (void)setLockScreen {
    // 第一步：创建渐变效果的layer
    CAGradientLayer *graLayer = [CAGradientLayer layer];
    graLayer.frame = [UIScreen mainScreen].bounds;
    graLayer.colors = @[(__bridge id)[[UIColor greenColor] colorWithAlphaComponent:0.3].CGColor,
                        (__bridge id)[UIColor yellowColor].CGColor,
                        (__bridge id)[[UIColor yellowColor] colorWithAlphaComponent:0.3].CGColor];
    
    graLayer.startPoint = CGPointMake(0, 0);//设置渐变方向起点
    graLayer.endPoint = CGPointMake(1, 0);  //设置渐变方向终点
    graLayer.locations = @[@(0.0), @(0.0), @(0.1)]; //colors中各颜色对应的初始渐变点
    
    // 第二步：通过设置颜色渐变点(locations)动画，达到预期效果
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"locations"];
    animation.duration = 3.0f;
    animation.toValue = @[@(0.9), @(1.0), @(1.0)];
    animation.removedOnCompletion = NO;
    animation.repeatCount = HUGE_VALF;
    animation.fillMode = kCAFillModeForwards;
    [graLayer addAnimation:animation forKey:@"xindong"];
    
    self.layer.mask = graLayer;
}


@end

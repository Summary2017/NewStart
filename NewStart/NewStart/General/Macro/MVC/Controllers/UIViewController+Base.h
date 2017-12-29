//
//  UIViewController+Base.h
//  NewStart
//
//  Created by  ZhuHong on 2017/12/27.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

/**
 基控制器的公共处理
 这个分类放到这里的原因是, 这个分类只可能在这个地方用到, 所以放在这里也是很不错的
 */

#import <UIKit/UIKit.h>

@interface UIViewController (Base)

/**
 非主页控制器添加返回按钮
 */
- (void)addBackButton;

/**
 当内存吃紧的时候,取消当前下载/清除内存总所有的图片
 */
- (void)cancellWebImageMemory;

/** 通过故事版名称创建InitialVC */
+ (instancetype)storyboardInitialWithName:(NSString *)sbName;

/** 通过故事版名称创建以当前class命名的Identifier VC */
+ (instancetype)storyboardWithName:(NSString *)sbName;

/**
 pop方法
 */
- (void)popLastViewControllerWithAnimation;

@end

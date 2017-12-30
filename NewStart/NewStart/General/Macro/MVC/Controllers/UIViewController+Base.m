//
//  UIViewController+Base.m
//  NewStart
//
//  Created by  ZhuHong on 2017/12/27.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "UIViewController+Base.h"
#import "SDWebImageManager.h"

@implementation UIViewController (Base)

/**
 非主页控制器添加返回按钮
 */
- (void)addBackButton {
    if (self.navigationController.viewControllers.count <= 1 && ![NSStringFromClass(self.class) isEqualToString:@"MoreController"]) {
        return;
    }
    
    self.navigationItem.leftBarButtonItem = [self itemWithTarget:self action:@selector(popLastViewControllerWithAnimation) image:@"EC_Back" highImage:@"EC_Back"];
}

/**
 定义返回按钮样式
 */
- (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)imageSTR highImage:(NSString *)highImage {
    
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageSTR]];
    
    CGRect imageFrame = imageView.frame;
    UIView* backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, imageFrame.size.width*2.0, 38.0)];
    imageFrame.origin.y = (backView.frame.size.height - imageFrame.size.height)*0.5;
    imageView.frame = imageFrame;
    
    [backView addSubview:imageView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.frame = backView.bounds;
    
    [backView addSubview:btn];
    
    return [[UIBarButtonItem alloc] initWithCustomView:backView];
}

- (void)popLastViewControllerWithAnimation {
    
    [self.navigationController popViewControllerAnimated:YES];
}

/** 通过故事版名称创建InitialVC */
+ (instancetype)storyboardInitialWithName:(NSString *)sbName {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:sbName bundle:nil];
    return [storyboard instantiateInitialViewController];
}

/** 通过故事版名称创建以当前class命名的Identifier VC */
+ (instancetype)storyboardWithName:(NSString *)sbName {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:sbName bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(self)];
}


/**
 当内存吃紧的时候,取消当前下载/清除内存总所有的图片
 */
- (void)cancellWebImageMemory {
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    // 1.取消下载
    [mgr cancelAll];
    
    // 2.清除内存中的所有图片
    [mgr.imageCache clearMemory];
}

@end

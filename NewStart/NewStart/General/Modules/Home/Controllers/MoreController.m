//
//  MoreController.m
//  NewStart
//
//  Created by  ZhuHong on 2017/12/30.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "MoreController.h"
#import "BaseButton.h"
#import "UIView+HG.h"

@interface MoreController ()

@end

@implementation MoreController

// 包装一个导航控制器
+ (UINavigationController*)navFromMoreVC {
    MoreController* moreVC = [[self alloc] init];
    moreVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    moreVC.modalPresentationStyle = UIModalPresentationPageSheet;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:moreVC];
    
    return nav;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"更多";
}

// 重写父类方法返回
- (void)popLastViewControllerWithAnimation {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end

//
//  BaseSBTBController.m
//  NewStart
//
//  Created by  ZhuHong on 2017/12/27.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "BaseSBTBController.h"
#import "UIViewController+Base.h"

@interface BaseSBTBController ()

@end

@implementation BaseSBTBController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 非主页控制器添加返回按钮
    [self addBackButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    // 分类统一处理
    [self cancellWebImageMemory];
}

@end

//
//  TabBarController.m
//  NewStart
//
//  Created by  ZhuHong on 2017/12/27.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "TabBarController.h"
#import "NavigationController.h"
#import "HomeController.h"
#import "MessageController.h"
#import "OrderController.h"
#import "MineController.h"
#import "TabBar.h"
#import "NSString+Color.h"

@interface TabBarController ()

@end

@implementation TabBarController

// 一次性设置
+ (void)initialize
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [@"999999" rgbColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [@"FFA701" rgbColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 中间的按钮
    UIButton* centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [centerBtn setImage:[UIImage imageNamed:@"TabBar_Publish"] forState:UIControlStateNormal];
    [centerBtn setImage:[UIImage imageNamed:@"TabBar_Publish"] forState:UIControlStateHighlighted];
    [centerBtn addTarget:self action:@selector(centerClick) forControlEvents:UIControlEventTouchUpInside];
    
    [centerBtn sizeToFit];
    
    // 设置所有的子视图
    [self setupAllChildVC];
    
    TabBar* tabBar = [[TabBar alloc] init];
    tabBar.centerBtn = centerBtn;
    [self setValue:tabBar forKey:@"tabBar"];
}

// 设置所有的子视图
- (void)setupAllChildVC {
    [self setupChildVC:[[HomeController alloc] init] title:@"首页" image:@"tabbar_home"];
    
    [self setupChildVC:[[MessageController alloc] init] title:@"消息" image:@"tabbar_message_center"];
    
    [self setupChildVC:[[OrderController alloc] init] title:@"订单" image:@"Order"];
    
    [self setupChildVC:[[MineController alloc] init] title:@"我的" image:@"tabbar_profile"];
}

// 初始化子控制器
- (void)setupChildVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)imageSTR
{
    // 设置文字和图片
    vc.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:imageSTR] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NSString* selectedImageSTR = [NSString stringWithFormat:@"%@_selected", imageSTR];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageSTR] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

// 中间按钮点击事件
- (void)centerClick {
    NSLog(@"centerClick");
}

@end

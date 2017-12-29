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
#import "ECPublishView.h"
#import "NewStart-Swift.h"

@interface TabBarController () <ECPublishViewDelegate>

@property (strong, nonatomic) ECPublishView *publishView;

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
    
    
    CGFloat margin = [Public isIPhoneX]?83:49;
    // 中间功能
    CGPoint arrowOrigin = CGPointMake(UI_SCREEN_WIDTH/2, UI_SCREEN_HEIGHT - 64 - 20 - margin);
    ECPublishView *publishView = [ECPublishView piblishViewWithArrowOrigin:arrowOrigin];
    publishView.delegate = self;
    self.publishView = publishView;
}

// 设置所有的子视图
- (void)setupAllChildVC {
    [self setupChildVC:[[HomeController alloc] init] title:@"首页" image:@"tabbar_home"];
    
    MessageController* msgVC = [MessageController storyboardInitialWithName:@"Message"];
    [self setupChildVC:msgVC title:@"消息" image:@"tabbar_message_center"];
    
    [self setupChildVC:[[OrderController alloc] init] title:@"订单" image:@"Order"];
    
    MineController* mineVC = [MineController storyboardInitialWithName:@"Mine"];
    [self setupChildVC:mineVC title:@"我的" image:@"tabbar_profile"];
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
    if(self.publishView.isShow) {
        [self.publishView disappear];
    } else {
        [self.publishView show];
    }
}

#pragma mark -
#pragma mark - ECPublishViewDelegate
- (void)didPressPublishName:(NSString *)controllerName {
    DLog(@"%@", controllerName);
    
    BrowserController* browerVC = [[BrowserController alloc] init];
    browerVC.title =  controllerName;
    if ([controllerName isEqualToString:@"我的代码"]) {
        browerVC.urlSTR = @"https://github.com/Summary2017";
    } else {
        browerVC.urlSTR = @"https://www.jianshu.com/p/c0e611fc0548";
    }
    
    UINavigationController* navVC = (UINavigationController*)self.selectedViewController;
    
    [navVC pushViewController:browerVC animated:YES];
}


@end

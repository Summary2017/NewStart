//
//  AppDelegate.m
//  NewStart
//
//  Created by  ZhuHong on 2017/12/27.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarController.h"
#import "HGLoginController.h"
#import "SDWebImageManager.h"
#import "LoadingView.h"
#import "IQKeyboardManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma MARK -
#pragma MARK - 懒加载
- (LoadingView *)loadingView {
    if (!_loadingView) {
        _loadingView = [LoadingView xibView];
        _loadingView.frame = [UIScreen mainScreen].bounds;
    }
    return _loadingView;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 键盘的控制
    [self keyboardManager];
    
    // 创建 window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 根控制器
//    self.window.rootViewController = [[TabBarController alloc] init];
    {
        HGLoginController* loginVC = [[HGLoginController alloc] init];
        UINavigationController* loginNavVC = [[UINavigationController alloc] initWithRootViewController:loginVC];
        self.window.rootViewController = loginNavVC;
    }
    
    
    // 设置主窗口并可见
    [self.window makeKeyAndVisible];
    
    return YES;
}

/** 键盘的控制 */
- (void)keyboardManager {
    IQKeyboardManager* keyboardManager = [IQKeyboardManager sharedManager];
    // 隐藏toolbar
    keyboardManager.enableAutoToolbar = NO;
    keyboardManager.shouldResignOnTouchOutside = YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    // 1.取消下载
    [mgr cancelAll];
    
    // 2.清除内存中的所有图片
    [mgr.imageCache clearMemory];
}


@end

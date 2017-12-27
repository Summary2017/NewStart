//
//  AppDelegate.h
//  NewStart
//
//  Created by  ZhuHong on 2017/12/27.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoadingView;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

// 加载框
@property (nonatomic, strong) LoadingView* loadingView;


@end


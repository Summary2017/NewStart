//
//  Public.m
//  NewStart
//
//  Created by  ZhuHong on 2017/12/27.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "Public.h"
#import "AppDelegate.h"
#import "LoadingView.h"
#import <sys/utsname.h>

@implementation Public

/** 显示加载框 */
+ (void)showLoadingView {
    [HGSharedAppDelegate.loadingView loadingShow];
}

/** 隐藏加载框 */
+ (void)hideLoadingView {
    [HGSharedAppDelegate.loadingView loadingHidden];
}

static int kisIPhoneXFlag = -1;
static BOOL kisIPhoneX = NO;
// 是否为iPhone X 设备
+ (BOOL)isIPhoneX {
    if (kisIPhoneXFlag == -1) {
        kisIPhoneXFlag = 1;
        kisIPhoneX = (UI_SCREEN_HEIGHT == 812);
    }
    return kisIPhoneX;
}

@end

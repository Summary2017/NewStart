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

@implementation Public

/** 显示加载框 */
+ (void)showLoadingView {
    [HGSharedAppDelegate.loadingView loadingShow];
}

/** 隐藏加载框 */
+ (void)hideLoadingView {
    [HGSharedAppDelegate.loadingView loadingHidden];
}

@end

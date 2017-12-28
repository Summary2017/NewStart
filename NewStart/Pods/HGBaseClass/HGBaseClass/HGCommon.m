//
//  HGCommon.m
//  CommonManager
//
//  Created by  ZhuHong on 2017/9/4.
//  Copyright © 2017年 EasyMoveMobile. All rights reserved.
//


#import "HGCommon.h"

@implementation HGCommon

/**
 * APP 名称
 */
+ (NSString*)appName {
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    return appName;
}

/**
 * 版本号
 */
+ (NSString*)appVersion {
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return appVersion;
}

/**
 * Build号
 */
+ (NSString*)appBuild {
    NSString *appBuild = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    return appBuild;
}

/** 收回键盘 */
+ (void)hideKeyboard
{
    Class UIApplicationClass = NSClassFromString(@"UIApplication");
    if(!UIApplicationClass || ![UIApplicationClass respondsToSelector:@selector(sharedApplication)]) {
        return;
    }
    
    UIWindow *keyWindow = [[UIApplicationClass performSelector:@selector(sharedApplication)] valueForKey:@"keyWindow"];
    [keyWindow endEditing:YES];
}


/**
 检测代码块的运行时间 单位是秒
 
 @param coderBlock 检测的代码块
 @return 返回所运行的时间
 */
+ (CFTimeInterval)coderIntervalWithBlock:(void (^)(void))coderBlock {
    // 代码块没有值,返回0
    if (!coderBlock) {
        return 0;
    }
    
    // 开始时间
    CFTimeInterval starTimeInterval = CFAbsoluteTimeGetCurrent();
    
    // 执行代码
    coderBlock();
    
    // 结束时间
    CFTimeInterval endTimeInterval = CFAbsoluteTimeGetCurrent();
    
    return endTimeInterval - starTimeInterval;
}

@end

@implementation HGCommon (Device)

static NSInteger isIPad = -1;
+ (BOOL)isIPad {
    if (isIPad < 0) {
        // [[[UIDevice currentDevice] model] isEqualToString:@"iPad"] 无法判断模拟器，改为以下方式
        isIPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 1 : 0;
    }
    return isIPad > 0;
}

static NSInteger isIPadPro = -1;
+ (BOOL)isIPadPro {
    if (isIPadPro < 0) {
        isIPadPro = [self isIPad] ? (DEVICE_WIDTH == 1024 && DEVICE_HEIGHT == 1366 ? 1 : 0) : 0;
    }
    return isIPadPro > 0;
}

static NSInteger isIPod = -1;
+ (BOOL)isIPod {
    if (isIPod < 0) {
        NSString *string = [[UIDevice currentDevice] model];
        isIPod = [string rangeOfString:@"iPod touch"].location != NSNotFound ? 1 : 0;
    }
    return isIPod > 0;
}

static NSInteger isIPhone = -1;
+ (BOOL)isIPhone {
    if (isIPhone < 0) {
        NSString *string = [[UIDevice currentDevice] model];
        isIPhone = [string rangeOfString:@"iPhone"].location != NSNotFound ? 1 : 0;
    }
    return isIPhone > 0;
}

static NSInteger isSimulator = -1;
+ (BOOL)isSimulator {
    if (isSimulator < 0) {
#if TARGET_OS_SIMULATOR
        isSimulator = 1;
#else
        isSimulator = 0;
#endif
    }
    return isSimulator > 0;
}

static CGFloat kScale = -1;
+ (CGFloat)hg_scale {
    if (kScale < 0) {
        kScale = [UIScreen mainScreen].scale;
    }
    return kScale;
}

static CGFloat kLayoutScale = -1;
+ (CGFloat)hg_layoutScale {
    if (kLayoutScale < 0) {
        kLayoutScale = [self hg_scale]*0.5;
    }
    return kLayoutScale;
}

@end

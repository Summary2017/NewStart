//
//  HGCommon.h
//  CommonManager
//
//  Created by  ZhuHong on 2017/9/4.
//  Copyright © 2017年 EasyMoveMobile. All rights reserved.
//


/**
 * 通用宏定义
 */

#ifndef HGCommon_h
#define HGCommon_h

// 颜色
#define RGBA(R, G, B, A) [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:(A)]
#define RGB(R, G, B) RGBA(R, G, B, 1.0)

// 随机色
#define RandomColor RGB(arc4random()%255, arc4random()%255, arc4random()%255)

// 回归主线程
#define HG_dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}


// 打印日志
#ifdef DEBUG
#   define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#   define ELog(err) {if(err) DLog(@"%@", err)}
#else
#   define DLog(...)
#   define ELog(err)
#endif

//设备判断
#define IS_IPAD [HGCommon isIPad]
#define IS_IPAD_PRO [HGCommon isIPadPro]
#define IS_IPOD [HGCommon isIPod]
#define IS_IPHONE [HGCommon isIPhone]
#define IS_SIMULATOR [HGCommon isSimulator]

#define HG_Scale [HGCommon hg_scale]
#define HG_LayoutScale [HGCommon hg_layoutScale]


//打印字符串
#define HGStr(...) [NSString stringWithFormat:__VA_ARGS__]

// 屏幕尺寸
#define UI_SCREEN_WIDTH      ([[UIScreen mainScreen] bounds].size.width)
#define UI_SCREEN_HEIGHT     ([[UIScreen mainScreen] bounds].size.height)
#define UI_STATUS_BAR_WIDTH  ([[UIApplication sharedApplication] statusBarFrame].size.width)
#define UI_STATUS_BAR_HEIGHT ([[UIApplication sharedApplication] statusBarFrame].size.height)

// 操作系统版本号
#define IOS_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])

// 是否横竖屏
// 用户界面横屏了才会返回YES
//#define IS_LANDSCAPE UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])
#define IS_LANDSCAPE NO
// 无论支不支持横屏，只要设备横屏了，就会返回YES
#define IS_DEVICE_LANDSCAPE UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])

// 屏幕宽度，跟横竖屏无关
#define DEVICE_WIDTH (IS_LANDSCAPE ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)
// 屏幕高度，跟横竖屏无关
#define DEVICE_HEIGHT (IS_LANDSCAPE ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)

// 沙盒路径
#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

// CGRect
#define CGM(X, Y, W, H) CGRectMake((X), (Y), (W), (H))
#define CGMinX(_obj) CGRectGetMinX(_obj.frame)
#define CGMaxX(_obj) CGRectGetMaxX(_obj.frame)
#define CGMinY(_obj) CGRectGetMinY(_obj.frame)
#define CGMaxY(_obj) CGRectGetMaxY(_obj.frame)
#define CGWidth(_obj) CGRectGetWidth(_obj.frame)
#define CGHeight(_obj) CGRectGetHeight(_obj.frame)


/** System font of size */
#define Font(size)  [UIFont systemFontOfSize: (size)]
#define BFont(size) [UIFont boldSystemFontOfSize: (size)]

// 强弱指针转换
#ifndef    weakify_self
#define weakify_self __weak typeof(self) weakSelf = self
#endif
#ifndef    strongify_self
#define strongify_self __typeof__(weakSelf) self = weakSelf
#endif

// 去除空格
#define allTrim( object ) [object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]

/** 通知宏 */
#define HGNotificationCenter [NSNotificationCenter defaultCenter]
#define HGUserDefaults [NSUserDefaults standardUserDefaults]

// 系统版本
#define SYSTEM_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])


// 过期标注
#define HG_DEPRECATED(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

// 无效标注
// init 方法
#define HG_UNAVAILABLE_INIT(instead) __attribute__((unavailable(instead))) NS_DESIGNATED_INITIALIZER
// 普通方法
#define HG_UNAVAILABLE(instead)      __attribute__((unavailable(instead)))


// .h 文件中用到的宏
#define Single_interface(class)  + (instancetype)sharedSingleton;

// .m 文件中用到的宏
#define Single_implementation(class) \
static class *_instance; \
\
+ (instancetype)sharedSingleton \
{ \
if (_instance == nil) { \
_instance = [[self alloc] init]; \
} \
return _instance; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
}


#endif /* HGCommon_h */


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 空值判断
static inline BOOL IsEmptyValue(id _Nullable thing) {
    return (thing == nil)
    || ([thing respondsToSelector:@selector(length)]
        && [(NSData *) thing length] == 0)
    || ([thing respondsToSelector:@selector(count)]
        && [(NSArray *) thing count] == 0)
    || ([thing isKindOfClass:[NSNull class]]);
}

// 为空, 返回nil 针对NSString
static inline NSString *_Nullable checkValueNil(NSString *_Nullable value) {
    if (IsEmptyValue(value)) {
        return nil;
    }
    return value;
}

// 为空, 返回@"" 针对NSString
static inline NSString *_Nullable CheckValue(NSString *_Nullable value) {
    if (IsEmptyValue(value)) {
        return @"";
    }
    return value;
}


@interface HGCommon : NSObject

/**
 * APP名称
 */
+ (NSString*)appName;

/**
 * 版本号
 */
+ (NSString*)appVersion;

/**
 * Build号
 */
+ (NSString*)appBuild;

/**
 * 隐藏键盘
 */
+ (void)hideKeyboard;


/**
 检测代码块的运行时间 单位是秒
 
 @param coderBlock 检测的代码块
 @return 返回所运行的时间
 */
+ (CFTimeInterval)coderIntervalWithBlock:(void (^)(void))coderBlock;


@end


@interface HGCommon (Device)

+ (BOOL)isIPad;
+ (BOOL)isIPadPro;
+ (BOOL)isIPod;
+ (BOOL)isIPhone;
+ (BOOL)isSimulator;

+ (CGFloat)hg_scale;
+ (CGFloat)hg_layoutScale;

@end

NS_ASSUME_NONNULL_END

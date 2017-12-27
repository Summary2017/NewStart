//
//  Public.h
//  NewStart
//
//  Created by  ZhuHong on 2017/12/27.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "HGCommon.h"

#define HGSharedAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface Public : HGCommon

/** 显示加载框 */
+ (void)showLoadingView;

/** 隐藏加载框 */
+ (void)hideLoadingView;

@end

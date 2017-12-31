//
//  Public.h
//  NewStart
//
//  Created by  ZhuHong on 2017/12/27.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "HGCommon.h"

@interface Public : HGCommon

/** 显示加载框 */
+ (void)showLoadingView;

/** 隐藏加载框 */
+ (void)hideLoadingView;

/** 是否为iPhone X设备 */
+ (BOOL)isIPhoneX;

@end

//
//  GlobalConsts.h
//  NewStart
//
//  Created by  ZhuHong on 2017/12/27.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HGSharedAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

UIKIT_EXTERN NSString* const HGTabToContentNotification;
UIKIT_EXTERN NSString* const HGContentToTabNotification;
UIKIT_EXTERN NSString* const HGContentTabKey;


@interface GlobalConsts : NSObject

@end

//
//  NSString+Color.m
//  NewStart
//
//  Created by  ZhuHong on 2017/12/27.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "NSString+Color.h"

@implementation NSString (Color)

/**
 NSString 转 UIColor
 */
- (UIColor*)rgbColor {
    if (self.length == 6) {
        NSInteger red = strtol([self substringWithRange:NSMakeRange(0, 2)].UTF8String, NULL, 16);
        NSInteger green = strtol([self substringWithRange:NSMakeRange(2, 2)].UTF8String, NULL, 16);
        NSInteger blue = strtol([self substringWithRange:NSMakeRange(4, 2)].UTF8String, NULL, 16);
        
        return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1.0f];
    }
    
    return [UIColor clearColor];
}
@end

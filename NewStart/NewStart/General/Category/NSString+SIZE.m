//
//  NSString+SIZE.m
//  NewStart
//
//  Created by  ZhuHong on 2017/12/30.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "NSString+SIZE.h"

@implementation NSString (SIZE)

/** 通过固定宽度与字体计算文字的所占高度 */
- (CGFloat)heightWithWidth:(CGFloat)width
                      font:(UIFont *)font {
    
    NSDictionary* atrDict = @{
                              NSFontAttributeName:font
                              };
    CGSize size =  [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:atrDict context:nil].size;
    
    return size.height;
}

@end

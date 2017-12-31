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
    CGSize size =  [self hgStringWithFont:font width:width height:CGFLOAT_MAX];
    return size.height;
}

/** 计算文字的size
 font  : 文本的字体的大小
 width : 允许最长的宽
 height: 允许最长的高
 */
- (CGSize)hgStringWithFont:(UIFont*)font width:(CGFloat)width height:(CGFloat)height {
    NSDictionary* dict = @{NSFontAttributeName:font};
    CGSize size =  [self boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:dict context:nil].size;
    
    return size;
}

@end

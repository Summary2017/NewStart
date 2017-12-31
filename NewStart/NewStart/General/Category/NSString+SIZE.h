//
//  NSString+SIZE.h
//  NewStart
//
//  Created by  ZhuHong on 2017/12/30.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SIZE)

/**
 通过固定宽度与字体计算文字的所占高度

 @param width 固定宽度
 @param font 字体
 @return 实际高度
 */
- (CGFloat)heightWithWidth:(CGFloat)width
                      font:(UIFont *)font;

/** 计算文字的size
 font  : 文本的字体的大小
 width : 允许最长的宽
 height: 允许最长的高
 */
- (CGSize)hgStringWithFont:(UIFont*)font width:(CGFloat)width height:(CGFloat)height;

@end

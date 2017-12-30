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

@end

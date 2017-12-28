//
//  NSString+HG.h
//  NewStart
//
//  Created by  ZhuHong on 2017/12/28.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HG)

/**
 用户名 匹配
 规则 : 数字 小数点 下划线_ @ 英文 汉字
 
 @return 是否满足规则
 */
- (BOOL)userNameRegex;

/**
 用户密码 匹配
 规则 : 数字 英文 _ . @  并且8到12位之间  不能是纯数字与纯字符
 */
- (BOOL)passwpordRegex;

/**
 用户密码 输入过程中的匹配
 */
- (BOOL)passwpordInputRegex;

@end

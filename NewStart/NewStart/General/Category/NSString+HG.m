//
//  NSString+HG.m
//  NewStart
//
//  Created by  ZhuHong on 2017/12/28.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "NSString+HG.h"
#import "NSString+Regex.h"

@implementation NSString (HG)

/**
 用户名 匹配
 */
- (BOOL)userNameRegex {
    return [self hg_regexMatchWithType:HGRegexTypeDigital|HGRegexTypeCharacter|HGRegexTypeUnderline|HGRegexTypeDot|HGRegexTypeAT|HGRegexTypeChinese];
}


/**
 用户密码 匹配
 */
- (BOOL)passwpordRegex {
    if ((self.length < 8) || (self.length > 12)) {
        return NO;
    }
    
    if ([self hg_regexMatchWithType:HGRegexTypeDigital]) {
        return NO;
    }
    
    if ([self hg_regexMatchWithType:HGRegexTypeCharacter]) {
        return NO;
    }
    
    return [self hg_regexMatchWithType:HGRegexTypeAT|HGRegexTypeDot|HGRegexTypeCharacter|HGRegexTypeDigital|HGRegexTypeUnderline];
}

/**
 用户密码 输入过程中的匹配
 */
- (BOOL)passwpordInputRegex {
    if (self.length > 12) {
        return NO;
    }
    
    if (self.length == 12) {
        // 等于最大值的时候, 不能让其成为纯数字或者纯字符
        if ([self hg_regexMatchWithType:HGRegexTypeDigital]) {
            return NO;
        }
        
        if ([self hg_regexMatchWithType:HGRegexTypeCharacter]) {
            return NO;
        }
    }
    
    return [self hg_regexMatchWithType:HGRegexTypeCharacter|HGRegexTypeDigital];
}

@end

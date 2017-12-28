//
//  NSString+UserDefaults.m
//  OKANWEManager
//
//  Created by  ZhuHong on 2017/9/4.
//  Copyright © 2017年 EasyMoveMobile. All rights reserved.
//

#import "NSString+UserDefaults.h"
#import "NSString+Secure.h"

@implementation NSString (UserDefaults)


#pragma mark - 默认
- (BOOL)userDefaultsforKey:(NSString*)key {
    
    return [self userDefaultsforKey:key suiteName:nil];
}

- (NSString*)objectWithUserDefaults {
    
    return [self objectThroughUserDefaultsWithSuiteName:nil];
}


- (BOOL)removeObject {
    return [self removeObjectWithSuiteName:nil];
}

#pragma mark - 通过 suiteName
/**
 * 存储
 */
- (BOOL)userDefaultsforKey:(NSString*)key suiteName:(NSString*)suiteName {
    if (!key) {
        return NO;
    }
    
    // 加密后的 value 与 key .
    // key SHA1 加密
    NSString* secureKey = [key sha1_EHN];
    if (!secureKey) {
        return NO;
    }
    
    // 3DES 加密
    NSString* secureVaule = [self desEncryptWithKey_EHN:key];
    if (!secureVaule) {
        return nil;
    }
    
    NSUserDefaults* userDefaults = nil;
    if ([suiteName isKindOfClass:[NSString class]] && (suiteName.length > 0)) {
        userDefaults = [[NSUserDefaults alloc] initWithSuiteName:suiteName];
    } else {
        userDefaults = [NSUserDefaults standardUserDefaults];
    }
    [userDefaults setObject:secureVaule forKey:secureKey];
    
    return [userDefaults synchronize];
}
/**
 * 获取
 */
- (NSString*)objectThroughUserDefaultsWithSuiteName:(NSString*)suiteName {
    // 加密后的 key .
    // key SHA1 加密
    NSString* secureKey = [self sha1_EHN];
    if (!secureKey) {
        return nil;
    }
    
    
    NSUserDefaults* userDefaults = nil;
    if ([suiteName isKindOfClass:[NSString class]] && (suiteName.length > 0)) {
        userDefaults = [[NSUserDefaults alloc] initWithSuiteName:suiteName];
    } else {
        userDefaults = [NSUserDefaults standardUserDefaults];
    }
    
    // 获取 NSUserDefaults 中被加密后的值
    NSString* secureValue = [userDefaults objectForKey:secureKey];
    if (!secureKey) {
        return nil;
    }
    
    // 3DES 解密
    NSString* value = [secureValue desDecryptWithKey_EHN:self];
    
    return value;
}

- (BOOL)removeObjectWithSuiteName:(NSString *)suiteName {
    // 加密后的 key .
    // key SHA1 加密
    NSString* secureKey = [self sha1_EHN];
    if (!secureKey) {
        return NO;
    }
    
    NSUserDefaults* userDefaults = nil;
    if ([suiteName isKindOfClass:[NSString class]] && (suiteName.length > 0)) {
        userDefaults = [[NSUserDefaults alloc] initWithSuiteName:suiteName];
    } else {
        userDefaults = [NSUserDefaults standardUserDefaults];
    }
    
    [userDefaults removeObjectForKey:secureKey];
    
    
    return YES;
}

@end

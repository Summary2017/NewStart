//
//  NSString+UserDefaults.h
//  OKANWEManager
//
//  Created by  ZhuHong on 2017/9/4.
//  Copyright © 2017年 EasyMoveMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (UserDefaults)

#pragma mark - 默认
/**
 * 存储
 */
- (BOOL)userDefaultsforKey:(NSString*)key;

/**
 * 获取
 */
- (NSString*)objectWithUserDefaults;


/**
 删除
 */
- (BOOL)removeObject;

#pragma mark - 通过 suiteName
/**
 * 存储
 */
- (BOOL)userDefaultsforKey:(NSString*)key suiteName:(NSString*)suiteName;
/**
 * 获取
 */
- (NSString*)objectThroughUserDefaultsWithSuiteName:(NSString*)suiteName;


/**
 删除
 
 @param suiteName suiteName
 */
- (BOOL)removeObjectWithSuiteName:(NSString*)suiteName;

@end

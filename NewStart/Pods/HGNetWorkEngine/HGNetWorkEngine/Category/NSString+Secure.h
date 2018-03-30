//
//  NSString+Secure.h
//  HGNWEManager
//
//  Created by  ZhuHong on 2017/9/4.
//  Copyright © 2017年 EasyMoveMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Secure)


/**
 *  散列函数--sha1对字符串加密
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha1
 *  @endcode
 *
 *  @return 40个字符的SHA1散列字符串
 */
- (NSString*)sha1_EHN;

/** hmacsha1 加密 */
- (NSString *)hmacsha1WithKey_EHN:(NSString *)secret;

/** base64编码 */
- (NSString*)base64Encoded_EHN;

/**
 * 3DES 加密
 * 对key做了sha1加密处理.
 */
- (NSString*)desEncryptWithKey_EHN:(NSString*)key;

/**
 * 3DES 解密
 * 对key做了sha1加密处理.
 */
- (NSString*)desDecryptWithKey_EHN:(NSString*)key;

@end

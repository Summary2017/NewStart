//
//  NSString+Secure.m
//  OKANWEManager
//
//  Created by  ZhuHong on 2017/9/4.
//  Copyright © 2017年 EasyMoveMobile. All rights reserved.
//

#import "NSString+Secure.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (Secure)


- (NSString*)sha1_EHN
{
    return self.sha1String_EHN;
}

- (NSString *)sha1String_EHN
{
    const char *str = self.UTF8String;
    uint8_t buffer[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(str, (CC_LONG)strlen(str), buffer);
    
    return [self stringFromBytes_EHN:buffer length:CC_SHA1_DIGEST_LENGTH];
}

#pragma mark -
/**
 *  返回二进制 Bytes 流的字符串表示形式
 *
 *  @param bytes  二进制 Bytes 数组
 *  @param length 数组长度
 *
 *  @return 字符串表示形式
 */
- (NSString *)stringFromBytes_EHN:(uint8_t *)bytes length:(int)length
{
    NSMutableString *strM = [NSMutableString string];
    
    for (int i = 0; i < length; i++) {
        [strM appendFormat:@"%02x", bytes[i]];
    }
    
    return [strM copy];
}

#pragma mark - 文件加密
- (NSString *)hmacsha1WithKey_EHN:(NSString *)secret {
    const char *cKey = [secret cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [self cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    // Base64
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    NSString *hash = [HMAC base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    return hash;
}




- (NSString*)base64Encoded_EHN {
    // Create NSData object
    NSData *nsdata = [self
                      dataUsingEncoding:NSUTF8StringEncoding];
    
    // Get NSString from NSData object in Base64
    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
    
    // Print the Base64 encoded string
    
#ifdef DEBUG
    NSLog(@"Encoded: %@", base64Encoded);
#endif
    return base64Encoded;
}

#pragma mark -
#pragma mark - 3DES（又叫Triple DES）是三重数据加密算法（TDEA，Triple Data Encryption Algorithm）块密码的通称。

#define gIv  @"76543210"
#define kSecrectKeyLength 24

/**
 * 3DES 加密
 * 对key做了sha1加密处理.
 */
- (NSString*)desEncryptWithKey_EHN:(NSString*)key {
    if (!key) {
        return nil;
    }
    
    // 先对key做sha1处理
    const char *cstr = [key cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *keyData = [NSData dataWithBytes:cstr length:key.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(keyData.bytes, (int)keyData.length, digest);
    
    uint8_t keyByte[kSecrectKeyLength];
    for (int i = 0; i < 16; i++) {
        keyByte[i] = digest[i];
    }
    for (int i = 0; i < 8; i++) {
        keyByte[16+i] = digest[i];
    }
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    size_t plainTextBufferSize = data.length;
    const void *vplainText = (const void *)data.bytes;
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc(bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *)keyByte;
    
#ifdef DEBUG
    NSLog(@"kkk %s", vkey);
#endif
    const void *vinitVec = (const void *)(gIv).UTF8String;
    
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr
                                    length:(NSUInteger)movedBytes];
    NSString *result = [myData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    return result;
}

/**
 * 3DES 解密
 * 对key做了sha1加密处理.
 */
- (NSString*)desDecryptWithKey_EHN:(NSString*)key {
    
    if (!key) {
        return nil;
    }
    
    // 先对key做sha1处理
    const char *cstr = [key cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:key.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (int)data.length, digest);
    
    uint8_t keyByte[kSecrectKeyLength];
    for (int i = 0; i < 16; i++) {
        keyByte[i] = digest[i];
    }
    for (int i = 0; i < 8; i++) {
        keyByte[16+i] = digest[i];
    }
    
    NSData *encryptData = [[NSData alloc] initWithBase64EncodedString:self
                                                              options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    size_t plainTextBufferSize = encryptData.length;
    const void *vplainText = encryptData.bytes;
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc(bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *)keyByte;
    //    DLog(@"kkk %s",vkey);
    const void *vinitVec = (const void *)(gIv).UTF8String;
    
    ccStatus = CCCrypt(kCCDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSString *result = [[NSString alloc]
                        initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                    length:(NSUInteger)movedBytes]
                        encoding:NSUTF8StringEncoding];
    free(bufferPtr);
    return result;
}


@end

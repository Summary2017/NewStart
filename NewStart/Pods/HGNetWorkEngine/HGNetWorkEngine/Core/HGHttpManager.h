//
//  HGHttpManager.h
//  NWEManager
//
//  Created by  ZhuHong on 2017/9/4.
//  Copyright © 2017年 EasyMoveMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString* const HGAICPKey;

@interface HGHttpManager : NSObject


/**
 单例
 
 @return 返回一个静态对象
 */
+ (instancetype)shareHttpTool;


/**
 设置成Body请求方式, 主要用于 POST  GET   
 */
+ (void)setupBodyRequest;


/**
 默认设置 ACCESS_TOKEN 一般用于重本地获取
 
 @return 返回 获取状态
 */
+ (BOOL)setupACCESSTOKEN;

/**
 更新 ACCESSTOKEN 的值
 
 @param token 新的 ACCESS_TOKEN
 */
+ (void)updateACCESSTOKENWithToken:(NSString*)token;

/**
 发送POST请求
 
 @param url 请求路径
 @param params 请求参数
 @param progress 请求进度
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 @return 当前请求任务对象
 */
- (NSURLSessionDataTask*)POST:(NSString *)url
                       params:(NSDictionary *)params
                     progress:(void(^)(NSProgress *  uploadProgress))progress
                      success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

/**
 发送GET请求
 
 @param url 请求路径
 @param params 请求参数
 @param progress 请求进度
 @param success 请求成功后的回调
 @param failure 请求失败后的回调
 @return 当前请求任务对象
 */
- (NSURLSessionDataTask*)GET:(NSString *)url
                      params:(NSDictionary *)params
                    progress:(void(^)(NSProgress *  uploadProgress))progress
                     success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                     failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

/**
 *  发送DELETE请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
- (NSURLSessionDataTask*)DELETE:(NSString *)url
                         params:(NSDictionary *)params
                        success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                        failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

/**
 *  发送DELETE请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
- (NSURLSessionDataTask*)PUT:(NSString *)url
                      params:(NSDictionary *)params
                     success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                     failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure;

/**
 发送 POST 请求(上传文件)
 
 @param url 请求路径
 @param params 请求参数
 @param extension 文件格式
 @param ImageDatas 文件数据
 @param success 请求成功的回调
 @param failure 请求失败的回调
 @return 当前请求任务对象
 */
- (NSURLSessionDataTask*)filePOST:(NSString *)url
                           params:(NSDictionary *)params
                        extension:(NSString *)extension
                             data:(NSArray *)ImageDatas
                          success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure ;

/**
 发送 POST 请求(上传文件)
 
 @param url 请求路径
 @param params 请求参数
 @param extension 文件格式
 @param ImageDatas 文件数据
 @param progress 请求进度
 @param success 请求成功的回调
 @param failure 请求失败的回调
 @return 当前请求任务对象
 */
- (NSURLSessionDataTask*)filePOST:(NSString *)url
                           params:(NSDictionary *)params
                        extension:(NSString *)extension
                             data:(NSArray *)ImageDatas
                         progress:(void(^)(NSProgress *  uploadProgress))progress
                          success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure ;



/** 取消当前正在发送中的请求 */
+ (void)cancelAllRequest;

@end

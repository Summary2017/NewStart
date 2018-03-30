//
//  HGNetWorkEngine.h
//  NWEManager
//
//  Created by  ZhuHong on 2017/9/4.
//  Copyright © 2017年 EasyMoveMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HGNetWorkEngine : NSObject


/**
 *  POST data from newtork
 *
 *  @param path string
 *  @param param   NSDictionary
 *  @param success success
 *  @param failure error ever occur
 */
+ (NSURLSessionDataTask*)POSTWithPath:(NSString *)path
                                param:(NSDictionary*)param
                              success:(void (^)(id dataObject))success
                              failure:(void (^)(NSError *error))failure;

/**
 *  POST data from newtork
 *
 *  @param path string
 *  @param param   NSDictionary
 *  @param progress 进度
 *  @param success success
 *  @param failure error ever occur
 */
+ (NSURLSessionDataTask*)POSTWithPath:(NSString *)path
                                param:(NSDictionary*)param
                             progress:(void(^)(NSProgress *  uploadProgress))progress
                              success:(void (^)(id dataObject))success
                              failure:(void (^)(NSError *error))failure;

/**
 *  GET data from newtork
 *
 *  @param path string
 *  @param param   NSDictionary
 *  @param success success
 *  @param failure error ever occur
 */
+ (NSURLSessionDataTask*)GETWithPath:(NSString *)path
                               param:(NSDictionary*)param
                             success:(void (^)(id dataObject))success
                             failure:(void (^)(NSError *error))failure;

/**
 *  GET data from newtork
 *
 *  @param path string
 *  @param param   NSDictionary
 *  @param progress 进度
 *  @param success success
 *  @param failure error ever occur
 */
+ (NSURLSessionDataTask*)GETWithPath:(NSString *)path
                               param:(NSDictionary*)param
                            progress:(void(^)(NSProgress *  uploadProgress))progress
                             success:(void (^)(id dataObject))success
                             failure:(void (^)(NSError *error))failure;

/**
 *  发送DELETE请求
 *
 *  @param path string
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (NSURLSessionDataTask*)DELETEWithPath:(NSString *)path
                                 params:(NSDictionary *)params
                                success:(void (^)(id dataObject))success
                                failure:(void (^)(NSError *error))failure;
/**
 *  发送DELETE请求
 *
 *  @param path string
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (NSURLSessionDataTask*)PUTWithPath:(NSString *)path
                              params:(NSDictionary *)params
                             success:(void (^)(id dataObject))success
                             failure:(void (^)(NSError *error))failure;

/**
 *  文件 POST data from newtork
 *
 *  @param path string
 *  @param param   NSDictionary
 *  @param success success
 *  @param failure error ever occur
 */
+ (NSURLSessionDataTask*)POSTWithFile:(NSString *)path
                                param:(NSDictionary*)param
                            extension:(NSString *)extension
                                 data:(NSArray *)data
                              success:(void (^)(id))success
                              failure:(void (^)(NSError *))failure;


/**
 *  文件 POST data from newtork
 *
 *  @param path string
 *  @param param   NSDictionary
 *  @param progress 进度
 *  @param success success
 *  @param failure error ever occur
 */
+ (NSURLSessionDataTask*)POSTWithFile:(NSString *)path
                                param:(id)param
                            extension:(NSString *)extension
                                 data:(NSArray *)data
                             progress:(void(^)(NSProgress *  uploadProgress))progress
                              success:(void (^)(id))success
                              failure:(void (^)(NSError *))failure;


#pragma mark -
#pragma mark - 需要在子类中实现的方法
/**
 * 基本参数
 */
+ (NSMutableDictionary*)baseParams NS_REQUIRES_SUPER;

/** 返回渠道密码 */
+ (NSString*)AICP;


@end

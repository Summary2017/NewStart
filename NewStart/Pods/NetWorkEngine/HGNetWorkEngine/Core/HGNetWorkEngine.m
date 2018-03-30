//
//  HGNetWorkEngine.m
//  NWEManager
//
//  Created by  ZhuHong on 2017/9/4.
//  Copyright © 2017年 EasyMoveMobile. All rights reserved.
//

#import "HGNetWorkEngine.h"
#import "HttpManager.h"
#import "NSString+Secure.h"

@implementation HGNetWorkEngine

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
                              failure:(void (^)(NSError *error))failure {
    
    return [self POSTWithPath:path param:param progress:NULL success:success failure:failure];
}

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
                              failure:(void (^)(NSError *error))failure {
    
    NSMutableDictionary* nParemeters = [NSMutableDictionary dictionaryWithDictionary:[self baseParams]];
    if (param.count > 0) {
        [nParemeters setValuesForKeysWithDictionary:param];
    }
    
    [nParemeters setValue:[self AICP] forKey:OKAAICPKey];
    
    // 全路径
    NSString* fullURL = [NSString stringWithFormat:@"%@/%@", [self kNetWorkServiceAddress], path];
    
    NSURLSessionDataTask *dataTask = [[HttpManager shareHttpTool] POST:fullURL params:nParemeters progress:progress success:^(NSURLSessionDataTask *operation, id responseObject) {
        // 统一格式返回
        [self netWorkServiceWithOperation:operation responseObject:responseObject success:success failure:failure];
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    return dataTask;
}


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
                             failure:(void (^)(NSError *error))failure {
    
    return [self GETWithPath:path param:param progress:NULL success:success failure:failure];
}

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
                             failure:(void (^)(NSError *error))failure {
    
    NSMutableDictionary* nParemeters = [NSMutableDictionary dictionaryWithDictionary:[self baseParams]];
    if (param.count > 0) {
        [nParemeters setValuesForKeysWithDictionary:param];
    }
    
    [nParemeters setValue:[self AICP] forKey:OKAAICPKey];
    
    // 全路径
    NSString* fullURL = [NSString stringWithFormat:@"%@/%@", [self kNetWorkServiceAddress], path];
    
    NSURLSessionDataTask *dataTask = [[HttpManager shareHttpTool] GET:fullURL params:nParemeters progress:progress success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        // 统一格式返回
        [self netWorkServiceWithOperation:operation responseObject:responseObject success:success failure:failure];
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    return dataTask;
}

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
                                failure:(void (^)(NSError *error))failure {
    
    NSMutableDictionary* nParemeters = [NSMutableDictionary dictionaryWithDictionary:[self baseParams]];
    if (params.count > 0) {
        [nParemeters setValuesForKeysWithDictionary:params];
    }
    
    [nParemeters setValue:[self AICP] forKey:OKAAICPKey];
    
    // 全路径
    NSString* fullURL = [NSString stringWithFormat:@"%@/%@", [self kNetWorkServiceAddress], path];
    
    NSURLSessionDataTask *dataTask = [[HttpManager shareHttpTool] DELETE:fullURL params:nParemeters success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        // 统一格式返回
        [self netWorkServiceWithOperation:operation responseObject:responseObject success:success failure:failure];
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    return dataTask;
    
}
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
                             failure:(void (^)(NSError *error))failure {
    
    NSMutableDictionary* nParemeters = [NSMutableDictionary dictionaryWithDictionary:[self baseParams]];
    if (params.count > 0) {
        [nParemeters setValuesForKeysWithDictionary:params];
    }
    
    [nParemeters setValue:[self AICP] forKey:OKAAICPKey];
    
    // 全路径
    NSString* fullURL = [NSString stringWithFormat:@"%@/%@", [self kNetWorkServiceAddress], path];
    
    NSURLSessionDataTask *dataTask = [[HttpManager shareHttpTool] PUT:fullURL params:nParemeters success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        // 统一格式返回
        [self netWorkServiceWithOperation:operation responseObject:responseObject success:success failure:failure];
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    return dataTask;
    
}

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
                              failure:(void (^)(NSError *))failure {
    
    return [self POSTWithFile:path param:param extension:extension data:data progress:NULL success:success failure:failure];
}

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
                                param:(NSDictionary*)param
                            extension:(NSString *)extension
                                 data:(NSArray *)data
                             progress:(void(^)(NSProgress *  uploadProgress))progress
                              success:(void (^)(id))success
                              failure:(void (^)(NSError *))failure {
    
    NSMutableDictionary* nParemeters = [NSMutableDictionary dictionaryWithDictionary:[self baseParams]];
    if (param.count > 0) {
        [nParemeters setValuesForKeysWithDictionary:param];
    }
    
    [nParemeters setValue:[self AICP] forKey:OKAAICPKey];
    
    // 全路径
    NSString* fullURL = [NSString stringWithFormat:@"%@/%@", [self kNetWorkServiceAddress], path];
    
    NSURLSessionDataTask *dataTask = [[HttpManager shareHttpTool] filePOST:fullURL params:nParemeters extension:extension data:data progress:progress success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        // 统一格式返回
        [self netWorkServiceWithOperation:operation responseObject:responseObject success:success failure:failure];
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
    
    return dataTask;
}

// 统一格式返回
+ (void)netWorkServiceWithOperation:(NSURLSessionDataTask *)operation responseObject:(id)responseObject success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSDictionary *dict;
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        dict = responseObject;
    }else {
        dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    }
    
    if (!dict) {
        failure([NSError errorWithDomain:@"com.BBDTek"
                                   code :1
                                userInfo:@{NSLocalizedDescriptionKey:@"网络数据结构错误!"}]);
        return;
    }
    
    NSHTTPURLResponse* response = (NSHTTPURLResponse*)operation.response;
    NSLog(@"%zd", response.statusCode);
    
    if(response.statusCode == 200){
        if (success) {
            success(dict);
        }
        return;
    }
    
    if (failure) {
        NSString* message = dict[@"message"];
        if (!message) {
            message = @"发生错误";
        }
        failure ([NSError errorWithDomain:@"com.BBDTek" code:[dict[@"status"] integerValue] userInfo:@{NSLocalizedDescriptionKey:message}]);
    }
    
}

#pragma mark -
#pragma mark - 需要在子类中实现的方法
/**
 * 基本参数
 */
+ (NSMutableDictionary*)baseParams {
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    
    // 版本号
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [params setValue:app_Version forKey:@"versionName"];
    
    // 手机设备ID
    NSString* UUIDString = [UIDevice currentDevice].identifierForVendor.UUIDString;
    [params setValue:UUIDString forKey:@"deviceid"];
    // 平台名称：Android iOS HTML5 Weixin
    [params setValue:@"iOS" forKey:@"platform"];
    
    // 设备名称
    UIDevice* device = [[UIDevice alloc] init];
    
    [params setValue:device.model forKey:@"moduleName"];
    
    return params;
}

/** 服务器地址 */
+ (NSString*)kNetWorkServiceAddress {
    
#ifdef DEBUG
    NSAssert(nil, @"友情提示: 弄一个子类, 重新返回服务器地址. 谢谢~' ");
#endif
    
    return @"";
}

/* 推送服务器地址 */
+ (NSString*)kPushNetWorkServiceAddress {
    
#ifdef DEBUG
    NSAssert(nil, @"友情提示: 弄一个子类, 重新返回服推送服务器地址. 谢谢~' ");
#endif
    
    return @"";
}

/** 返回渠道密码 */
+ (NSString*)AICP {
    
#ifdef DEBUG
    NSAssert(nil, @"友情提示: 弄一个子类, 重新返回一个对应的 渠道密码. 谢谢~' ");
#endif
    
    return @"";
}


@end

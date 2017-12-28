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
#pragma mark - 推送
/**
 *  推送 POST data from newtork
 *
 *  @param url     path string
 *  @param params   NSDictionary
 *  @param success 成功回调
 *  @param failure error ever occur
 */
+ (NSURLSessionDataTask*)pushPOSTWithPath:(NSString *)url
                                    param:(NSDictionary*)params
                                  success:(void (^)(id dataObject))success
                                  failure:(void (^)(NSError *error))failure {
    
    NSMutableDictionary* nParemeters = [NSMutableDictionary dictionaryWithDictionary:params];
    
    [nParemeters setValue:[self AICP] forKey:OKAAICPKey];
    
    // 全路径
    NSString* fullURL = [NSString stringWithFormat:@"%@/%@", [self kPushNetWorkServiceAddress], url];
    // 网络请求
    NSURLSessionDataTask *dataTask = [[HttpManager shareHttpTool] POST:fullURL params:nParemeters progress:NULL success:^(NSURLSessionDataTask *operation, id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
    return dataTask;
}

/**
 * 推送注册
 */
+ (NSURLSessionDataTask*)boundTokenWithParams:(NSDictionary*)paramas
                                      success:(void (^)(NSDictionary *bDict))success
                                      failure:(void (^)(NSError *bError))failure {
    
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    [dictM setValue:@"iOS" forKey:@"platform"];
    
    // 序列号
    NSString* identifierNumber = [[UIDevice currentDevice].identifierForVendor UUIDString] ;
    [dictM setValue:identifierNumber forKey:@"imei"];
    
    [dictM setValue:@"App Store" forKey:@"channel_name"];
    
    [dictM setObject:[[UIDevice currentDevice] systemName] forKey:@"devicename"];
    
    // 分辨率
    CGRect rect_screen = [[UIScreen mainScreen]bounds];
    CGSize size_screen = rect_screen.size;
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    NSInteger width = size_screen.width*scale_screen;
    NSInteger height = size_screen.height*scale_screen;
    
    [dictM setValue:@"system" forKey:@"type"];
    [dictM setValue:@"add" forKey:@"operate"];
    [dictM setValue:[NSString stringWithFormat:@"%zdx%zd",width,height] forKey:@"resolution"];
    
    // 版本
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *dec=[UIDevice currentDevice].systemVersion;
    [dictM setValue:version forKey:@"version"];
    [dictM setValue:dec forKey:@"os_version"];
    
    
    // 明波说channel_key可以不用管, 就是投放市场
    [dictM setValue:@"36cb594cde9c94251bfe6f2369ad5efa" forKey:@"channel_key"];
    
    /** APP语言：
     zh_CN 中文 (简体)
     zh_TW 中文 (繁体)
     en 英文
     */
    [dictM setValue:@"zh_CN" forKey:@"language"];
    
    // 手机设备号
    // TODO:[BTPublic UUIDString]
    [dictM setValue:@"" forKey:@"deviceid"];
    // app key
    //    [dictM setValue:PushAPPKey forKey:@"appkey"];
    // TODO:[NSDate dateyyyyMMddHHmmss:[NSDate date]]
    [dictM setValue:@"" forKey:@"create_date"];
    //    [dictM setValue:checkValue([BTUserModel currentUser].userCode) forKey:@"user_id"];
    
    // 不知道这是什么
    [dictM setValue:@"RP MSG" forKey:@"name"];
    
    
    /*
     // 1.判断是否登录中
     //    BOOL loginIng = ([CUPassWordManager currentUser] != nil);
     BOOL loginIng = [Public loginStatus];
     
     // 是否开启接收推送
     if (loginIng) {
     [dictM setValue:[Public userCode] forKey:@"user_id"];
     
     // device_token
     [dictM setValue:[Public deviceToken] forKey:@"device_token"];
     
     // enable 1:运行推送 0:禁止推送
     [dictM setValue:@"1" forKey:@"enable"];
     } else {
     // enable 1:运行推送 0:禁止推送
     [dictM setValue:@"0" forKey:@"enable"];
     }
     */
    
    if (paramas.count > 0) {
        [dictM setValuesForKeysWithDictionary:paramas];
    }
    
    // 请求
    NSURLSessionDataTask *dataTask = [self pushPOSTWithPath:@"tag" param:dictM success:success failure:failure];
    return dataTask;
}


/**
 * 消息到达注册
 */
+ (NSURLSessionDataTask*)messageDeilverWithParams:(NSDictionary *)paramas
                                          success:(void (^)(NSDictionary *bDict))success
                                          failure:(void (^)(NSError *bError))failure {
    
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    [dictM setValue:@"1" forKey:@"receive_num"];
    
    /*
     [params setValue:PushAPPKey forKey:@"appkey"];
     [params setValue:[Public userCode] forKey:@"user_id"];
     [params setValue:[Public deviceToken] forKey:@"device_token"];
     */
    if (paramas.count > 0) {
        [dictM setValuesForKeysWithDictionary:paramas];
    }
    
    // 请求
    NSURLSessionDataTask *dataTask = [self pushPOSTWithPath:@"message" param:dictM success:success failure:failure];
    return dataTask;
}

/**
 * 新消息添加
 */
+ (NSURLSessionDataTask*)getMessageContentWithParam:(NSDictionary *)paramas
                                            success:(void (^)(NSDictionary *bDict))success
                                            failure:(void (^)(NSError *bError))failure {
    
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    
    /*
     [params setValue:[Public userCode] forKey:@"user_id"];
     [params setValue:@"GUM" forKey:@"action"];
     
     [params setValue:PushAPPKey forKey:@"appkey"];
     [params setValue:[Public deviceToken] forKey:@"device_token"];
     */
    
    if (paramas.count > 0) {
        [dictM setValuesForKeysWithDictionary:paramas];
    }
    
    // 请求
    NSURLSessionDataTask *dataTask = [self pushPOSTWithPath:@"message" param:dictM success:success failure:failure];
    
    return dataTask;
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

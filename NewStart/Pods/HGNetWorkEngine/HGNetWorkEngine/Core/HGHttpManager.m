//
//  HGHttpManager.m
//  NWEManager
//
//  Created by  ZhuHong on 2017/9/4.
//  Copyright © 2017年 EasyMoveMobile. All rights reserved.
//

#import "HGHttpManager.h"
#import "AFNetworking.h"
#import "NSString+UserDefaults.h"

NSString* const HGAICPKey = @"HGAICPKey";

static NSString* const HGHttpManagerACCESSTOKENKey = @"HGHttpManagerACCESSTOKENKey";
static NSString* const HGHttpManagerSuiteName = @"HGHttpManagerSuiteName";

@interface HGHttpManager ()

/**
 请求管理者
 */
@property (strong, nonatomic) AFHTTPSessionManager *httpManager;

@property (nonatomic, strong) AFURLSessionManager *urlManager;

@property (nonatomic, assign) BOOL bodyRequest;

@property (nonatomic, copy) NSString* ACCESS_TOKEN;

@end

@implementation HGHttpManager

#pragma MARK -
#pragma mark - 创建HttpManager实例变量
+ (instancetype)shareHttpTool {
    static dispatch_once_t onceToken;
    static HGHttpManager   *_shateInstance;
    dispatch_once(&onceToken, ^{
        _shateInstance = [[self alloc] init];
        
    });
    return _shateInstance;
}

/**
 设置成Body请求方式, 主要用于 POST  GET
 */
+ (void)setupBodyRequest {
    HGHttpManager* httpManager = [HGHttpManager shareHttpTool];
    httpManager.bodyRequest = YES;
}

// 重写构造方法
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.urlManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        self.httpManager = [AFHTTPSessionManager manager];
        
        [self setUpResponseSerializer];
        
        NSBundle* bundle = [NSBundle mainBundle];
        NSArray *paths = [bundle pathsForResourcesOfType:@"cer" inDirectory:@"."];
        if (paths.count) {
            // 只有在有cer的情况下才设置
            self.httpManager.securityPolicy = [self customSecurityPolicy];
            self.urlManager.securityPolicy = [self customSecurityPolicy];
        }
    }
    return self;
}

#pragma mark 属性httpManager的设置
- (void)setUpResponseSerializer{
    
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript", @"text/plain", nil];
    
    // add `text/html` for server's response header `Content-Type` @author K6F
    self.httpManager.responseSerializer = responseSerializer;
    self.urlManager.responseSerializer = responseSerializer;
}


- (AFSecurityPolicy *)customSecurityPolicy {
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    [securityPolicy setAllowInvalidCertificates:YES];
    
    return securityPolicy;
}


/**
 默认设置 ACCESS_TOKEN 一般用于重本地获取
 
 @return 返回 获取状态
 */
+ (BOOL)setupACCESSTOKEN {
    // 本地获取
    NSString* token = [HGHttpManagerACCESSTOKENKey objectThroughUserDefaultsWithSuiteName:HGHttpManagerSuiteName];
    [self updateACCESSTOKENWithToken:token];
    
    if (token && (token.length > 0)) {
        HGHttpManager* httpManger = [self shareHttpTool];
        httpManger.ACCESS_TOKEN = token;
    }
    
    return YES;
}

/**
 更新 ACCESSTOKEN 的值
 
 @param token 新的 ACCESS_TOKEN
 */
+ (void)updateACCESSTOKENWithToken:(NSString*)token {
    
    HGHttpManager* httpManger = [self shareHttpTool];
    AFHTTPRequestSerializer *requestSerializer = httpManger.httpManager.requestSerializer;
    
    if (token.length > 0) {
        // 设置
        [requestSerializer setValue:token forHTTPHeaderField:@"ACCESS_TOKEN"];
        
        BOOL is = [token userDefaultsforKey:HGHttpManagerACCESSTOKENKey suiteName:HGHttpManagerSuiteName];
        
        httpManger.ACCESS_TOKEN = token;
        
#ifdef DEBUG
        NSLog(@"%@", is?@"存储正常":@"存储异常");
#endif
    } else {
        // 移除
        [requestSerializer setValue:nil forHTTPHeaderField:@"ACCESS_TOKEN"];
        
        httpManger.ACCESS_TOKEN = nil;
    }
}


#pragma mark -
#pragma mark - 网络请求相关操作

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
                      failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure {
    
    // 加密过后的参数
    NSDictionary* resultParams = [self resultParamsWithParams:params url:url];
    
    if (self.bodyRequest) {
        return [self Method:@"POST" POST:url params:resultParams success:success failure:failure];
    }
    
    // 网络请求
    NSURLSessionDataTask *dataTask = [self.httpManager POST:url parameters:resultParams progress:^(NSProgress *  uploadProgress) {
        
        if (progress) {
            progress(uploadProgress);
        }
        
    } success:^(NSURLSessionDataTask *  task, id  _Nullable responseObject) {
        // 返回数据统一处理
        [self resultWthTask:task responseObject:responseObject url:url success:success];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *  error) {
        
        // 错误信息统一返回
        [self errorWthTask:task error:error url:url failure:failure];
        
    }];
    
    return dataTask;
    
    
}

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
                     failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure {
    
    // 加密过后的参数
    NSDictionary* resultParams = [self resultParamsWithParams:params url:url];
    
    if (self.bodyRequest) {
        return [self Method:@"GET" POST:url params:resultParams success:success failure:failure];
    }
    
    // 网络请求
    NSURLSessionDataTask *dataTask = [self.httpManager GET:url parameters:resultParams progress:progress success:^(NSURLSessionDataTask *  task, id  _Nullable responseObject) {
        
        // 返回数据统一处理
        [self resultWthTask:task responseObject:responseObject url:url success:success];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *  error) {
        
        // 错误信息统一返回
        [self errorWthTask:task error:error url:url failure:failure];
        
    }];
    return dataTask;
}

- (NSURLSessionDataTask*)Method:(NSString*)Method
                           POST:(NSString *)url
                         params:(NSDictionary *)resultParams
                        success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                        failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure {
    
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:Method URLString:url parameters:nil error:nil];
    request.timeoutInterval = 60;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    if (self.ACCESS_TOKEN && (self.ACCESS_TOKEN.length > 0)) {
#ifdef DEBUG
        NSLog(@"当前的ACCESS_TOKEN值为 = %@", self.ACCESS_TOKEN);
#endif
        [request setValue:self.ACCESS_TOKEN forHTTPHeaderField:@"ACCESS_TOKEN"];
    }
    
    NSData* body =[NSJSONSerialization dataWithJSONObject:resultParams options:kNilOptions error:nil];
    // 设置body
    [request setHTTPBody:body];
    
    NSURLSessionDataTask *task = [self.urlManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            // 错误信息统一返回
            [self errorWthTask:nil error:error url:url failure:failure];
        } else {
            // 打印日志
#ifdef DEBUG
            if (responseObject) {
                NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
                NSLog(@"%@ === %@ == %@ \n\n= %@", response, responseObject, error, dict);
            }
#endif
            // 返回数据统一处理
            [self resultWthTask:nil responseObject:responseObject url:url success:success];
        }
    }];
    
    [task resume];
    
    return task;
}


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
                        failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure {
    
    // 加密过后的参数
    NSDictionary* resultParams = [self resultParamsWithParams:params url:url];
    
    // 网络请求
    NSURLSessionDataTask *dataTask = [self.httpManager DELETE:url parameters:resultParams success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 返回数据统一处理
        [self resultWthTask:task responseObject:responseObject url:url success:success];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 错误信息统一返回
        [self errorWthTask:task error:error url:url failure:failure];
    }];
    return dataTask;
}

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
                     failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure {
    
    // 加密过后的参数
    NSDictionary* resultParams = [self resultParamsWithParams:params url:url];
    
    // 网络请求
    NSURLSessionDataTask *dataTask = [self.httpManager PUT:url parameters:resultParams success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 返回数据统一处理
        [self resultWthTask:task responseObject:responseObject url:url success:success];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 错误信息统一返回
        [self errorWthTask:task error:error url:url failure:failure];
    }];
    return dataTask;
}

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
                          failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure {
    
    return [self filePOST:url params:params extension:extension data:ImageDatas progress:NULL success:success failure:failure];
}

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
                          failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure {
    // 加密过后的参数
    NSDictionary* resultParams = [self resultParamsWithParams:params url:url];
    
    // 网络请求
    NSURLSessionDataTask *dataTask = [self.httpManager POST:url parameters:resultParams constructingBodyWithBlock:^(id<AFMultipartFormData>   formData) {
        
        for (NSInteger i=0; i<ImageDatas.count; i++) {
            
            NSString *fileName;
            if ([extension.uppercaseString rangeOfString:@".JPEG"].length > 0 || [extension.uppercaseString rangeOfString:@".PNG"].length > 0 || [extension.uppercaseString rangeOfString:@".JPG"].length > 0)
            {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyyMMddHHmmssSSS";
                fileName = [NSString stringWithFormat:@"%@%zd%@",[formatter stringFromDate:[NSDate date]], i, extension];
            } else {
                fileName = extension;
            }
            NSData *fileData = ImageDatas[i];
            [formData appendPartWithFileData:fileData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
        }
        
    } progress:^(NSProgress *  uploadProgress) {
        
        if (progress) {
            progress(uploadProgress);
        }
        
    } success:^(NSURLSessionDataTask *  task, id  _Nullable responseObject) {
        
        // 返回数据统一处理
        [self resultWthTask:task responseObject:responseObject url:url success:success];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *  error) {
        
        // 错误信息统一返回
        [self errorWthTask:task error:error url:url failure:failure];
        
    }];
    
    return dataTask;
}


/**
 最终的参数 统一处理
 
 @param params 原始参数
 @param url 请求链接
 @return 返回最终参数
 */
- (NSDictionary*)resultParamsWithParams:(NSDictionary*)params url:(NSString*)url {
    
    NSMutableDictionary* tempDictM = [NSMutableDictionary dictionaryWithDictionary:params];
    
//    NSString* aicpValue = tempDictM[HGAICPKey];
    // 去除这个值
    [tempDictM removeObjectForKey:HGAICPKey];
    
    // 开始加密操作
    NSString* strURL = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:tempDictM
                                                       options:0
                                                         error:&error];
    if (!jsonData) {
        
#if DEBUG
        NSLog(@"Got an error: %@", error);
#endif
        
    } else {
        strURL = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    // 加密
    NSString* signHmacsha1STR = @"加密后的字符串";
    NSMutableDictionary* resultParams = [NSMutableDictionary dictionaryWithDictionary:tempDictM];
    [resultParams setValue:signHmacsha1STR forKey:@"sign"];
    
    
#if DEBUG
    // 便于调试查看请求信息
    NSMutableString *reqStr = [NSMutableString string];
    [resultParams enumerateKeysAndObjectsUsingBlock:^(id   key, id   obj, BOOL *  stop) {
        [reqStr appendString:[NSString stringWithFormat:@"%@=%@&",key,obj]];
    }];
    NSString *urlSTR = [NSString stringWithFormat:@"%@?%@", url, reqStr];
    //    urlSTR = [urlSTR stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"*************\nURL = %@\n***************", urlSTR);
    
    NSLog(@"\n\n 最终的请求参数列表 : %@ \n", resultParams);
    
#endif
    
    return resultParams;
}

/**
 返回数据统一处理
 */
- (void)resultWthTask:(NSURLSessionDataTask*)task responseObject:(id)responseObject url:(NSString*)url success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success {
#if DEBUG
    NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    NSLog(@"\n\n urlString : %@ \n%@\n\n", url, string);
#endif
    if (success) {
        success(task, responseObject);
    }
}

/**
 错误信息统一返回
 */
- (void)errorWthTask:(NSURLSessionDataTask*)task error:(NSError*)error url:(NSString*)url failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure {
    
#if DEBUG
    NSLog(@"\n\n urlString : %@ \n%@\n\n", url, error);
#endif
    
    if (failure) {
        failure(task, error);
    }
}

/** 取消当前正在发送中的请求 */
+ (void)cancelAllRequest {
    
    HGHttpManager* httpM = [self shareHttpTool];
    [httpM.httpManager.operationQueue cancelAllOperations];
}

@end

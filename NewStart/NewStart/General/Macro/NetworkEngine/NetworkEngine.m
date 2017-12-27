//
//  NetworkEngine.m
//  NewStart
//
//  Created by  ZhuHong on 2017/12/27.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "NetworkEngine.h"

@implementation NetworkEngine


#pragma MARK -
#pragma MARK - 从写父类的方法, 可以统一拦截某个特殊的操作
+ (NSURLSessionDataTask *)POSTWithPath:(NSString *)path param:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    return [super POSTWithPath:path param:param success:^(id dataObject) {
        // 状态码
        NSInteger code = [dataObject[@"code"] intValue];
        if (code == 4004) {
            // 说明当前用户网络请求出现异常,需要跳转登录界面 这个是所有接口都有可能发生的, 所以在这里拦截是很有必要的
            
            // TODO : 然后这里会去处理一些跳转登录界面的相关操作
            
        }
        
        if (success) {
            success(dataObject);
        }
    } failure:failure];
    
}


#pragma MARK -
#pragma MARK - 以下都是配置
/** 服务器地址 */
+ (NSString*)kNetWorkServiceAddress {
    return @"https://httpbin.org/";
}

+ (NSString*)AICP {
    return @"AICPAICPAICPAICPAICPAICPAICPAICPAICP";
}

// 这里一般都是所有接口都需要的公参
+ (NSMutableDictionary *)baseParams {
    NSMutableDictionary* params = [super baseParams];
    // 设置语言
    [params setValue:@"zh_CN" forKey:@"language"];
    
    return params;
}

@end

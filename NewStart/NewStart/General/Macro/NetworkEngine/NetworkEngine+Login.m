//
//  NetworkEngine+Login.m
//  NewStart
//
//  Created by  ZhuHong on 2017/12/27.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "NetworkEngine+Login.h"

@implementation NetworkEngine (Login)

/**
 登录接口
 
 @param params 参数:
   username 登录账号
   password 登录密码
 */
+ (void)loginWithParams:(NSDictionary*)params
                success:(void (^)(id dataObject))success
                failure:(void (^)(NSError *error))failure {
    [self POSTWithPath:@"post" param:params success:success failure:failure];
}

// 其实这里为什么要这么做? 为什么不直接在外面调用POSTWithPath:param:success:failure: ? 而要再加这么一层? 这也是想了许久的问题, 在这里主要就是一个统一管理.这样做, 我感觉还不错.

@end

//
//  NetworkEngine+Login.h
//  NewStart
//
//  Created by  ZhuHong on 2017/12/27.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "NetworkEngine.h"

@interface NetworkEngine (Login)

/**
 登录接口
 
 @param params 参数:
   username 登录账号
   password 登录密码
 */
+ (void)loginWithParams:(NSDictionary*)params
                success:(void (^)(id dataObject))success
                failure:(void (^)(NSError *error))failure;

@end

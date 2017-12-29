//
//  MessageModel.m
//  NewStart
//
//  Created by  ZhuHong on 2017/12/29.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

/** 创建一个对象 */
+ (instancetype)modelWithTitle:(NSString*)title urlID:(NSString*)url_id {
    // 创建
    MessageModel* msgModel = [[self alloc] init];
    
    // 赋值
//    msgModel.title = title.copy;
    msgModel.title = title;
    msgModel.url_id = url_id;
    
    // 返回
    return msgModel;
}

@end

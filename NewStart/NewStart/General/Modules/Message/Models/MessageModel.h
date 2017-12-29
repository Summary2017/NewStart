//
//  MessageModel.h
//  NewStart
//
//  Created by  ZhuHong on 2017/12/29.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "BaseModel.h"

@interface MessageModel : BaseModel

/**
 创建一个对象

 @param title 标题
 @param url_id 跳转链接id
 @return 对象
 */
+ (instancetype)modelWithTitle:(NSString*)title urlID:(NSString*)url_id;

/** 标题 */
@property (nonatomic, copy) NSString* title;
/** 跳转链接id */
@property (nonatomic, copy) NSString* url_id;

@end

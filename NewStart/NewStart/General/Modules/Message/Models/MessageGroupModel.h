//
//  MessageGroupModel.h
//  NewStart
//
//  Created by  ZhuHong on 2017/12/29.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "BaseModel.h"
@class MessageModel;

@interface MessageGroupModel : BaseModel

/** 类别 */
@property (nonatomic, copy) NSString* category;

/** 所有的数据 */
@property (nonatomic, strong) NSMutableArray<MessageModel*>* messages;

@end

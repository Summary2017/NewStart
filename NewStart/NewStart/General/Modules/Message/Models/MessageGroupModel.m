//
//  MessageGroupModel.m
//  NewStart
//
//  Created by  ZhuHong on 2017/12/29.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "MessageGroupModel.h"

@implementation MessageGroupModel

#pragma mark -
#pragma mark - 懒加载
- (NSMutableArray<MessageModel *> *)messages {
    if (!_messages) {
        _messages = [NSMutableArray<MessageModel *> array];
    }
    return _messages;
}

@end

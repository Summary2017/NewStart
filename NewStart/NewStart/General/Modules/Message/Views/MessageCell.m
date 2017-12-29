//
//  MessageCell.m
//  NewStart
//
//  Created by  ZhuHong on 2017/12/29.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "MessageCell.h"
#import "MessageModel.h"

@implementation MessageCell

- (void)setMsgModel:(MessageModel *)msgModel {
    _msgModel = msgModel;
    
    self.textLabel.text = msgModel.title;
}

@end

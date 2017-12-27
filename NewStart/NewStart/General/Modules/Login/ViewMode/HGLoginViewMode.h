//
//  HGLoginViewMode.h
//  CoderHG
//
//  Created by  ZhuHong on 2016/11/12.
//  Copyright © 2016年 CoderHG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HGInputInfoModel.h"
#import <ReactiveCocoa.h>

@interface HGLoginViewMode : NSObject

// 输入的信息
@property (nonatomic, strong) HGInputInfoModel* accountMode;

// 是否允许登录的信号
@property (nonatomic, strong, readonly) RACSignal* enableSignal;

// 登录事件
@property (nonatomic, strong, readonly) RACCommand* loginCommand;


/**
 nil: 开始登录
 非nil: 登录结束(成功/失败)
 */
@property (nonatomic, copy) NSString* loginResultSTR;

@end

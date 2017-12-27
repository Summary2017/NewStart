//
//  HGLoginViewMode.m
//  CoderHG
//
//  Created by  ZhuHong on 2016/11/12.
//  Copyright © 2016年 CoderHG. All rights reserved.
//

#import "HGLoginViewMode.h"
#import "NetworkEngine+Login.h"

@interface HGLoginViewMode ()

// 是否允许登录的信号
@property (nonatomic, strong) RACSignal* enableSignal;

// 登录事件
@property (nonatomic, strong) RACCommand* loginCommand;

@end

@implementation HGLoginViewMode

#pragma mark - 懒加载
// 输入的账号信息
- (HGInputInfoModel *)accountMode {
    if (!_accountMode) {
        _accountMode = [[HGInputInfoModel alloc] init];
    }
    return _accountMode;
}

// 是否允许登录的信号
- (RACSignal *)enableSignal {
    if (!_enableSignal) {
        // 聚合信号
        _enableSignal = [RACSignal combineLatest:@[RACObserve(self.accountMode, username), RACObserve(self.accountMode, password)] reduce:^id(NSString* userName, NSString*password){
            // 输入的都有长度的情况下
            return @(userName.length && password.length);
        }];
    }
    return _enableSignal;
}

// 登录事件
- (RACCommand *)loginCommand {
    if (!_loginCommand) {
        
        // 业务逻辑
        @weakify(self);
        _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            // 点击按钮
            NSLog(@"开始了");
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self)
                // 参数
                NSMutableDictionary* params = [NSMutableDictionary dictionary];
                [params setValue:self.accountMode.username forKey:@"username"];
                [params setValue:self.accountMode.password forKey:@"username"];
                [NetworkEngine loginWithParams:params success:^(id dataObject) {
                    NSLog(@"%@", dataObject);
                    
                    if ([self.accountMode.username.uppercaseString isEqualToString:@"HG"] && [self.accountMode.password.uppercaseString isEqualToString:@"HG123"]) {
                        [subscriber sendNext:@"登录成功"];
                        
                        // 数据传送完毕，必须调用完成，否则命令永远处于执行状态
                        [subscriber sendCompleted];
                    } else {
                        [subscriber sendNext:@"用户名或者明码输入错误"];
                        
                        // 数据传送完毕，必须调用完成，否则命令永远处于执行状态
                        [subscriber sendError:[[NSError alloc] initWithDomain:@"错误的" code:123456 userInfo:@{@"key":@"出错了"}]];
                    }
                    
                } failure:^(NSError *error) {
                    NSLog(@"%@", error.localizedDescription);
                    
                    [subscriber sendNext:@"登录失败"];
                    
                    // 数据传送完毕，必须调用完成，否则命令永远处于执行状态
                    if (error) {
                        [subscriber sendError:error];
                    } else {
                        [subscriber sendError:[[NSError alloc] initWithDomain:@"Error" code:123456 userInfo:@{@"key":@"出错了"}]];
                    }
                    
                    
                }];
                /*
                // 模仿网络延迟
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if ([self.accountMode.username isEqualToString:@"HG"] && [self.accountMode.password isEqualToString:@"HG123"]) {
                        [subscriber sendNext:@"登录成功"];
                        
                        // 数据传送完毕，必须调用完成，否则命令永远处于执行状态
                        [subscriber sendCompleted];
                    } else {
                        [subscriber sendNext:@"登录失败"];
                        
                        // 数据传送完毕，必须调用完成，否则命令永远处于执行状态
                        [subscriber sendError:[[NSError alloc] initWithDomain:@"错误的" code:123456 userInfo:@{@"key":@"出错了"}]];
                    }
                    
                });
                 */
                return nil;
            }];
        }];
        
        
        // 监听登录产生的数据
        [_loginCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
//            if ([x isEqualToString:@"登录成功"]) {
//                NSLog(@"登录成功");
//            }
            @strongify(self)
            self.loginResultSTR = x;
            
        }];
        
        
        // 监听登录状态只能监听开始与结束, 那就是是否有加载矿
        [[_loginCommand.executing skip:1] subscribeNext:^(id x) {
            @strongify(self)
            if ([x isEqualToNumber:@(YES)]) {
                
                // 正在登录ing...
                // 用蒙版提示
//                DLog(@"正在登录ing...")
                
                self.loginResultSTR = nil;
                
                
            }else
            {
                // 登录成功
//                DLog(@"登录结束")
            }
        }];
    }
    
    return _loginCommand;
}



@end

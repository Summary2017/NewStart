//
//  HGHFView.m
//  HGKitManager
//
//  Created by  ZhuHong on 2017/9/3.
//  Copyright © 2017年 EasyMoveMobile. All rights reserved.
//

#import "HGHFView.h"

@implementation HGHFView

/**
 快速创建一个对象
 
 @param tableView 对应表视图
 @return 返回
 */
+ (instancetype)hfView:(UITableView*)tableView {
    // 以当前 class 作为唯一标识
    NSString* ID = NSStringFromClass(self);
    // 重用池中获取
    HGHFView* hfView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (!hfView) {
        // 注册
        [tableView registerClass:self forHeaderFooterViewReuseIdentifier:ID];
        // 重新获取
        hfView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    }
    // 返回
    return hfView;
    
}

+ (instancetype)xibHFView:(UITableView *)tableView {
    // 以当前 class 作为唯一标识
    NSString* ID = NSStringFromClass(self);
    // 重用池中获取
    HGHFView* hfView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (!hfView) {
        // 注册
        [tableView registerNib:[UINib nibWithNibName:ID bundle:nil] forCellReuseIdentifier:ID];
        // 重新获取
        hfView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    }
    // 返回
    return hfView;
}

+ (id)blankHFView:(UITableView *)tableView {
    // 以当前 class 作为唯一标识
    static NSString* const ID = @"OKAHFView_Blank";
    // 重用池中获取
    HGHFView* hfView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (!hfView) {
        // 注册
        [tableView registerClass:self forHeaderFooterViewReuseIdentifier:ID];
        // 重新获取
        hfView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    }
    // 返回
    return hfView;
}

@end

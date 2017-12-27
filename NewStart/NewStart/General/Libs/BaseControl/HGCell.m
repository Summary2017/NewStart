//
//  HGCell.m
//  HGKitManager
//
//  Created by  ZhuHong on 2017/9/3.
//  Copyright © 2017年 EasyMoveMobile. All rights reserved.
//

#import "HGCell.h"

@implementation HGCell


/** 快速获取cell */
+ (instancetype)cell:(UITableView*)tableView {
    NSString* ID = NSStringFromClass(self);
    HGCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        [tableView registerClass:self forCellReuseIdentifier:ID];
        cell = [tableView dequeueReusableCellWithIdentifier:ID];
    }
    
    return cell;
}

/** 快速获取cell */
+ (instancetype)xibCell:(UITableView*)tableView {
    NSString* ID = NSStringFromClass(self);
    HGCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:ID bundle:nil] forCellReuseIdentifier:ID];
        cell = [tableView dequeueReusableCellWithIdentifier:ID];
    }
    
    return cell;
}

/** 返回一个空白的cell */
+ (id)blankCell:(UITableView*)tableView {
    static NSString* const ID = @"OKABlanckCellID";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
        cell = [tableView dequeueReusableCellWithIdentifier:ID];
    }
    return cell;
}


@end

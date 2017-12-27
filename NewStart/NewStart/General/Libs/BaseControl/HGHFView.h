//
//  HGHFView.h
//  HGKitManager
//
//  Created by  ZhuHong on 2017/9/3.
//  Copyright © 2017年 EasyMoveMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HGHFView : UITableViewHeaderFooterView

/**
 快速创建一个对象, 通常用于纯代码编写的子类
 
 @param tableView 对应表视图
 @return 返回实例对象
 */
+ (instancetype)hfView:(UITableView*)tableView;

/**
 快速创建一个对象, 通常用于XIB
 
 @param tableView 对应表视图
 @return 返回实例对象
 */
+ (instancetype)xibHFView:(UITableView*)tableView;

/**
 返回一个空白的对象 
 
 @param tableView 对应表视图
 @return 返回实例对象
 */
+ (id)blankHFView:(UITableView*)tableView;

@end

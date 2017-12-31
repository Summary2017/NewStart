//
//  HGContentMode.h
//  HGTabView
//
//  Created by  ZhuHong on 16/3/26.
//  Copyright © 2016年 HG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HGContentMode : NSObject

/** cell的类型
 可能是UIView的子类
 也有可能是UIViewController的子类
 */
@property (nonatomic, assign) Class hgCls;
/**
 block实现回调刷新数据
 */
@property (nonatomic, copy) void (^hgBlock)(id);

@end

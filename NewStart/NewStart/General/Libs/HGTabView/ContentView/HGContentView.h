//
//  HGContentView.h
//  HGTabView
//
//  Created by  ZhuHong on 16/3/22.
//  Copyright © 2016年 HG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HGContentView;
@class HGContentMode;

@protocol HGContentViewDelegate <NSObject>
@required
- (HGContentMode*)contentView:(HGContentView*)view viewForPage:(NSInteger)page;

@end

@interface HGContentView : UIView

/** 快速获取实例对象 */
+ (instancetype)contentView;

/** 代理属性 */
@property (nonatomic, weak) id<HGContentViewDelegate> delegate;

@property (nonatomic, assign) NSInteger contentHGCount;

@end

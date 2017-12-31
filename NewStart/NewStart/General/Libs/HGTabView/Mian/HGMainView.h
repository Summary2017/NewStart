//
//  HGMainView.h
//  HGTabView
//
//  Created by  ZhuHong on 16/3/26.
//  Copyright © 2016年 HG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HGMainView;
@class HGContentMode;

@protocol HGMainViewDelegate <NSObject>

@required
/** 标签上的所有文本
 这个代理方法类似于UITableView的(sectionIndexTitlesForTableView:)代理方法
 */
- (NSArray*)tabMainView:(HGMainView*)view;

/*  返回每个标签所对应的视图
 这个代理方法类似于UITableView的(tableView:cellForRowAtIndexPath:)代理方法
 */
- (HGContentMode*)mainView:(HGMainView*)view viewForPage:(NSInteger)page;

@end

@interface HGMainView : UIView

/** 快速获取实例对象 */
+ (instancetype)mainView;

#pragma mark - 属性
@property (nonatomic, weak) id<HGMainViewDelegate> delegate;

/** 刷新数据 */
- (void)reloadData;

@end





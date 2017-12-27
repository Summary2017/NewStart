//
//  BaseTBController.h
//  NewStart
//
//  Created by  ZhuHong on 2017/12/27.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

/**
 这个主要是用于使用UITableView的子控制器, 自动带有一个已经处理好的UITableView
 */

#import "BaseController.h"

@interface BaseTBController : BaseController <UITableViewDataSource, UITableViewDelegate>

/** 一定要在[super viewDidLoad];之前调用 */
@property (nonatomic, assign) UITableViewStyle tableViewStyle;

@property (nonatomic, weak, readonly) UITableView* tableView;

@end

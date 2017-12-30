//
//  HomeCell.h
//  NewStart
//
//  Created by  ZhuHong on 2017/12/30.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

/** 纯代码编写
 类似腾讯新闻要闻
 */

#import "BaseCell.h"
@class HomeModel;

@interface HomeCell : BaseCell

/** 数据模型 */
@property (nonatomic, strong) HomeModel* homeModel;

@end

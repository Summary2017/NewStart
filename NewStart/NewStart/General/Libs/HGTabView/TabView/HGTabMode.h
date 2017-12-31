//
//  HGTabMode.h
//  HGTabView
//
//  Created by  ZhuHong on 16/3/22.
//  Copyright © 2016年 HG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HGTabMode : NSObject

/** 标签的文本 */
@property (nonatomic, copy) NSString* contentStr;
/** 标签的选中状态
 YES: 选中
 NO : 未选中
 */
@property (nonatomic, assign) BOOL hgSelected;

@end

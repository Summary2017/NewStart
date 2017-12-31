//
//  HGTabCell.h
//  HGTabView
//
//  Created by  ZhuHong on 16/3/22.
//  Copyright © 2016年 HG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HGTabMode;

@interface HGTabCell : UICollectionViewCell

/** 对应的mode */
@property (nonatomic, strong) HGTabMode* mode;

@end

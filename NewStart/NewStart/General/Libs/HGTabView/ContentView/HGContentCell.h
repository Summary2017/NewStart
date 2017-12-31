//
//  HGContentCell.h
//  HGTabView
//
//  Created by  ZhuHong on 16/3/22.
//  Copyright © 2016年 HG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HGContentMode;

@interface HGContentCell : UICollectionViewCell

/** 返回HGContentCell类型的实例
 在UICollectionViewCell原生态的基础上,做一些特殊的处理
 */
+ (instancetype)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath contentMode:(HGContentMode*)contentMode;

@end

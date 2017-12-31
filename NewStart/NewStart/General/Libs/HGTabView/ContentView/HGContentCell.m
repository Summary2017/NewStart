//
//  HGContentCell.m
//  HGTabView
//
//  Created by  ZhuHong on 16/3/22.
//  Copyright © 2016年 HG. All rights reserved.
//

#import "HGContentCell.h"
#import "HGContentMode.h"

static NSString* const ID = @"HGContentCell";

@interface HGContentCell ()

@property (nonatomic, weak) UIView* hgView;
@property (nonatomic, strong) UIViewController* hgVC;

@end

@implementation HGContentCell

/** 返回HGContentCell类型的实例
 在UICollectionViewCell原生态的基础上,做一些特殊的处理
 */
+ (instancetype)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath contentMode:(HGContentMode*)contentMode {
    // 先给UICollectionView做一下cell的注册
    [collectionView registerClass:self forCellWithReuseIdentifier:NSStringFromClass(contentMode.hgCls)];
    
    // 冲从缓存池中获取
    HGContentCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(contentMode.hgCls) forIndexPath:indexPath];
    
    // 判断里面的视图或者控制器是否被创建过
    if (cell.hgView == nil) {
        if ([contentMode.hgCls isSubclassOfClass:UIView.class]) {
            // 视图
            UIView* hgView = [[contentMode.hgCls alloc] init];
            [cell addSubview:hgView];
            cell.hgView = hgView;
        } else if ([contentMode.hgCls isSubclassOfClass:UIViewController.class]) {
            // 视图控制器
            UIViewController* hgVC = [[contentMode.hgCls alloc] init];
            [cell addSubview:hgVC.view];
            cell.hgView = hgVC.view;
            cell.hgVC = hgVC;
        }
    }
    
    // 是否回调
    if (contentMode.hgBlock) {
        if ([contentMode.hgCls isSubclassOfClass:UIView.class]) {
            // 视图回调
            contentMode.hgBlock(cell.hgView);
        } else if ([contentMode.hgCls isSubclassOfClass:UIViewController.class]) {
            // 视图控制器回调
            contentMode.hgBlock(cell.hgVC);
        }
        
    }
    
    return cell;
}

// 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.hgView.frame = self.bounds;
}

@end

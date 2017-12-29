//
//  UICollectionView+HG.m
//  NewStart
//
//  Created by  ZhuHong on 2017/12/29.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "UICollectionView+HG.h"

@implementation UICollectionView (HG)


+ (instancetype)cuCollectionView:(void (^)(UICollectionViewFlowLayout* layout))backBlock {
    
    return [self collectionView:backBlock];
}


/**
 快速创建 UICollectionView 实例
 */
+ (instancetype)collectionView:(void (^)(UICollectionViewFlowLayout* layout))backBlock {
    
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0.0;
    layout.minimumLineSpacing = 0.0;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    UICollectionView* collectionView = [[self alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.contentInset = UIEdgeInsetsMake(0, 0.0, 0, 0.0);
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    
    // 回调
    if (backBlock) {
        backBlock(layout);
    }
    
    return collectionView;
}

@end

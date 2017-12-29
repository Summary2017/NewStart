//
//  UICollectionView+HG.h
//  NewStart
//
//  Created by  ZhuHong on 2017/12/29.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (HG)

+ (instancetype)cuCollectionView:(void (^)(UICollectionViewFlowLayout* layout))backBlock;

@end

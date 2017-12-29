//
//  UIView+OKA.h
//  CategoryManager
//
//  Created by  ZhuHong on 2017/2/22.
//  Copyright © 2017年 OKA_APP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HG)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

#pragma mark Frame Borders
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;

// Middle Point
@property (nonatomic, readonly) CGPoint middlePoint;
@property (nonatomic, readonly) CGFloat middleX;
@property (nonatomic, readonly) CGFloat middleY;

@property (nonatomic, strong) UIViewController *hg_parentViewController;

/** 虚线边框 */
- (void)borderDottedLineWithColor:(UIColor*)color;

@end

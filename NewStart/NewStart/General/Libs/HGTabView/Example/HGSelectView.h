//
//  HGSelectView.h
//  HGTabView
//
//  Created by  ZhuHong on 16/3/27.
//  Copyright © 2016年 HG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HGSelectView;

@protocol HGSelectViewDelegate <NSObject>

- (void)selectView:(HGSelectView*)view didSelectItem:(NSString*)item;

@end

@interface HGSelectView : UIView

+ (instancetype)selectView;

@property (nonatomic, weak) id<HGSelectViewDelegate> delegate;
@property (nonatomic, strong) NSArray* items;

@end

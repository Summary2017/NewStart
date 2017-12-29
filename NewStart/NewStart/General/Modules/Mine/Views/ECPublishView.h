//
//  ECPublishView.h
//  ElecCarManager
//
//  Created by XXL on 16/8/11.
//  Copyright © 2016年 BBDTek. All rights reserved.
//

#import "BaseView.h"

@protocol ECPublishViewDelegate <NSObject>

- (void)didPressPublishName:(NSString *)controllerName;

@end

@interface ECPublishView : BaseView

@property (weak, nonatomic) id<ECPublishViewDelegate> delegate;

@property (assign, nonatomic) BOOL isShow;

+ (instancetype)piblishViewWithArrowOrigin:(CGPoint)arrowOrigin;

- (void)show;
- (void)disappear;

@end

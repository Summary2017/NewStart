//
//  CUSuffingView.h
//  CUnionManager
//
//  Created by Tuling Code on 16/6/3.
//  Copyright © 2016年 bbdtek. All rights reserved.
//

#import "BaseView.h"

@protocol SuffingViewDelegate <NSObject>

- (void)didSelectItem:(id)mode;

@end

@interface SuffingView : BaseView

@property (nonatomic, weak) id <SuffingViewDelegate> delegate;

@property (nonatomic, strong) NSArray *advs;

@end

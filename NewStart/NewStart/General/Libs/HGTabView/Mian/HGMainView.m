//
//  HGMainView.m
//  HGTabView
//
//  Created by  ZhuHong on 16/3/26.
//  Copyright © 2016年 HG. All rights reserved.
//

#import "HGMainView.h"
#import "HGTabView.h"
#import "HGContentView.h"
#import "HGContentMode.h"
#import "UIView+HG.h"

@interface HGMainView () <HGContentViewDelegate>

@property (nonatomic, weak) HGTabView* tabView;
@property (nonatomic, weak) HGContentView* contentView;

@end

@implementation HGMainView

/** 快速获取实例对象 */
+ (instancetype)mainView {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    // 创建子视图
    [self setupSubviews];
    
    return self;
}

/** 创建子视图 */
- (void)setupSubviews {
    HGTabView* tabView = [HGTabView tabView];
    tabView.height = 50.0;
    tabView.backgroundColor = [UIColor whiteColor];
    [self addSubview:tabView];
    self.tabView = tabView;
    
    
    HGContentView* contentView = [HGContentView contentView];
    contentView.delegate = self;
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.frame = CGRectMake(0, tabView.height, self.width, self.height);
    [self addSubview:contentView];
    self.contentView = contentView;
}

- (void)setDelegate:(id<HGMainViewDelegate>)delegate {
    _delegate = delegate;
    [self reloadData];
}


#pragma mark - HGContentViewDelegate
- (HGContentMode *)contentView:(HGContentView *)view viewForPage:(NSInteger)page {
    HGContentMode* contentView = nil;
    if (self.delegate && [self.delegate respondsToSelector:@selector(mainView:viewForPage:)]) {
        contentView = [self.delegate mainView:self viewForPage:page];
    }
    return contentView;
}


/** 刷新数据 */
- (void)reloadData {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabMainView:)]) {
        self.tabView.contentArr = [self.delegate tabMainView:self];
        self.contentView.contentHGCount = [self.delegate tabMainView:self].count;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.tabView.frame = CGRectMake(0, 0, self.width, 50.0);
    self.contentView.frame = CGRectMake(0, 50.0, self.width, self.height-50.0);
}

@end

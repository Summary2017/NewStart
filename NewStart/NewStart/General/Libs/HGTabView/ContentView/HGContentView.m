//
//  HGContentView.m
//  HGTabView
//
//  Created by  ZhuHong on 16/3/22.
//  Copyright © 2016年 HG. All rights reserved.
//

#import "HGContentView.h"
#import "HGContentCell.h"
#import "HGContentMode.h"
#import "UIView+HG.h"

static NSString* const BlanckID = @"HGContentViewBlanckID";

@interface HGContentView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView* collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout* layout;

@end

@implementation HGContentView

/** 快速获取实例对象 */
+ (instancetype)contentView {
    return [[self alloc] init];
}

// 构造方法
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    // 创建layout
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0.0;
    layout.minimumLineSpacing = 0.0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 创建collectionView
    UICollectionView* collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.layout = layout;
    // 初始设置
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.pagingEnabled = YES;
    collectionView.bounces = NO;
    // 注册cell
    [collectionView registerClass:[HGContentCell class] forCellWithReuseIdentifier:BlanckID];
    
    // 代理
    collectionView.dataSource = self;
    collectionView.delegate = self;
    // 去掉滚动条
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    
    // 添加
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    
    // 注册通知从选项卡发来的通知
    [HGNotificationCenter addObserver:self selector:@selector(tabToContent:) name:HGTabToContentNotification object:nil];
    
    return self;
}

// 接收通知的方法
- (void)tabToContent:(NSNotification*)noti {
    NSDictionary* itemDict = noti.object;
    NSNumber* itemNumber = itemDict[HGContentTabKey];
    
    // 重新赋值的时候管用
    if (self.contentHGCount > 0) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:itemNumber.intValue inSection:0];
        [self.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    }
    
}

- (void)setContentHGCount:(NSInteger)contentHGCount {
    _contentHGCount = contentHGCount;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.contentHGCount;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HGContentMode* contentMode = nil;
    if (self.delegate && [self.delegate respondsToSelector:@selector(contentView:viewForPage:)]) {
        contentMode = [self.delegate contentView:self viewForPage:indexPath.item];
    }
    
    HGContentCell* cell = [HGContentCell collectionView:collectionView cellForItemAtIndexPath:indexPath contentMode:contentMode];
    
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger item = scrollView.contentOffset.x / scrollView.width;
    NSNumber* itemStr = @(item);
    
    NSDictionary* dict = @{HGContentTabKey:itemStr};
    // 发送通知
    [HGNotificationCenter postNotificationName:HGContentToTabNotification object:dict];
}

// 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.layout.itemSize = self.bounds.size;
    self.collectionView.frame = self.bounds;
    
}

// 移除通知
- (void)dealloc {
    [HGNotificationCenter removeObserver:self];
}

@end

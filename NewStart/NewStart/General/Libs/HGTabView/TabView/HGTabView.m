//
//  HGTabView.m
//  HGTabView
//
//  Created by  ZhuHong on 16/3/22.
//  Copyright © 2016年 HG. All rights reserved.
//

#import "HGTabView.h"
#import "HGTabCell.h"
#import "HGTabMode.h"
#import "NSString+SIZE.h"

static NSString* const ID = @"HGCell";

@interface HGTabView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView* collectionView;

/** 打开/关闭按钮 */
@property (nonatomic, weak) UIButton* foldBtn;

@end

@implementation HGTabView

+ (instancetype)tabView {
    //    return [[UIView alloc] init]; // 错误
    //    return [[HGTabView alloc] init]; // 为什么?留给大家思考.在什么情况下,会出现问题?
    return [[self alloc] init]; // 很标准的写法 为什么?自己去研究.
}

/** 当从Xib或者故事版中创建本视图的时候被调用 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    // 创建并添加子视图
    [self setupSubViews];
    
    return self;
}


// init,initWithFrame:
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    // 创建并添加子视图
    [self setupSubViews];
    
    [HGNotificationCenter addObserver:self selector:@selector(contentToTab:) name:HGContentToTabNotification object:nil];
    
    return self;
}

// 从contentView发过来的通知
- (void)contentToTab:(NSNotification*)noti {
    NSDictionary* itemDict = noti.object;
    NSNumber* itemNumber = itemDict[HGContentTabKey];
    
    
    NSIndexPath* indexPath = [NSIndexPath indexPathForItem:itemNumber.intValue inSection:0];
    [self didSelectItemAtIndexPath:indexPath];
    
}

// "在OC中,没有真正的私有这一说."怎么理解这一句话?
// 在视图中的构造方法中,我们只做两件事:创建与添加.

/** 创建并添加子视图,对一些默认的设置 */
- (void)setupSubViews {
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(100, 40);
    layout.minimumInteritemSpacing = 0.0;
    layout.minimumLineSpacing = 3.0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView* collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.contentInset = UIEdgeInsetsMake(0, 5.0, 0, 5.0);
    
    [collectionView registerClass:[HGTabCell class] forCellWithReuseIdentifier:ID];
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    
    [self addSubview:collectionView];
    self.collectionView = collectionView;
}

// set方法
- (void)setContentArr:(NSArray *)contentArr {
    _contentArr = contentArr;
    
    HGTabMode* mode = contentArr.firstObject;
    mode.hgSelected = YES;
    
    [self.collectionView reloadData];
    
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    
    NSNumber* itemStr = @(0);
    
    NSDictionary* dict = @{HGContentTabKey:itemStr};
    
    [HGNotificationCenter postNotificationName:HGTabToContentNotification object:dict];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.contentArr.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    HGTabMode* mode = self.contentArr[indexPath.item];
    
    CGFloat width = [mode.contentStr hgStringWithFont:[UIFont systemFontOfSize:16.0] width:CGFLOAT_MAX height:CGFLOAT_MAX].width + 20;
    return CGSizeMake(width+20, 40.0);
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 获取:一定要先注册,否则闪退
    HGTabCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    // 赋值 ?
    cell.mode = self.contentArr[indexPath.item];
    
    // 返回
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self didSelectItemAtIndexPath:indexPath];
    
    NSInteger item = indexPath.item;
    NSNumber* itemStr = @(item);
    
    NSDictionary* dict = @{HGContentTabKey:itemStr};
    
    [HGNotificationCenter postNotificationName:HGTabToContentNotification object:dict];
}

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    for (HGTabMode* mode in self.contentArr) {
        mode.hgSelected = NO;
    }
    
    HGTabCell* cell = (HGTabCell*)[self.collectionView cellForItemAtIndexPath:indexPath];
    HGTabMode* mode = cell.mode;
    mode.hgSelected = YES;
    
    [self.collectionView reloadData];
    
    [self.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
}

// 布局子视图,都在这里---->layout(布局)Subviews(所有子视图)
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.collectionView.frame = self.bounds;
//    self.collectionView.width -= 80.0;
//    self.foldBtn.frame = HGCGM(self.width-80, 0, 80.0, self.height);
}

// 移除通知
- (void)dealloc {
    [HGNotificationCenter removeObserver:self];
}

@end

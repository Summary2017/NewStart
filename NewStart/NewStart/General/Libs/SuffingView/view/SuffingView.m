//
//  CGSuffingView.m
//  CargoManager
//
//  Created by  ZhuHong on 16/2/25.
//  Copyright © 2016年 BBDTEK. All rights reserved.
//

#import "SuffingView.h"
#import "SuffingCell.h"
#import "HomeADVModel.h"
#import "NSString+Color.h"
#import "UIView+HG.h"
#import "UICollectionView+HG.h"

static NSString* ID = @"shuffing";

// 每一组最大的行数
#define MCTotalRowsInSection (5000 * self.advs.count)
#define MCDefaultRow (NSUInteger)(MCTotalRowsInSection * 0.5)

@interface SuffingView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) UICollectionView* collectionView;
@property (weak, nonatomic) UIPageControl* pageControl;

/** 定时器 */
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UICollectionViewFlowLayout* layOut;

/** 当没有轮播图的时候,让其显示默认图 */
@property (nonatomic, weak) UIImageView* placeholderView;

@end

@implementation SuffingView

- (void)setup_ {
    __weak typeof(self) weakSelf = self;
    
    UICollectionView *collectionView = [UICollectionView cuCollectionView:^(UICollectionViewFlowLayout *layout) {
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        weakSelf.layOut = layout;
    }];
    
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.pagingEnabled = YES;
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    
    
    UIPageControl* pageControl = [[UIPageControl alloc] init];
    [self addSubview:pageControl];
    
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    pageControl.currentPageIndicatorTintColor =  [@"FFA701" rgbColor];
    self.pageControl = pageControl;
    
    [self.collectionView registerClass:[SuffingCell class] forCellWithReuseIdentifier:ID];
    
    // addView
    UIImageView* placeholderView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ADLoop_placeholder"]];
    placeholderView.contentMode = UIViewContentModeRedraw;
    placeholderView.clipsToBounds = YES;
    [self addSubview:placeholderView];
    self.placeholderView = placeholderView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    [self setup_];
    
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [self setup_];
}

- (void)setAdvs:(NSArray *)advs {
    _advs = advs;
    
    self.collectionView.scrollEnabled = NO;
    // 总页数
    self.pageControl.numberOfPages = 0;
    
    NSInteger count = advs.count;
    if (count == 0) {
        [self removeTimer];
        
        self.collectionView.delegate = nil;
        self.collectionView.dataSource = nil;
        
        self.placeholderView.hidden = NO;
    } else if (count == 1) {
        [self removeTimer];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        
        self.placeholderView.hidden = YES;
        
        // 刷新数据
        [self.collectionView reloadData];
    } else {
        [self addTimer];
        
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        // 总页数
        self.pageControl.numberOfPages = count;
        
        // 刷新数据
        [self.collectionView reloadData];
        // 默认组
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:MCDefaultRow inSection:0];
        
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        
        self.placeholderView.hidden = YES;
        
        self.collectionView.scrollEnabled = YES;
        
        self.pageControl.currentPage = 0;
    }
    
    [self setNeedsLayout];
}

/**
 *  添加定时器
 */
- (void)addTimer
{
    // 先移除,再添加
    [self removeTimer];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

/**
 *  移除定时器
 */
- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
    
}

- (void)nextImage {
    
    NSIndexPath *visiablePath = [[self.collectionView indexPathsForVisibleItems] firstObject];
    
    NSUInteger visiableItem = visiablePath.item;
    if ((visiablePath.item % self.advs.count)  == 0) { // 第0张图片
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:MCDefaultRow inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        visiableItem = MCDefaultRow;
    }
    
    NSUInteger nextItem = visiableItem + 1;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:nextItem inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
}

#pragma mark - 数据源
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return MCTotalRowsInSection;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SuffingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.mode = self.advs[indexPath.item % self.advs.count];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItem:)]) {
        SuffingCell* cell = (SuffingCell*)[collectionView cellForItemAtIndexPath:indexPath];
        [self.delegate didSelectItem:cell.mode];
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *visiablePath = [[collectionView indexPathsForVisibleItems] firstObject];
    self.pageControl.currentPage = visiablePath.item % self.advs.count;
}

/** 开始拖拽的时候调用 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 停止定时器(一旦定时器停止了,就不能再使用)
    [self removeTimer];
}

/** 停止拖拽的时候调用 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    // 开启定时器
    [self addTimer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.collectionView.frame = self.bounds;
    
    self.layOut.itemSize = CGSizeMake(UI_SCREEN_WIDTH, self.height);
    
    self.placeholderView.frame = self.bounds;
    
    
    self.pageControl.width = 16.0*self.advs.count;
    self.pageControl.x = self.width-self.pageControl.width-15;
    self.pageControl.height = 25.0;
    self.pageControl.y = self.height-self.pageControl.height;
}

- (void)dealloc {
    [self removeTimer];
}

@end

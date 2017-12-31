//
//  HGSelectView.m
//  HGTabView
//
//  Created by  ZhuHong on 16/3/27.
//  Copyright © 2016年 HG. All rights reserved.
//

#import "HGSelectView.h"
#import "HGSelectCell.h"

static NSString* const ID = @"HGSelectCell";

@interface HGSelectView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) UIView* navView;
@property (nonatomic, weak) UILabel* titleLabel;
@property (nonatomic, weak) UIButton* foldBtn;

@property (nonatomic, weak) UICollectionView* collectionView;
@property (nonatomic, weak) UIButton* okBtn;

@end

@implementation HGSelectView

+ (instancetype)selectView {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    UIView* navView = [[UIView alloc] init];
    navView.backgroundColor = [UIColor whiteColor];
    [self addSubview:navView];
    self.navView = navView;
    
    UILabel* titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"请选择栏目";
    [navView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIButton* foldBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [foldBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [foldBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    
    foldBtn.backgroundColor = RGB(233, 233, 233);
    [foldBtn addTarget:self action:@selector(foldClock:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:foldBtn];
    self.foldBtn = foldBtn;
    
    // 创建collectionView
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(100, 40);
    layout.minimumInteritemSpacing = 10.0;
    layout.minimumLineSpacing = 5.0;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    UICollectionView* collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.contentInset = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
    collectionView.backgroundColor = RGB(233, 233, 233);
    
    [collectionView registerClass:[HGSelectCell class] forCellWithReuseIdentifier:ID];
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    
    
    UIButton* okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame = CGRectMake(0, 0, 200.0, 40.0);
    okBtn.backgroundColor = RGB(93, 145, 75);
    okBtn.clipsToBounds = YES;
    okBtn.layer.cornerRadius = 3.0;
    [okBtn setTitle:@"完成" forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(okClock:) forControlEvents:UIControlEventTouchUpInside];
    [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:okBtn];
    self.okBtn = okBtn;
    
    self.backgroundColor = RGB(240, 240, 240);
    
    return self;
}

- (void)okClock:(UIButton*)btn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectView:didSelectItem:)]) {
        [self.delegate selectView:self didSelectItem:@"完成"];
    }
}

- (void)foldClock:(UIButton*)btn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectView:didSelectItem:)]) {
        [self.delegate selectView:self didSelectItem:@"关闭"];
    }
}

- (void)setItems:(NSArray *)items {
    _items = items;
    [self.collectionView reloadData];
    
}

#pragma MARK - UICollectionViewDataSource, UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.items.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 获取:一定要先注册,否则闪退
    HGSelectCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    // 赋值
    cell.contenteStr = self.items[indexPath.item];
    
    // 返回
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HGSelectCell* cell = (HGSelectCell*)[collectionView cellForItemAtIndexPath:indexPath];
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectView:didSelectItem:)]) {
        [self.delegate selectView:self didSelectItem:cell.contenteStr];
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.navView.frame = self.bounds;
    self.navView.height = 50.0;
    self.titleLabel.frame = CGRectMake(20, 0, self.width-100.0, 50.0);
    self.foldBtn.frame = CGRectMake(self.width-80.0, 0, 80.0, 50);
    
    self.collectionView.frame = CGRectMake(0, 50.0, self.width, self.height-100.0);
    
    self.okBtn.frame = CGRectMake((self.width-self.okBtn.width)*0.5, self.height-50.0, self.okBtn.width, self.okBtn.height);
}

@end

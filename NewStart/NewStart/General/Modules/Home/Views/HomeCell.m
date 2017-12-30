//
//  HomeCell.m
//  NewStart
//
//  Created by  ZhuHong on 2017/12/30.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "HomeCell.h"
#import "HomeModel.h"
#import "HomeBottomView.h"
#import "UICollectionView+HG.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "HomeImageCell.h"

static NSString* const Cell_ID = @"HomeImageCell";

@interface HomeCell () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/** 标题 */
@property (nonatomic, weak) UILabel* titleLabel;
/** 仅有一张图片时的图片显示 */
@property (nonatomic, weak) UIImageView* loneImageView;
/** 用于显示多张图片的collectionView */
@property (nonatomic, weak) UICollectionView* collectionView;

/** 底部视图(评论数, 更多) */
@property (nonatomic, weak) HomeBottomView* bottomView;

@end

@implementation HomeCell

// 重写构造方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    // 添加所有的子视图
    // 标题
    UILabel* titleLabel = [[UILabel alloc] init];
    titleLabel.font = Font(TitleFontSize);
    titleLabel.numberOfLines = 2;
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    /** 仅有一张图片时的图片显示 */
    UIImageView* loneImageView = [[UIImageView alloc] init];
    loneImageView.clipsToBounds = YES;
    loneImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:loneImageView];
    self.loneImageView = loneImageView;
    
    /** 用于显示多张图片的collectionView */
    UICollectionView* collectionView = [UICollectionView cuCollectionView:^(UICollectionViewFlowLayout *layout) {
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }];
    collectionView.delegate = self;
    collectionView.dataSource = self;
//    collectionView.backgroundColor = [UIColor grayColor];
    
    [collectionView registerNib:[UINib nibWithNibName:Cell_ID bundle:nil] forCellWithReuseIdentifier:Cell_ID];
    
    [self.contentView addSubview:collectionView];
    self.collectionView = collectionView;
    
    /** 底部视图(评论数, 更多) */
    HomeBottomView* bottomView = [HomeBottomView view];
    [self.contentView addSubview:bottomView];
    self.bottomView = bottomView;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return self;
}

- (void)setHomeModel:(HomeModel *)homeModel {
    _homeModel = homeModel;
    
    self.titleLabel.text = homeModel.title;
    self.titleLabel.frame = homeModel.titleFrame;
    self.loneImageView.hidden = (homeModel.photos.count != 1);
    
    if (!self.loneImageView.hidden) {
        self.loneImageView.frame = homeModel.loneFrame;
        NSString* photoSTR = homeModel.photos.firstObject;
        [self.loneImageView sd_setImageWithURL:photoSTR.mj_url placeholderImage:[UIImage imageNamed:@"placeholderPNG"]];
        
        // 刷新一下, 即使要隐藏了,也应该刷新一下
        [self.collectionView reloadData];
        self.collectionView.hidden = YES;
    } else {
        self.collectionView.hidden = NO;
        self.collectionView.frame = homeModel.collectionFrame;
        // 刷新一下
        [self.collectionView reloadData];
    }
    
    self.collectionView.frame = homeModel.collectionFrame;
    
    self.bottomView.homeModel = homeModel;
    
    // 其实按照层级关系, 应该在这里设置其frame比较合适
//    self.bottomView.frame = homeModel.bottomFrame;
}

#pragma mark -
#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return (self.homeModel.photos.count < 2)?0:self.homeModel.photos.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.homeModel.photoWidth, collectionView.frame.size.height-0.5);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return MidMargin;
}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return MidMargin;
//}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeImageCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell_ID forIndexPath:indexPath];
    cell.photoSTR = self.homeModel.photos[indexPath.item];
    return cell;
}



@end

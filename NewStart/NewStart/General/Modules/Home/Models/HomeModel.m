//
//  HomeModel.m
//  NewStart
//
//  Created by  ZhuHong on 2017/12/30.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "HomeModel.h"
#import "NSString+SIZE.h"

// 中间的间距
CGFloat const MidMargin = 5.0;
/** 标题字体大小 */
CGFloat const TitleFontSize = 18.0;

// 两边的边距
static CGFloat const Margin = 15.0;
/** Cell的默认/最小的高度 */
static CGFloat const DefaultNoPhotoCellHeight = 89.0;
/** Cell的默认/最小的高度 */
static CGFloat const DefaultCellHeight = 90.0;
static CGFloat const PhotoScale = 94.0/132.0;
/** 底部视图的高 */
static CGFloat const BottomHeight = 30.0;



@interface HomeModel ()

/** cell 的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
/** 评论显示 */
@property (nonatomic, copy) NSString* commentsSTR;


@end

@implementation HomeModel

// 构造方法
- (instancetype)init {
    self = [super init];
    
    // 默认
    self.cellHeight = -1;
    
    return self;
}

// 通过数据计算cell的高度
- (CGFloat)cellHeight {
    if (_cellHeight == -1) {
        // 开始计算实际的cell高度
        
        // 标题的位置
        // 标题宽
        CGFloat titleWidht = UI_SCREEN_WIDTH - Margin*2;
        if (self.photos.count == 1) {
            titleWidht = UI_SCREEN_WIDTH - Margin*2 - DefaultCellHeight-MidMargin;
            _loneFrame = CGRectMake(UI_SCREEN_WIDTH-DefaultCellHeight-Margin, MidMargin, DefaultCellHeight, DefaultCellHeight- MidMargin*2.0);
        }
        
        // 标题高
        CGFloat titleHeight = [self.title heightWithWidth:titleWidht font:Font(TitleFontSize)];
        { // 目的就是 最大只能显示两行
            if (titleHeight > 30) {
                // 两行固定是49.0  故意弄点误差
                titleHeight = 49.0;
            } else {
                // 一行固定是25.0  故意弄点误差
                titleHeight = 25.0;
            }
        }
        _titleFrame = CGRectMake(Margin, MidMargin, titleWidht, titleHeight);
        
        
        if (self.photos.count == 0) {
            _cellHeight = DefaultNoPhotoCellHeight;
        } else if (self.photos.count == 1) {
            _cellHeight = DefaultCellHeight;
        } else {
            
            CGFloat photoWidht = -1;
            if (self.photos.count == 2) {
                photoWidht = (UI_SCREEN_WIDTH - 2*Margin - MidMargin)*0.5;
            } else {
                // 按照3张的宽度
                photoWidht = (UI_SCREEN_WIDTH - 2*Margin - 2*MidMargin)/3.0;
            }
            
            _photoWidth = photoWidht;
            
            CGFloat photoHeight = photoWidht*PhotoScale;
            
            _collectionFrame = CGRectMake(Margin, CGRectGetMaxY(_titleFrame)+MidMargin, UI_SCREEN_WIDTH-2*Margin, photoHeight);
            
            _cellHeight = MidMargin + titleHeight + MidMargin + photoHeight + BottomHeight;
        }
        
        // 底部视图的宽 就是标题的宽度
        _bottomFrame = CGRectMake(Margin, _cellHeight - BottomHeight, titleWidht, BottomHeight);
    }
    
    return _cellHeight;
}

- (NSString *)commentsSTR {
    if (!_commentsSTR) {
        _commentsSTR = HGStr(@"%zd万评", self.comments);
    }
    return _commentsSTR;
}

@end

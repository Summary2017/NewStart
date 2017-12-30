//
//  HomeModel.h
//  NewStart
//
//  Created by  ZhuHong on 2017/12/30.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "BaseModel.h"

// 中间的间距
UIKIT_EXTERN CGFloat const MidMargin;
/** 标题字体大小 */
UIKIT_EXTERN CGFloat const TitleFontSize;

@interface HomeModel : BaseModel

/** 标题 */
@property (nonatomic, copy) NSString* title;
/** 图片 */
@property (nonatomic, strong) NSArray* photos;
/** 评论数 */
@property (nonatomic, assign) NSInteger comments;
/** 链接 */
@property (nonatomic, copy) NSString* urlSTR;


#pragma mark -
#pragma mark - 与数据无关的的属性, 在实际的开发中, 只有是上面的数据才是网络获取的, 下面的属性一般都是辅助属性.还有一种做法是将一下的这一对属性都放在另一个附件Model中, 这样看起来会更加的统一.
/** cell 的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;
/** 标题 */
@property (nonatomic, assign, readonly) CGRect titleFrame;
/** 孤单的视图 */
@property (nonatomic, assign, readonly) CGRect loneFrame;

/** 底部视图 */
@property (nonatomic, assign, readonly) CGRect bottomFrame;

/** 多张图片时collectionview */
@property (nonatomic, assign, readonly) CGRect collectionFrame;
/** 多张图片的宽度 */
@property (nonatomic, assign, readonly) CGFloat photoWidth;

/** 评论显示 */
@property (nonatomic, copy, readonly) NSString* commentsSTR;


@end

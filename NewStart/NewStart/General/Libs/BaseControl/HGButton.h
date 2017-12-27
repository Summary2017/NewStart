//
//  HGButton.h
//  HGKitManager
//
//  Created by  ZhuHong on 2017/9/3.
//  Copyright © 2017年 EasyMoveMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HGButton : UIButton

/** 快速创建按钮 */
+ (instancetype)okaButton;

#pragma mark -
#pragma mark - 便捷设置title, image
@property (nonatomic, copy) NSString* okaTitle;
@property (nonatomic, copy) NSString* okaImage;

/** 快速的绑定事件 */
- (void)addTarget:(nullable id)target action:(nonnull SEL)sel;

@end

NS_ASSUME_NONNULL_END

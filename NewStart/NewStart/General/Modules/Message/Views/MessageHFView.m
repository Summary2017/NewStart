//
//  MessageHFView.m
//  NewStart
//
//  Created by  ZhuHong on 2017/12/29.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "MessageHFView.h"
#import "MessageGroupModel.h"

@interface MessageHFView ()

// 文本控件
@property (nonatomic, weak) UILabel* hgTextLabel;

@end

@implementation MessageHFView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];

//    self.textLabel.textAlignment = NSTextAlignmentCenter;
    UILabel* hgTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//    hgTextLabel.textAlignment = NSTextAlignmentCenter;
    hgTextLabel.font = Font(13.0);
    hgTextLabel.textColor = RGB(166, 166, 166);
    
    [self.contentView addSubview:hgTextLabel];
    self.hgTextLabel = hgTextLabel;
    

    return self;
}

- (void)setGroupModel:(MessageGroupModel *)groupModel {
    _groupModel = groupModel;
    self.hgTextLabel.text = groupModel.category;
}

// 布局子视图
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat margin = 15.0;
    self.hgTextLabel.frame = CGRectMake(margin, 0, CGRectGetWidth(self.frame)-margin*2.0, CGRectGetHeight(self.frame));
}

@end

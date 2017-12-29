//
//  CGSuffingCell.m
//  CargoManager
//
//  Created by  ZhuHong on 16/2/25.
//  Copyright © 2016年 BBDTEK. All rights reserved.
//

#import "SuffingCell.h"
#import "HomeADVModel.h"
#import <UIImageView+WebCache.h>
#import "UIView+HG.h"
#import "MJExtension.h"

@interface SuffingCell ()

@property (weak, nonatomic) UIImageView *suffingImageView;

@property (nonatomic, weak) UIView* tabView;
@property (nonatomic, weak) UILabel* tipsLabel;

@end

@implementation SuffingCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    UIImageView *suffingImageView = [[UIImageView alloc] init];
    suffingImageView.backgroundColor = [UIColor clearColor];
    suffingImageView.contentMode = UIViewContentModeScaleToFill;
    [self.contentView addSubview:suffingImageView];
    self.suffingImageView = suffingImageView;
    
    UIView* tabView = [[UIView alloc] init];
    //tabView.backgroundColor = rgba(0, 0, 0, 0.3);
    tabView.backgroundColor = [UIColor clearColor];
    UILabel* tipsLabel = [[UILabel alloc] init];
    tipsLabel.textAlignment = NSTextAlignmentLeft;
    tipsLabel.numberOfLines = 0;
    tipsLabel.textColor = [UIColor whiteColor];
    tipsLabel.font = [UIFont systemFontOfSize:13];
    
    //[tabView addSubview:tipsLabel];
    self.tipsLabel = tipsLabel;
    
    [self.contentView addSubview:tabView];
    self.tabView = tabView;

    return self;
}

- (void)setMode:(HomeADVModel *)mode {
    _mode = mode;
    
    [self.suffingImageView sd_setImageWithURL:mode.advImgUrls.mj_url placeholderImage:[UIImage imageNamed:@"ADLoop_placeholder"]];
    ;
    
//    self.tipsLabel.text = mode.title;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.suffingImageView.frame = self.contentView.bounds;
    self.tabView.frame = CGRectMake(0, self.height-25.0, self.width, 25.0);
    self.tipsLabel.frame = self.tabView.bounds;
    self.tipsLabel.x = 15;
    self.tipsLabel.width -= 15;
}

@end

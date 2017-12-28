//
//  HGButton.m
//  HGKitManager
//
//  Created by  ZhuHong on 2017/9/3.
//  Copyright © 2017年 EasyMoveMobile. All rights reserved.
//

#import "HGButton.h"

@implementation HGButton

+ (instancetype)okaButton {
    return [self buttonWithType:UIButtonTypeCustom];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.imageView.contentMode = UIViewContentModeCenter;
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    return self;
}

- (void)setOkaTitle:(NSString *)okaTitle {
    _okaTitle = [okaTitle copy];
    [self setTitle:okaTitle forState:UIControlStateNormal];
}

- (void)setOkaImage:(NSString *)okaImage {
    _okaImage = [okaImage copy];
    [self setImage:[UIImage imageNamed:okaImage] forState:UIControlStateNormal];
}

- (void)addTarget:(nullable id)target action:(nonnull SEL)sel {
    [self addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
}

@end

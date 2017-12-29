//
//  TabBar.m
//  NewStart
//
//  Created by  ZhuHong on 2017/12/27.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "TabBar.h"

@implementation TabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    // 是一张小图片(width小, height正好, 所以要在不影响中间部分的情况下,将width拉长.)
    UIImage* image_ = [UIImage imageNamed:@"tabbar_bg"];
    
    // image_的尺寸
    CGSize imageSize = image_.size;
    
    // 设置右边可拉伸的地方
    image_ = [image_ stretchableImageWithLeftCapWidth:imageSize.width*0.9 topCapHeight:imageSize.height*0.1];
    
    // 第一次拉伸宽度=最终宽度/2+原图宽度/2 主要拉伸右边
    CGFloat UI_SCREEN_WIDTH_OKA = [[UIScreen mainScreen] bounds].size.width;
    CGFloat tempWidth = UI_SCREEN_WIDTH_OKA/2 + imageSize.width/2;
    
    // 右边拉伸
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(tempWidth, imageSize.height), NO, [UIScreen mainScreen].scale);
    [image_ drawInRect:CGRectMake(0, 0, tempWidth, imageSize.height)];
    image_ = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // 设置左边可拉伸的地方
    image_ = [image_ stretchableImageWithLeftCapWidth:image_.size.width *0.1 topCapHeight:image_.size.height *0.1];
    
    UIImageView *outlineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -21, UI_SCREEN_WIDTH_OKA, imageSize.height)];
    [outlineView setImage:image_];
    [self insertSubview:outlineView atIndex:1];
    [self addSubview:outlineView];
    
    // 去除 tabbar 的边框
    CGRect rect = CGRectMake(0, 0, UI_SCREEN_WIDTH_OKA, 100);
    
    // 获取一个 clear 图片
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // 设置背景有影印
    [self setBackgroundImage:img];
    [self setShadowImage:img];
    
    self.backgroundColor = [UIColor whiteColor];
    
    return self;
}


/** 设置中间按钮并添加到视图 */
- (void)setCenterBtn:(UIButton *)centerBtn {
    // 去掉旧值
    if (_centerBtn && [_centerBtn superview]) {
        [_centerBtn removeFromSuperview];
    }
    
    // 新值
    _centerBtn = centerBtn;
    [self addSubview:_centerBtn];
    
    [self setNeedsLayout];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (!self.hidden) {
        if (CGRectContainsPoint(self.centerBtn.frame, point)) {
            return self.centerBtn;
        }
    }
    
    return [super hitTest:point withEvent:event];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    
    CGFloat btnx = 0;
    
    // 5.0是tabbar中的控件的数量
    CGFloat width = w/5.0;
    
    int i = 0;
    for (UIView *btn in self.subviews)
    {
        // 判断是否是系统自带的UITabBarButton类型的控件
        if ([btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (i == 2) {
                i = 3;
            }
            
            CGFloat btny = btn.frame.origin.y;
            CGFloat height = btn.frame.size.height;
            btnx = i*width;
            btn.frame = CGRectMake(btnx, btny, width, height);

            i++;
            
            h = btny + height*0.5;
        }
    }
    // 设置自定义button的位置
    self.centerBtn.center = CGPointMake(w*0.5, h - 8.0);
    

}

@end

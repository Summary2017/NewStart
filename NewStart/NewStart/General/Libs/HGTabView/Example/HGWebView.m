//
//  HGWebView.m
//  HGTabView
//
//  Created by  ZhuHong on 16/3/26.
//  Copyright © 2016年 HG. All rights reserved.
//

#import "HGWebView.h"

@interface HGWebView ()

@property (nonatomic, weak) UIWebView* webView;

@end

@implementation HGWebView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    UIWebView* webView = [[UIWebView alloc] init];
    [self addSubview:webView];
    self.webView = webView;
    
    return self;
}

- (void)setUrlStr:(NSString *)urlStr {
    _urlStr = [urlStr copy];
    
    NSURL* url = [NSURL URLWithString:_urlStr];
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.webView.frame = self.bounds;
}

@end

//
//  OrderController.m
//  NewStart
//
//  Created by  ZhuHong on 2017/12/27.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "OrderController.h"
#import "HGMainView.h"
#import "HGTabMode.h"
#import "HGContentMode.h"

// 用于例子展示
#import "HGWebView.h"
#import "HGTableTableViewController.h"

@interface OrderController () <HGMainViewDelegate, HGTableTableViewControllerDelegate>

@property (nonatomic, weak) HGMainView* tabView;
@property (nonatomic, strong) NSMutableArray* contentArrM;

@end

@implementation OrderController

#pragma mark -
#pragma mark - 懒加载
- (NSMutableArray *)contentArrM {
    if (!_contentArrM) {
        _contentArrM = [NSMutableArray array];
        
        NSArray* arr = @[@"UILabel实例", @"自定义的视图实例", @"自定义的控制器实例"];
        for (NSInteger i=0; i<arr.count; i++) {
            NSString* value = arr[i];
            HGTabMode* mode = [[HGTabMode alloc] init];
            mode.contentStr = value;
            [_contentArrM addObject:mode];
        }
    }
    return _contentArrM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 添加 HGMainView
    HGMainView* tabView = [HGMainView mainView];
    tabView.delegate = self;
    tabView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tabView];
    self.tabView = tabView;
}

#pragma mark - HGMainViewDelegate
// 这个代理方法类似于UITableView的(sectionIndexTitlesForTableView:)代理方法
- (NSArray *)tabMainView:(HGMainView *)view {
    return self.contentArrM;
}

// 这个代理方法类似于UITableView的(tableView:cellForRowAtIndexPath:)代理方法
- (HGContentMode*)mainView:(HGMainView *)view viewForPage:(NSInteger)page {
    if (page == 0) {
        return [self labelForPage:page];
    } else if (page == 1) {
        return [self webViewForPage:page];
    }
    return [self tableTableViewControllerForPage:page];
}


#pragma mark - HGTableTableViewController
- (HGContentMode*)tableTableViewControllerForPage:(NSInteger)page {
    HGContentMode* mode = [[HGContentMode alloc] init];
    mode.hgCls = HGTableTableViewController.class;
    
    // 回调
    mode.hgBlock = ^(HGTableTableViewController* hgVC) {
        // 用于刷新数据用的.
        hgVC.delegate = self;
    };
    
    return mode;
}

#pragma mark - HGTableTableViewControllerDelegate
- (void)didSelectItem:(NSString *)text {
    DLog(@"你点击了:%@", text);
}

#pragma mark - HGWebView
- (HGContentMode*)webViewForPage:(NSInteger)page {
    HGContentMode* mode = [[HGContentMode alloc] init];
    mode.hgCls = HGWebView.class;
    mode.hgBlock = ^(HGWebView* webView) {
        webView.urlStr = @"https://www.jianshu.com/p/c0e611fc0548";
    };
    
    return mode;
}

#pragma mark - UILabel
- (HGContentMode*)labelForPage:(NSInteger)page {
    HGContentMode* mode = [[HGContentMode alloc] init];
    mode.hgCls = UILabel.class;
    mode.hgBlock = ^(UILabel* label) {
//        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"这里是直接用的系统的UILabel";
    };
    
    return mode;
}

// 布局控制器中的子视图
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // 这里的值,不再是64的固定值了
    CGFloat y = UI_STATUS_BAR_HEIGHT + self.navigationController.navigationBar.height;
    // 这里的也不是当年的四九了
    CGFloat tabHeight = self.tabBarController.tabBar.height;
    
    self.tabView.frame = CGRectMake(0, y, self.view.width, self.view.height-y-tabHeight);
}

@end

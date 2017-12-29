//
//  HomeController.m
//  NewStart
//
//  Created by  ZhuHong on 2017/12/27.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "HomeController.h"
#import "SuffingView.h"
#import "UIView+HG.h"
#import "HomeADVModel.h"

@interface HomeController ()

// 轮魔图
@property (nonatomic, weak) SuffingView* suffingView;

// 数据
@property (nonatomic, strong) NSArray* advs;

@end

@implementation HomeController

#pragma mark -
#pragma mark - 懒加载
- (NSArray *)advs {
    if (!_advs)
    {
        HomeADVModel* adModel00 = [[HomeADVModel alloc] init];
        adModel00.advImgUrls = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1514554638123&di=ef9a087f55c8a238b499a993c20ea833&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F0136fc57368a206ac72580ede05ece.jpg%402o.jpg";
        
        HomeADVModel* adModel01 = [[HomeADVModel alloc] init];
        adModel01.advImgUrls = @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1432703053,3148562735&fm=27&gp=0.jpg";
        
        HomeADVModel* adModel02 = [[HomeADVModel alloc] init];
        adModel02.advImgUrls = @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1510023760,390708238&fm=27&gp=0.jpg";
        
        HomeADVModel* adModel03 = [[HomeADVModel alloc] init];
        adModel03.advImgUrls = @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=11544844,2526050266&fm=27&gp=0.jpg";
        
        HomeADVModel* adModel04 = [[HomeADVModel alloc] init];
        adModel04.advImgUrls = @"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2504736640,1923955847&fm=27&gp=0.jpg";
        
        _advs = @[adModel00, adModel01, adModel02, adModel03, adModel04];
    }
    return _advs;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SuffingView* suffingView = [[SuffingView alloc] init];
    suffingView.size = CGSizeMake(self.view.width, 410.0 / 750 * UI_SCREEN_WIDTH);
    suffingView.advs = self.advs;
    suffingView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.tableView.tableHeaderView = suffingView;
    self.suffingView = suffingView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

@end

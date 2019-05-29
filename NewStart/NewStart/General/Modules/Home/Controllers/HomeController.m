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
#import "BaseButton.h"
#import "MoreController.h"
#import "HomeCell.h"
#import "HomeModel.h"
#import "MJExtension.h"
#import "NewStart-Swift.h"

@interface HomeController ()

// 轮魔图
@property (nonatomic, weak) SuffingView* suffingView;

// 数据
@property (nonatomic, strong) NSArray* advs;

// 数据列表
@property (nonatomic, strong) NSArray* datas;

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
    // tableView的样子
    self.tableViewStyle = UITableViewStyleGrouped;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SuffingView* suffingView = [[SuffingView alloc] init];
    suffingView.size = CGSizeMake(self.view.width, 410.0 / 750 * UI_SCREEN_WIDTH);
    suffingView.advs = self.advs;
    suffingView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.tableView.tableHeaderView = suffingView;
    self.suffingView = suffingView;
    
    // 更多
    BaseButton* moreBUtton = [BaseButton okaButton];
    moreBUtton.okaImage = @"more";
    [moreBUtton sizeToFit];
    [moreBUtton addTarget:self action:@selector(moreAction)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:moreBUtton];
    
    self.datas = [HomeModel mj_objectArrayWithFilename:@"HomeData.plist"];
    
    DLog(@"%@", self.datas)
}

#pragma mark -
#pragma mark - 事件
- (void)moreAction {
    UINavigationController* moreNavVC = [MoreController navFromMoreVC];
    [self presentViewController:moreNavVC animated:YES completion:NULL];
}

#pragma mark -
#pragma mark - UITableView的相关delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 18.;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeModel* homeModel = self.datas[indexPath.row];
    return homeModel.cellHeight;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 获取cell
    HomeCell* cell = [HomeCell cell:tableView];
    // 赋值
    cell.homeModel = self.datas[indexPath.row];
    // 返回
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 获取cell
    HomeCell* cell = (HomeCell*)[tableView cellForRowAtIndexPath:indexPath];
    HomeModel* homeModel = cell.homeModel;
    
    BrowserController* browerVC = [[BrowserController alloc] init];
    browerVC.title =  homeModel.title;
    // 有点绕, 哈哈哈
    // browerVC.urlSTR = homeModel.urlSTR.mj_url.absoluteString;
    [self.navigationController pushViewController:browerVC animated:YES];
}

@end

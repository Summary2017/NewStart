//
//  MessageController.m
//  NewStart
//
//  Created by  ZhuHong on 2017/12/27.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "MessageController.h"
#import "MessageGroupModel.h"
#import "MessageModel.h"
#import "MessageHFView.h"
#import "MessageCell.h"
#import "NewStart-Swift.h"

@interface MessageController ()

/** 数据 */
@property (nonatomic, strong) NSMutableArray* datas;

@end

@implementation MessageController

#pragma mark -
#pragma mark - 懒加载
- (NSMutableArray *)datas {
    if (!_datas) {
        
        // 特别推荐
        MessageGroupModel* specialGroupModel = [MessageGroupModel model];
        specialGroupModel.category = @"特别推荐";
        {
            // 项目的搭建到分发
            MessageModel* msgModel = [MessageModel modelWithTitle:@"iOS项目的搭建到分发       🔥 🔥 🔥" urlID:@"e8825f796890"];
            [specialGroupModel.messages addObject:msgModel];
        }
        
        // 推荐
        MessageGroupModel* groupModel = [MessageGroupModel model];
        groupModel.category = @"推荐";
        {
            // PHAsset
            MessageModel* phAssetModel = [MessageModel modelWithTitle:@"通过 PHAsset 获取图片遇到的坑" urlID:@"b346245d9766"];
            [groupModel.messages addObject:phAssetModel];
            
            // 布局
            MessageModel* layoutModel = [MessageModel modelWithTitle:@"iOS开发中的布局" urlID:@"41533fd87081"];
            [groupModel.messages addObject:layoutModel];
            
            // 时区与时间戳
            MessageModel* timeModel = [MessageModel modelWithTitle:@"三句话理解时区与时间戳" urlID:@"bf47458a0423"];
            [groupModel.messages addObject:timeModel];
            
            // 断言
            MessageModel* assertModel = [MessageModel modelWithTitle:@"iOS断言的学习" urlID:@"a8dae13c3ae7"];
            [groupModel.messages addObject:assertModel];
            
            
            // UITabBarController
            MessageModel* tabModel = [MessageModel modelWithTitle:@"UITabBarController 的特别之处" urlID:@"5f588301242a"];
            [groupModel.messages addObject:tabModel];
            
            // load 与 initialize
            MessageModel* lAndIModel = [MessageModel modelWithTitle:@"OC 中的 load 与 initialize 方法" urlID:@"548fef33fb40"];
            [groupModel.messages addObject:lAndIModel];
            
            // 编辑框
            MessageModel* signatureModel = [MessageModel modelWithTitle:@"个性签名编辑框的简单实现" urlID:@"b47990016c5a"];
            [groupModel.messages addObject:signatureModel];
            
            // 静态库制作
            MessageModel* libModel = [MessageModel modelWithTitle:@"iOS 静态库制作❣基础篇" urlID:@"34b660a4a892"];
            [groupModel.messages addObject:libModel];
            
            // 控制器命名
            MessageModel* vcNameModel = [MessageModel modelWithTitle:@"iOS控制器命名哲学" urlID:@"9715872c3423"];
            [groupModel.messages addObject:vcNameModel];
            
            // CocoaPods库
            MessageModel* cocoaPodsModel = [MessageModel modelWithTitle:@"CocoaPods库的制作" urlID:@"cf157b4a93fd"];
            [groupModel.messages addObject:cocoaPodsModel];
            
            // 宏定义与常量
            MessageModel* constModel = [MessageModel modelWithTitle:@"宏定义与常量的基本用法" urlID:@"5d676c4405fa"];
            [groupModel.messages addObject:constModel];
        }
        
        // 创建
        _datas =[NSMutableArray array];
        [_datas addObject:specialGroupModel];
        [_datas addObject:groupModel];
        
    }
    return _datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView* tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 15.0)];
    self.tableView.tableFooterView = tableFooterView;
}

#pragma mark -
#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    MessageGroupModel* groupModel = self.datas[section];
    return groupModel.messages.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 26.0;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MessageHFView* headerView = [MessageHFView hfView:tableView];
    headerView.groupModel = self.datas[section];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0000001;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 获取 cell
    MessageCell* cell = [MessageCell cell:tableView];
    
    // 赋值
    MessageGroupModel* groupModel = self.datas[indexPath.section];
    MessageModel* msgModel = groupModel.messages[indexPath.row];
    cell.msgModel = msgModel;
    
    // 返回
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 获取当前点击的cell
    MessageCell* cell = (MessageCell*)[tableView cellForRowAtIndexPath:indexPath];
    MessageModel* msgModel = cell.msgModel;
    
    BrowserController* browerVC = [[BrowserController alloc] init];
    browerVC.title =  msgModel.title;
    browerVC.urlSTR = HGStr(@"https://www.jianshu.com/p/%@", msgModel.url_id);
    [self.navigationController pushViewController:browerVC animated:YES];
}

@end

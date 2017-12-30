//
//  BaseTBController.m
//  NewStart
//
//  Created by  ZhuHong on 2017/12/27.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "BaseTBController.h"
#import "BaseCell.h"

@interface BaseTBController ()

@property (nonatomic, weak) UITableView* tableView;

@end

@implementation BaseTBController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        self.tableViewStyle = UITableViewStylePlain;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加UITableView
    [self setupTBView];
}

// 添加UITableView
- (void)setupTBView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:self.tableViewStyle];
    tableView.dataSource = self;
    tableView.delegate = self;
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 247
    tableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:246/255.0 alpha:1];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    // 迎合iOS 11的适配
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;

    // 不要让底部贴得太近
//    UIView* footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 15.0)];
//    tableView.tableFooterView = footerView;
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

#pragma mark -
#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return tableView.frame.size.height - tableView.contentInset.top - tableView.contentInset.bottom;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseCell* cell = [BaseCell cell:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = HGStr(@"%@\n\n暂无数据", NSStringFromClass(self.class));

    return cell;
}



@end

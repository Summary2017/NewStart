//
//  PersonInforController.m
//  NewStart
//
//  Created by  ZhuHong on 2017/12/29.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "PersonInforController.h"

@interface PersonInforController ()

@end

@implementation PersonInforController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark -
#pragma mark - UITableViewDataSource, UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

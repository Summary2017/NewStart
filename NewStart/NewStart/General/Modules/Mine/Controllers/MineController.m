//
//  MineController.m
//  NewStart
//
//  Created by  ZhuHong on 2017/12/27.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "MineController.h"

@interface MineController ()

@property (weak, nonatomic) IBOutlet UIImageView *headPortraitView;

@end

@implementation MineController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView* tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 15.0)];
    self.tableView.tableFooterView = tableFooterView;
    
    self.headPortraitView.layer.cornerRadius = 3.0;
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

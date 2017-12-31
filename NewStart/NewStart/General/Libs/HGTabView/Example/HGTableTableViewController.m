//
//  HGTableTableViewController.m
//  HGTabView
//
//  Created by  ZhuHong on 16/3/26.
//  Copyright © 2016年 HG. All rights reserved.
//

#import "HGTableTableViewController.h"

@interface HGTableTableViewController ()

@end

@implementation HGTableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 8;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* const ID = @"id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = HGStr(@"第%ld个section, 第%ld个row", indexPath.section, indexPath.row);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItem:)]) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [self.delegate didSelectItem:cell.textLabel.text];
    }
}

@end

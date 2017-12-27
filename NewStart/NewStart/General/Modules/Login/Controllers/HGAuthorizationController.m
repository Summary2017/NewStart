//
//  HGAuthorizationController.m
//  CoderHG
//
//  Created by  ZhuHong on 2016/11/12.
//  Copyright © 2016年 CoderHG. All rights reserved.
//

#import "HGAuthorizationController.h"

@interface HGAuthorizationController ()

@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;

@end

@implementation HGAuthorizationController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"APP说明";
    
    self.tipsLabel.text = @"本APP仅为娱乐APP,没有什么主要功能.\n\n...\n\n还在优化,以及完善中.\n\n...\n\n使用本APP带来任何影响,与本APP无关.";
}

@end

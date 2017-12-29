//
//  SignatureController.m
//  NewStart
//
//  Created by  ZhuHong on 2017/12/29.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "SignatureController.h"
#import "SetupSignatureCell.h"

@interface SignatureController () <SetupSignatureCellDelegate>

@property (nonatomic, copy) NSString* signatureTEXT;

@end

@implementation SignatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 默认的签名
//    self.signatureTEXT = @"生活需要发现";
}

#pragma mark -
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SetupSignatureCell* cell = [SetupSignatureCell cell:tableView];

    cell.delegate = self;
    cell.signatureTEXT = self.signatureTEXT;

    return cell;
}

#pragma mark -
#pragma mark - SetupSignatureCellDelegate
- (void)setupSignatureCell:(SetupSignatureCell *)cell didChangedValue:(NSString *)value {
    NSLog(@"你输入的个性签名是: %@", value);
}

@end

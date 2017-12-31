//
//  HGLoginController.m
//  CoderHG
//
//  Created by  ZhuHong on 2016/11/12.
//  Copyright © 2016年 CoderHG. All rights reserved.
//

#import "HGLoginController.h"
#import "IQKeyboardReturnKeyHandler.h"
#import "HGLoginViewMode.h"
#import "AppDelegate.h"
#import "TabBarController.h"
#import "HGAuthorizationController.h"
#import "TGRImageViewController.h"
#import "TGRImageZoomAnimationController.h"
#import "UITextField+HG.h"
#import "NSString+HG.h"

@interface HGLoginController () <UITextFieldDelegate, UIViewControllerTransitioningDelegate>

// 头像
@property (weak, nonatomic) IBOutlet UIButton *avatarButton;

// 用户名
@property (weak, nonatomic) IBOutlet UITextField *userNameTextFiled;
// 密码
@property (weak, nonatomic) IBOutlet UITextField *psTextFiled;

// 登录按钮
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *authorizationButton;

// 键盘
@property (nonatomic, strong) IQKeyboardReturnKeyHandler *returnKeyHandler;

// VM
@property (nonatomic, strong) HGLoginViewMode* loginViewMode;

// 一个必须要有的中间变量
@property (nonatomic, copy) NSString* accountSTR;

@end

@implementation HGLoginController

#pragma mark - 懒加载
- (HGLoginViewMode *)loginViewMode {
    if (!_loginViewMode) {
        _loginViewMode = [[HGLoginViewMode alloc] init];
    }
    return _loginViewMode;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.avatarButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.avatarButton.layer.borderWidth = 2.0f;
    self.avatarButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    // 键盘
//    IQKeyboardReturnKeyHandler* returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
//    returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyGo;
//    self.returnKeyHandler = returnKeyHandler;
    
    
    // 绑定
    [self bindVM];
}

// 绑定信号
- (void)bindVM {
    // 输入的数据
    RAC(self.loginViewMode.accountMode, username) = self.userNameTextFiled.rac_textSignal;
    RAC(self.loginViewMode.accountMode, password) = self.psTextFiled.rac_textSignal;
    
    
    // Go
    
    
    // 绑定登录按钮
    RAC(self.loginButton, enabled) = self.loginViewMode.enableSignal;
    
    // 监听登录按钮的点击
    @weakify(self)
    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        
        [self.view endEditing:YES];
        
        // 加载框显示
        [Public showLoadingView];
        
        // 执行登录事件
        [self.loginViewMode.loginCommand execute:@"执行了登录事件"];
        
        
    }];
    
    [RACObserve(self.loginViewMode, loginResultSTR) subscribeNext:^(id x) {
        if (!x) {
            DLog(@"开始登录...");
            return ;
        }
        
        // 加载框隐藏
        [Public hideLoadingView];
        
        DLog(@" 登录结果 = %@", x);
        if ([x isEqualToString:@"登录成功"]) {
            AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
            appDelegate.window.rootViewController = [[TabBarController alloc] init];
        }
    }];
    
//    [[self rac_signalForSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:) fromProtocol:@protocol(UITextFieldDelegate)] subscribeNext:^(RACTuple *tuple) {
//        @strongify(self)
//
//        // 多参数
//        if (tuple.first == self.userNameTextFiled) {
//            DLog(@"userNameTextFiled")
//        } else {
//            DLog(@"psTextFiled")
//        }
//
////        id second = tuple.second;
////
////        DLog(@"second = %@", second)
////        id third = tuple.third;
////        DLog(@"third = %@", third)
////        id fourth = tuple.fourth;
////        DLog(@"fourth = %@", fourth)
//
//    }];
    
    
    [[self rac_signalForSelector:@selector(textFieldShouldReturn:) fromProtocol:@protocol(UITextFieldDelegate)] subscribeNext:^(RACTuple *tuple) {
        @strongify(self)
        if (tuple.first == self.userNameTextFiled) {
            [self.psTextFiled becomeFirstResponder];
        } else {
            
            [self.psTextFiled resignFirstResponder];
            
            if ([self.psTextFiled.text passwpordRegex] && [self.userNameTextFiled.text userNameRegex]) {
                [Public showLoadingView];
                // 执行登录事件
                [self.loginViewMode.loginCommand execute:@"执行了登录事件"];
            }
        }
    }];

    [[self.authorizationButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        HGAuthorizationController* authorizationVC = [[HGAuthorizationController alloc] init];
        [self.navigationController pushViewController:authorizationVC animated:YES];
    }];
    
    
    // 头像
    [[self.avatarButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        HGSharedAppDelegate.window.backgroundColor = [UIColor blackColor];
        TGRImageViewController *viewController = [[TGRImageViewController alloc] initWithImage:[self.avatarButton imageForState:UIControlStateNormal]];
        
        viewController.view.frame = [UIScreen mainScreen].bounds;
        viewController.transitioningDelegate = self;
        
        [self presentViewController:viewController animated:YES completion:NULL];
    }];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // 删除直接YES
    if ([string isEqualToString:@""]) {
        return YES;
    }

    // 高亮状态直接YES
    if (textField.hg_isHighLighted) {
        return YES;
    }

    NSString* resultSTR = [textField.text stringByReplacingCharactersInRange:range withString:string];

    DLog(@"即将要输入的 %@", resultSTR);

    // 用户名
    if (textField == self.userNameTextFiled) {
        if (resultSTR.length > 20) {
            return NO;
        }
        
        return [string userNameRegex];
    }
    
    // 密码验证
    return [resultSTR passwpordInputRegex];
}

- (IBAction)didChangedTextWithTextFiled:(UITextField *)textField {
    // 高亮状态不处理
    if (textField.hg_isHighLighted) {
        return;
    }
    
    if (textField == self.userNameTextFiled) {
        if (![textField.text userNameRegex]) {
            [textField invalidTextFieldCurContent:self.accountSTR];
        } else {
            self.accountSTR = textField.text;
        }
    }
}


#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    if ([presented isKindOfClass:TGRImageViewController.class]) {
        return [[TGRImageZoomAnimationController alloc] initWithReferenceImageView:self.avatarButton.imageView];
    }
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    if ([dismissed isKindOfClass:TGRImageViewController.class]) {
        return [[TGRImageZoomAnimationController alloc] initWithReferenceImageView:self.avatarButton.imageView];
    }
    return nil;
}

@end

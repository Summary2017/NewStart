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
            NSLog(@"开始登录...");
            return ;
        }
        
        // 加载框隐藏
        [Public hideLoadingView];
        
        NSLog(@" 登录结果 = %@", x);
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
            // 执行登录事件
            [self.loginViewMode.loginCommand execute:@"这里有BUG,执行了登录事件"];
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
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    
//    if (textField == self.userNameTextFiled) {
//        [self.psTextFiled becomeFirstResponder];
//        
//        return NO;
//    }
//    
//    return YES;
//}


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

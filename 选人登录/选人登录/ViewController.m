//
//  ViewController.m
//  选人登录
//
//  Created by EPIC_IOS on 2017/12/25.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "ViewController.h"

#define selfwith [UIScreen mainScreen].bounds.size.width
#define selfheight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

{
    UIView *myView;
    UITextField *accountTF ;
    UITextField *passwordTF;
    UIButton *loginBtn;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录成功";
    self.view.backgroundColor = [UIColor greenColor];
//    [self setupUI];
    
}

#pragma mark -- setup UI
- (void) setupUI
{
    myView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    myView.backgroundColor = [UIColor colorWithRed:97/255.0 green:196/255.0 blue:249/255.0 alpha:1.f];
    [self.view addSubview:myView];
    
    /* < account > */
    [self setupWithAccount];
    /* < password > */
    [self setupWithPassword];
    /* < login > */
    [self setupWithLogin];
}

#pragma mark -- account
- (void) setupWithAccount
{
    accountTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, selfwith * 0.8,50)];
    accountTF.center = CGPointMake(selfwith / 2, selfheight / 2 - 60);
    accountTF.backgroundColor = [UIColor whiteColor];
    accountTF.placeholder = @"请输入账号:";
    accountTF.textAlignment = NSTextAlignmentCenter;
    [myView addSubview:accountTF];
}
#pragma mark -- password
- (void) setupWithPassword
{
    passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, accountTF.frame.size.width,accountTF.frame.size.height)];
    passwordTF.center = CGPointMake(accountTF.center.x, accountTF.center.y + 35);
    passwordTF.backgroundColor = accountTF.backgroundColor;
    passwordTF.placeholder = @"请输入密码:";
    passwordTF.textAlignment = NSTextAlignmentCenter;
    [myView addSubview:passwordTF];
}
#pragma mark -- login
- (void) setupWithLogin
{
    loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, accountTF.frame.size.width, 45)];
    loginBtn.center  = CGPointMake(passwordTF.center.x, passwordTF.center.y + 60);
    loginBtn.backgroundColor = [UIColor whiteColor];
//    loginBtn
    [loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginClicked:) forControlEvents:UIControlEventTouchUpInside];
    [myView addSubview:loginBtn];
}

#pragma mark -- actions
- (void) loginClicked: (id) sender
{
    NSLog(@"登录成功");
}

@end

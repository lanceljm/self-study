//
//  AppDelegate.m
//  选人登录
//
//  Created by EPIC_IOS on 2017/12/25.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

#define selfwith [UIScreen mainScreen].bounds.size.width
#define selfheight [UIScreen mainScreen].bounds.size.height


@interface AppDelegate ()
{
    UIView *myView;
    UITextField *accountTF ;
    UITextField *passwordTF;
    UIButton *loginBtn;
    UIButton *selectBtn;
    BOOL is_selected;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    [_window makeKeyAndVisible];
    
    [self setupUI];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -- setup UI
- (void) setupUI
{
    myView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    myView.backgroundColor = [UIColor colorWithRed:97/255.0 green:196/255.0 blue:249/255.0 alpha:1.f];
    [[UIApplication sharedApplication].keyWindow addSubview:myView];
    
    /* < account > */
    [self setupWithAccount];
    /* < password > */
    [self setupWithPassword];
    /* < login > */
    [self setupWithLogin];

    
    is_selected = NO;
    /* < selected > */
    [self setupWithSelectBtn];
}

#pragma mark -- account
- (void) setupWithAccount
{
    accountTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, selfwith * 0.7,50)];
    accountTF.center = CGPointMake(selfwith / 2 - 15, selfheight / 2 - 60);
    accountTF.backgroundColor = [UIColor whiteColor];
    accountTF.placeholder = @"请输入账号:";
    accountTF.textAlignment = NSTextAlignmentCenter;
    [myView addSubview:accountTF];
}
#pragma mark -- password
- (void) setupWithPassword
{
    passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(accountTF.frame), CGRectGetMaxY(accountTF.frame) + 10, selfwith * 0.8,accountTF.frame.size.height)];
    passwordTF.backgroundColor = accountTF.backgroundColor;
    passwordTF.placeholder = @"请输入密码:";
    passwordTF.textAlignment = NSTextAlignmentCenter;
    [myView addSubview:passwordTF];
}
#pragma mark -- login
- (void) setupWithLogin
{
    loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, accountTF.frame.size.width, 45)];
    loginBtn.center  = CGPointMake(passwordTF.center.x, passwordTF.center.y + 100);
    loginBtn.backgroundColor = [UIColor whiteColor];
    //    loginBtn
    [loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginClicked:) forControlEvents:UIControlEventTouchUpInside];
    [myView addSubview:loginBtn];
}
- (void) setupWithSelectBtn
{
    selectBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(accountTF.frame), accountTF.frame.origin.y, accountTF.frame.size.height, accountTF.frame.size.height)];
    selectBtn.backgroundColor = [UIColor lightGrayColor];
    if (is_selected) {
        [selectBtn setImage:[UIImage imageNamed:@"triangle1"] forState:UIControlStateNormal];
    }else
    {
        [selectBtn setImage:[UIImage imageNamed:@"triangle"] forState:UIControlStateNormal];
    }
    [selectBtn addTarget:self action:@selector(selectWithAccount:) forControlEvents:UIControlEventTouchUpInside];
    [myView addSubview: selectBtn];
}


#pragma mark -- actions
- (void) loginClicked: (id) sender
{
    [UIView animateWithDuration:2.0f animations:^{
        [myView removeFromSuperview];
    }];
    NSLog(@"登录成功");
}

- (void) selectWithAccount : (id) sender
{
    is_selected = !is_selected;

    if (is_selected) {
        [selectBtn setImage:[UIImage imageNamed:@"triangle1"] forState:UIControlStateNormal];
    }else
    {
        [selectBtn setImage:[UIImage imageNamed:@"triangle"] forState:UIControlStateNormal];
    }
}

@end

//
//  AppDelegate.m
//  选人登录
//
//  Created by EPIC_IOS on 2017/12/25.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

#define selfWidth [UIScreen mainScreen].bounds.size.width
#define selfHeight [UIScreen mainScreen].bounds.size.height


@interface AppDelegate ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *myView;
    UITextField *accountTF ;
    UITextField *passwordTF;
    UIButton *loginBtn;
    UIButton *selectBtn;
    BOOL is_selected;
    BOOL is_selectedPassword;
    UIButton *selectPasswordBtn;
    UITableView *accountTB;
    UITableView *passwordTB;
    NSArray *accountArr;
    NSArray *passwordArr;
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
    myView.backgroundColor = [UIColor colorWithRed:49/255.0 green:122/255.0 blue:211/255.0 alpha:1.f];
    [[UIApplication sharedApplication].keyWindow addSubview:myView];
    
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 60)];
    nameLab.center = CGPointMake(selfWidth / 2, 100);
    nameLab.backgroundColor = [UIColor clearColor];
    nameLab.text = @"云网邮箱";
    nameLab.textColor = [UIColor whiteColor];
    nameLab.textAlignment = NSTextAlignmentCenter;
    nameLab.font = [UIFont systemFontOfSize:35];
    [myView addSubview:nameLab];
    
    UILabel *companyLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    companyLab.center = CGPointMake(selfWidth / 2, selfHeight - 50);
    companyLab.backgroundColor = [UIColor clearColor];
    companyLab.text = @"云南远信科技有限公司";
    companyLab.textColor = [UIColor lightGrayColor];
    companyLab.textAlignment = NSTextAlignmentCenter;
    companyLab.font = [UIFont systemFontOfSize:15];
    [myView addSubview:companyLab];
    
    /* < account > */
    [self setupWithAccount];
    /* < password > */
    [self setupWithPassword];
    /* < login > */
    [self setupWithLogin];
    
    
    is_selected = NO;
    is_selectedPassword = NO;
    /* < selected > */
    [self setupWithSelectBtn];
    [self setupWithSelectPassword];
}

#pragma mark -- account
- (void) setupWithAccount
{
    accountTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, selfWidth * 0.7,50)];
    accountTF.center = CGPointMake(selfWidth / 2 - 15, selfHeight / 2 - 60);
    accountTF.backgroundColor = [UIColor whiteColor];
    accountTF.placeholder = @"请输入账号:";
    accountTF.textAlignment = NSTextAlignmentCenter;
    [myView addSubview:accountTF];
}
#pragma mark -- password
- (void) setupWithPassword
{
    passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(accountTF.frame), CGRectGetMaxY(accountTF.frame) + 10, accountTF.frame.size.width,accountTF.frame.size.height)];
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
    
    accountTB = [[UITableView alloc] init];
    accountTB.backgroundColor = [UIColor whiteColor];
    accountTB.delegate = self;
    accountTB.dataSource = self;
    [myView addSubview:accountTB];
    
    selectBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(accountTF.frame), accountTF.frame.origin.y, accountTF.frame.size.height, accountTF.frame.size.height)];
    selectBtn.backgroundColor = [UIColor lightGrayColor];
    if (is_selected) {
        [selectBtn setImage:[UIImage imageNamed:@"triangle1"] forState:UIControlStateNormal];
        accountTB.frame = CGRectMake(accountTF.frame.origin.x, CGRectGetMaxY(accountTF.frame), accountTF.frame.size.width, accountTF.frame.size.height * 8);
    }else
    {
        [selectBtn setImage:[UIImage imageNamed:@"triangle"] forState:UIControlStateNormal];
        accountTB.frame = CGRectMake(accountTF.frame.origin.x, CGRectGetMaxY(accountTF.frame), accountTF.frame.size.width, 0);
    }
    [selectBtn addTarget:self action:@selector(selectWithAccount:) forControlEvents:UIControlEventTouchUpInside];
    [myView addSubview: selectBtn];
    
    
    accountArr = @[@"coremail_1@im.yn.csg",
                   @"coremail_2@im.yn.csg",
                   @"coremail_3@im.yn.csg",
                   @"coremail_4@im.yn.csg",
                   @"coremail_5@im.yn.csg",
                   @"coremail_6@im.yn.csg",
                   @"wangqinpeng_ynyxkjyxgs@im.yn.csg",
                   @"chenyunchuan003@im.yn.csg"];
    
}

- (void) setupWithSelectPassword
{
    passwordTB = [[UITableView alloc] init];
    passwordTB.backgroundColor = [UIColor whiteColor];
    passwordTB.delegate = self;
    passwordTB.dataSource = self;
    [myView addSubview:passwordTB];
    
    selectPasswordBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(passwordTF.frame), passwordTF.frame.origin.y, passwordTF.frame.size.height, passwordTF.frame.size.height)];
    selectPasswordBtn.backgroundColor = [UIColor lightGrayColor];
    if (is_selected) {
        [selectPasswordBtn setImage:[UIImage imageNamed:@"triangle1"] forState:UIControlStateNormal];
        passwordTB.frame = CGRectMake(passwordTF.frame.origin.x, CGRectGetMaxY(passwordTF.frame), passwordTF.frame.size.width, passwordTF.frame.size.height * 2);
    }else
    {
        [selectPasswordBtn setImage:[UIImage imageNamed:@"triangle"] forState:UIControlStateNormal];
        passwordTB.frame = CGRectMake(passwordTF.frame.origin.x, CGRectGetMaxY(passwordTF.frame), passwordTF.frame.size.width, 0);
    }
    [selectPasswordBtn addTarget:self action:@selector(selectWithPassword:) forControlEvents:UIControlEventTouchUpInside];
    [myView addSubview: selectPasswordBtn];
    
    
    passwordArr = @[@"aaa@123",
                    @"password"];
}


#pragma mark -- actions
- (void) loginClicked: (id) sender
{
    if (passwordTF.text != nil && ![passwordTF.text isEqualToString:@""] && accountTF.text != nil && ![accountTF.text isEqualToString:@""]) {
        
        [[NSUserDefaults standardUserDefaults] setValue:accountTF.text forKeyPath:@"account"];
        [[NSUserDefaults standardUserDefaults] setValue:passwordTF.text forKeyPath:@"password"];
        
        [UIView animateWithDuration:2.0f animations:^{
            [myView removeFromSuperview];
        }];
        NSLog(@"登录成功");
    }
}

- (void) selectWithAccount : (id) sender
{
    is_selected = !is_selected;
    
    if (is_selected) {
        [selectBtn setImage:[UIImage imageNamed:@"triangle1"] forState:UIControlStateNormal];
        accountTB.frame = CGRectMake(accountTF.frame.origin.x, CGRectGetMaxY(accountTF.frame), accountTF.frame.size.width, accountTF.frame.size.height * 8);
    }else
    {
        [selectBtn setImage:[UIImage imageNamed:@"triangle"] forState:UIControlStateNormal];
        accountTB.frame = CGRectMake(accountTF.frame.origin.x, CGRectGetMaxY(accountTF.frame), accountTF.frame.size.width, 0);
    }
}
- (void) selectWithPassword : (id) sender
{
    is_selectedPassword = !is_selectedPassword;
    
    if (is_selectedPassword) {
        [selectPasswordBtn setImage:[UIImage imageNamed:@"triangle1"] forState:UIControlStateNormal];
        passwordTB.frame = CGRectMake(passwordTF.frame.origin.x, CGRectGetMaxY(passwordTF.frame), passwordTF.frame.size.width, passwordTF.frame.size.height * 2);
    }else
    {
        [selectPasswordBtn setImage:[UIImage imageNamed:@"triangle"] forState:UIControlStateNormal];
        passwordTB.frame = CGRectMake(passwordTF.frame.origin.x, CGRectGetMaxY(passwordTF.frame), passwordTF.frame.size.width, 0);
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == accountTB) {
        return accountArr.count;
    }else
    {
        return passwordArr.count;
    }
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return accountTF.frame.size.height;
    
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (tableView == accountTB) {
        cell.textLabel.text = accountArr[indexPath.row];
        if (indexPath.row > 5) {
            cell.textLabel.textColor = [UIColor redColor];
        }
    }else
    {
        cell.textLabel.text = passwordArr[indexPath.row];
        if (indexPath.row > 0) {
            cell.textLabel.textColor = [UIColor redColor];
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == accountTB) {
        accountTF.text = accountArr[indexPath.row];
        //        [[NSUserDefaults standardUserDefaults] setValue:accountTF.text forKeyPath:@"account"];
        is_selected = NO;
        [selectBtn setImage:[UIImage imageNamed:@"triangle"] forState:UIControlStateNormal];
        accountTB.frame = CGRectMake(accountTF.frame.origin.x, CGRectGetMaxY(accountTF.frame), accountTF.frame.size.width, 0);
    }else
    {
        passwordTF.text = passwordArr[indexPath.row];
        //        [[NSUserDefaults standardUserDefaults] setValue:passwordTF.text forKeyPath:@"password"];
        is_selectedPassword = NO;
        [selectPasswordBtn setImage:[UIImage imageNamed:@"triangle"] forState:UIControlStateNormal];
        passwordTB.frame = CGRectMake(passwordTF.frame.origin.x, CGRectGetMaxY(passwordTF.frame), passwordTF.frame.size.width, 0);
    }
    
}
@end

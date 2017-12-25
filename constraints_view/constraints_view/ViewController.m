//
//  ViewController.m
//  constraints_view
//
//  Created by EPIC_IOS on 2017/10/25.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIView *blueVw;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建一个蓝色的view
    UIView *blueView = [[UIView alloc] init];
    
    blueView.backgroundColor = [UIColor blueColor];
    blueView.frame = CGRectMake(0, 0, 200, 200);
    blueVw = blueView;
    [self.view addSubview:blueVw];
    
    
    //创建一个红色的view
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    
    //把红色view添加到蓝色view上
    [blueView addSubview:redView];
    
    CGFloat redV_w = blueView.frame.size.width;
    CGFloat redV_h = 50;
    CGFloat redV_x = 0;
    CGFloat redV_y = blueView.frame.size.height - redV_h;
    
    #pragma mark -- 设置autoresizing
    /* < 设置红色view距离蓝色view的底部距离不变 > */
    redView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    
    
    redView.frame = CGRectMake(redV_x, redV_y, redV_w, redV_h);
    
    UIButton *btn = [[UIButton alloc] init];
    btn.backgroundColor = [UIColor lightGrayColor];
    [btn setTitle:@"change" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 100, 60);
    btn.center = self.view.center;
    [self.view addSubview:btn];
}

- (void)btnClicked:(UIButton *)sender
{
    CGRect blueFrame = blueVw.frame;
    blueFrame.size.height += 20;
    blueFrame.size.width += 20;
    
    blueVw.frame = blueFrame;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  ViewController.m
//  iPhone X适配
//
//  Created by EPIC_IOS on 2017/12/4.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.title = @"标题";
    self.view.backgroundColor = [UIColor blueColor];
    
    UILabel *testLab = [[UILabel alloc] init];
    testLab.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    if ([UIApplication sharedApplication].keyWindow.frame.size.height == 812) {
        testLab.frame = CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 34 - 44);
    }
    testLab.backgroundColor = [UIColor redColor];
    testLab.text = @"just being a shooter";
    testLab.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:testLab];
    [[UIApplication sharedApplication].keyWindow addSubview:testLab];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[UIApplication sharedApplication].keyWindow removeFromSuperview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

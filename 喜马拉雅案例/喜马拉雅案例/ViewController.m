//
//  ViewController.m
//  喜马拉雅案例
//
//  Created by EPIC_IOS on 2017/10/9.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollview;
@property (weak, nonatomic) IBOutlet UIImageView *lastImgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /* < 获取当前控件的最大的y值 > */
    CGFloat maxH = CGRectGetMaxY(self.lastImgView.frame);
    
    /* < 设置UIscrollview的contentSize > */
    self.myScrollview.contentSize = CGSizeMake(0, maxH);
    
    /* < 设置默认滚动 > */
    self.myScrollview.contentOffset = CGPointMake(0, -64);
    
    /* < 设置内边距 > */
    self.myScrollview.contentInset = UIEdgeInsetsMake(64, 0, 54, 0);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

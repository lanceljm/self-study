//
//  ViewController.m
//  缩放
//
//  Created by EPIC_IOS on 2017/10/10.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollview;
@property (weak, nonatomic) IBOutlet UIImageView *myImgView;

@end

@implementation ViewController

/*
 *
 *  注意一次只能缩放一个子控件
 *
 */
/* < 缩放 > */
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.myImgView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /* < 设置缩放比例 > */
    self.myScrollview.maximumZoomScale = 3.5;
    self.myScrollview.minimumZoomScale = 0.1;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

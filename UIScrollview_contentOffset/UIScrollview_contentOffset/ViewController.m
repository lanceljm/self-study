//
//  ViewController.m
//  UIScrollview_contentOffset
//
//  Created by EPIC_IOS on 2017/10/9.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollview;
@property (weak, nonatomic) IBOutlet UIImageView *myImgView;
//@property (weak, nonatomic) IBOutlet UIButton *btnClickedAction;
- (IBAction)btnClickedAction:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /* < 设置UIscrollview的实际内容大小 > */
    self.myScrollview.contentSize = self.myImgView.image.size;
    
    NSLog(@"%f",self.myScrollview.frame.size.width);
    NSLog(@"%f",self.myScrollview.frame.size.height);
    
    NSLog(@"%f",self.myScrollview.contentSize.width);
    NSLog(@"%f",self.myScrollview.contentSize.height);
    
    NSLog(@"%f",self.myImgView.image.size.width);
    NSLog(@"%f",self.myImgView.image.size.height);
    
    /* < 隐藏滚动指示器 > */
    self.myScrollview.showsHorizontalScrollIndicator = NO;
    self.myScrollview.showsVerticalScrollIndicator = NO;
    
    /* < 设置实际内容的内边距 > */
    self.myScrollview.contentInset = UIEdgeInsetsMake(10, 5, 10, 5);
}

/* < 通过代码使图片滚动 > */
- (IBAction)btnClickedAction:(id)sender {
    
    /*
     *
     *  结构体是不能直接修改参数的，必须使用中间替换出来
     *
     */
    CGPoint point = self.myScrollview.contentOffset;
    point.x += 150;
    point.y += 100;
    
    /*
     *
     *  增加动画效果
     *
     */
    
    /* < 使用block动画实现滚动 > */
//    [UIView animateWithDuration:1.f animations:^{
//        self.myScrollview.contentOffset = point;
//    }];
    
    
    /*
     *
     *  直接使用动画设置contentoffset属性的值(系统自选动画)
     *
     */
    [self.myScrollview setContentOffset:point animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  ViewController.m
//  滚动视图
//
//  Created by EPIC_IOS on 2017/10/10.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "ViewController.h"

#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollview;
@property (weak, nonatomic) IBOutlet UIPageControl *myPageController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /* < 动态创建UIimageview添加到UIscrollview中 > */
    
//    CGFloat img_width = 375;
    CGFloat img_height = 150;
    CGFloat img_y = 0;
    
    self.myScrollview.frame = CGRectMake(0, 70, screen_width, img_height);
    
    //1、循环创建6个uiimgview添加到UIscrollview中
    for (NSInteger index = 0; index < 6; index ++) {
        //创建一个UIimageview
        UIImageView *imgView = [[UIImageView alloc] init];
        //设置UIimageview中的图片
        NSString *imgName = [NSString stringWithFormat:@"img0%ld",index + 1];
//        NSLog(@"%ld",index);
        imgView.image = [UIImage imageNamed:imgName];
        //计算每个UIiamgview在UIscrollview中的x坐标
        CGFloat img_x = index * screen_width;//img_width;
        //设置uiimageview的frame
        imgView.frame = CGRectMake(img_x, img_y, screen_width, img_height);
        //把UIimageview添加到UIscrollview中
        [self.myScrollview addSubview:imgView];
    }
    
    
    //设置UIscrollview的contentsize（内容的实际大小）
//    CGFloat max_width = self.myScrollview.frame.size.width * 6;
    self.myScrollview.contentSize = CGSizeMake(screen_width * 6, 0);
    
    /* < 实现UIscrollview的分页效果 > */
    //当设置分页之后UIscrollview会按照自身的宽度作为一页来进行分页
    self.myScrollview.pagingEnabled = YES;
    
    //隐藏水平指示器
    self.myScrollview.showsHorizontalScrollIndicator = NO;
    
    self.myPageController.frame = CGRectMake(0, 0, 120, 20);
    self.myPageController.center = CGPointMake(self.view.center.x, 200);
//    self.myPageController.tintColor = [UIColor redColor];
//    self.myPageController.backgroundColor = [UIColor whiteColor];
    self.myPageController.currentPageIndicatorTintColor = [UIColor redColor];
    self.myPageController.pageIndicatorTintColor = [UIColor blueColor];
    self.myPageController.numberOfPages = 6;
    //指定默认是第0页
    self.myPageController.currentPage = 0;
    [self.view addSubview:self.myPageController];
//    [self.myScrollview bringSubviewToFront:self.myPageController];
    
}

#pragma mark -- 拖拽、滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"滚动开始，要在这里根据当前的滚动来计算当前页码");
    //如何计算当前滚到了第几页
    //1、获取当前滚动的偏移量
    CGFloat offset_X = scrollView.contentOffset.x;
    
    //用已经偏移了的值加上半页的宽度
    /* < 当前偏移量大于一半页码指示器就滚动 > */
    offset_X = offset_X + scrollView.frame.size.width * 0.5;
    
    //2、用x方向的偏移量的值除以一张图片的宽度，取商就是当前滚动到了第几页
    int page = offset_X / scrollView.frame.size.width;
    
    //3、将页面设置给UIpagecontroller
    self.myPageController.currentPage = page;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

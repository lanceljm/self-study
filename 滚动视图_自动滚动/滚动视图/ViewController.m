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

static CGFloat img_height = 150;
static CGFloat img_y = 0;
static CGFloat img_width = 375;

@interface ViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollview;
@property (weak, nonatomic) IBOutlet UIPageControl *myPageController;
/* < 定时器 > */
@property (strong , nonatomic) NSTimer  * timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    /* < 动态创建UIimageview添加到UIscrollview中 > */
    self.myScrollview.frame = CGRectMake(0, 100, screen_width, img_height);
    
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
    
    self.myPageController.frame = CGRectMake(0, 0, 160, 20);
    self.myPageController.center = CGPointMake(self.view.center.x, 200);
    self.myPageController.currentPageIndicatorTintColor = [UIColor redColor];
    self.myPageController.pageIndicatorTintColor = [UIColor blueColor];
    self.myPageController.numberOfPages = 6;
    //指定默认是第0页
    self.myPageController.currentPage = 0;
    [self.view addSubview:self.myPageController];
//    [self.myScrollview bringSubviewToFront:self.myPageController];
    
    
    /* < 创建一个计时器控件，NSTimer控件 > */
    //通过scheduledTimerWithInterval这个方法创建的计时器控件，创建好以后自动启动
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(scrollImage) userInfo:nil repeats:YES];
    
    
    /* < 修改self.timer的优先级与控件一样 > */
    /* < 获取当前消息循环对象 > */
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    
    //改变self.timer对象的优先级
    [runloop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

#pragma mark -- 定时器的方法
/* < 因为在创建定时器的时候时间间隔是1.0秒，所以下面这个方法每隔1.0秒钟执行一次方法 > */
- (void) scrollImage
{
    NSLog(@"每个一秒执行一次");
    //每次执行这个方法的时候，都要让图片滚动到下一页
    
    //如何让UIscrollview滚动到下一页
    //1、获取当前的UIPagecontroller的页码
    NSInteger page = self.myPageController.currentPage;
    
    //2、判断页码是否到了最后一页，如果到了最后一页，那么设置页码为0，如果没有到达最后一页，则让页码+1
    if (page == self.myPageController.numberOfPages - 1) {
        //表示已经到了最后一页
        page = 0;
    }else
    {
        page ++;
    }
    //3、用每页的宽度 * （页码+1） == 计算除了下一页的contentoffset.x
    CGFloat offset_x = page * self.myScrollview.frame.size.width;
    
    //4、设置UIscrollview的contentoffset等于新的偏移量
    [self.myScrollview setContentOffset:CGPointMake(offset_x, 0) animated:YES];
    //如果图片现在已经滚动到最后一页了，那么久滚动到第一页
    
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

#pragma mark -- 实现即将开始拖拽的方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //使用invalidate之后定时器不能再重用，下次必须创建一个新的定时器
    [self.timer invalidate];
    
    /* < 因为当前的定时器已经作废 > */
    self.timer = nil;
}

#pragma mark --实现拖拽完毕之后的方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //重新开启一个定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(scrollImage) userInfo:nil repeats:YES];
    
    /* < 再次修改一下优先级 > */
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

@end

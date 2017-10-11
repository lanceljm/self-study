//
//  PureCodeViewController.m
//  滚动视图
//
//  Created by ljm on 2017/10/11.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "PureCodeViewController.h"

#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height

static CGFloat img_height = 200;

@interface PureCodeViewController ()<UIScrollViewDelegate>
{
    UIScrollView    *myScrollview;
    UIPageControl *myPageControl;
    NSTimer         *timer;
}


@end

@implementation PureCodeViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        myScrollview    = [[UIScrollView alloc] init];
        myPageControl = [[UIPageControl alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    myScrollview.delegate = self;
    myScrollview.frame     = CGRectMake(
                                    0,
                                    84,
                                    screen_width,
                                    img_height);
    
    NSInteger index ;
    NSInteger max_index = 6;
    for (index = 0 ; index < max_index ; index ++) {
        UIImageView *imgview = [[UIImageView alloc] initWithFrame:CGRectMake(
                                                                             screen_width * index ,
                                                                             0,
                                                                             screen_width,
                                                                             img_height)];
        imgview.image = [UIImage imageNamed:
                         [NSString stringWithFormat:@"img0%ld",index + 1]
                         ];
        [myScrollview addSubview:imgview];
    }
    myScrollview.contentSize            = CGSizeMake(screen_width * max_index, 0);
    myScrollview.pagingEnabled                        = YES;
    myScrollview.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:myScrollview];
    
    myPageControl.frame = CGRectMake(
                                     0,
                                     0,
                                     150,
                                     45);
    myPageControl.center = CGPointMake(myScrollview.center.x, CGRectGetMaxY(myScrollview.frame) - 25);
    myPageControl.currentPage = 0;
    myPageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    myPageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    myPageControl.numberOfPages = max_index;
    [self.view addSubview:myPageControl];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(scrollWithImg) userInfo:nil repeats:YES];
    /** change priority **/
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

#pragma mark -- drag、pull
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset  =    scrollView.contentOffset.x;
    offset              =   offset + scrollView.frame.size.width * 0.5;
    myPageControl.currentPage = offset / (scrollView.frame.size.width);
}

#pragma mark -- timer action
- (void) scrollWithImg
{
    if (myPageControl.currentPage == myPageControl.numberOfPages - 1) {
        myPageControl.currentPage = 0;
    }else
    {
        myPageControl.currentPage ++;
    }
    
    [myScrollview setContentOffset:CGPointMake(myPageControl.currentPage * myScrollview.frame.size.width, 0) animated:YES];
}

#pragma mark -- pull、drag start , timer is nil
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [timer invalidate];
    timer = nil;
}

#pragma mark -- again start timer
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    timer = [NSTimer scheduledTimerWithTimeInterval:1.2 target:self selector:@selector(scrollWithImg) userInfo:nil repeats:YES];
    /** change priority **/
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

@end

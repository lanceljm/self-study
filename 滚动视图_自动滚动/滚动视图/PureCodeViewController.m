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

@interface PureCodeViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView    *myScrollview;
    UIPageControl *myPageControl;
    NSTimer         *timer;
    
    UITableView *myTableview;
}


@end

@implementation PureCodeViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        myScrollview    = [[UIScrollView alloc] init];
        myPageControl = [[UIPageControl alloc] init];
        myTableview = [[UITableView alloc] init];
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
    
    
    myTableview.frame = CGRectMake(10, CGRectGetMaxY(myScrollview.frame) + 10, screen_width - 20, screen_height - CGRectGetMaxY(myScrollview.frame) - 20);
    myTableview.delegate = self;
    myTableview.dataSource = self;
    myTableview.backgroundColor = [UIColor grayColor];
    [self.view addSubview:myTableview];
}

#pragma mark -- drag、pull
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    /** judge class **/
    if (scrollView == myScrollview) {
        CGFloat offset  =    scrollView.contentOffset.x;
        offset              =   offset + scrollView.frame.size.width * 0.5;
        myPageControl.currentPage = offset / (scrollView.frame.size.width);
    }
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
    if (scrollView == myScrollview) {
        [timer invalidate];
        timer = nil;
    }
}

#pragma mark -- again start timer
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView == myScrollview) {
        timer = [NSTimer scheduledTimerWithTimeInterval:1.2 target:self selector:@selector(scrollWithImg) userInfo:nil repeats:YES];
        /** change priority **/
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
}

#pragma mark -- uitableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (screen_height - CGRectGetMaxY(myScrollview.frame) - 20) / 6;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"img0%ld",indexPath.row]];
    
    return cell;
}

@end

//
//  ViewController.m
//  通过代理监听滚动事件
//
//  Created by EPIC_IOS on 2017/10/10.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollview;
@property (weak, nonatomic) IBOutlet UIImageView *myImgView;

@end

/*
 *
 *  需求：监听UIscrollview的滚动事件
     分析:要监听UIscrollview的滚动事件，需要通过代理来实现，无法通过addtarget的方式来监听
     通过代理监听滚动事件的步骤：
         1、为UIscrollview找一个代理对象，也就是设置UIscrollview的delegate属性
 self.scrollView.delegate = self;
         提醒：不需要单独创建一个代理对象，直接将控制器作为控件的代理对象即可。
         2、为了保证代理对象中拥有对应的方法，所以必须让代理对象（控制器自己）遵守对应控件的代理协议（当前控制器要作为哪个控件的代理对象，那么控制器就要遵守这个控件的代理协议）
             一般控件的代理协议命名规则都是：控件名delegate(UIscrollviewDelegate,UIAlertViewDelegate)
         所以说这里要让当前控制器遵守UIscrollviewDelegate协议
         3、在控制器中实现需要的方法
 *
 */


@implementation ViewController

/* < 即将开始拖拽 > */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"即将开始拖拽……");
}

/* < 正在滚动 > */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"正在拖拽……");
    
    /* < 输出当前滚动的位置 > */
    NSString *point = NSStringFromCGPoint(scrollView.contentOffset);
    NSLog(@"%@",point);
}


/*
 *
 *  注意这里不是滚动完毕,拖拽完毕之后由于控件“滚性”还会继续滑动
 *
 */
/* < 拖拽完毕 > */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"拖拽完毕……");
}

/* < 即将开始缩放 > */
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    NSLog(@"即将开始缩放");
}

/* < 缩放 > */
- (UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.myImgView;
}

/* < 缩放完毕 > */
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    NSLog(@"缩放完毕");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //让当前控制器作为UIScrollView的代理对象
    self.myScrollview.delegate = self;
    
    self.myScrollview.contentSize = self.myImgView.image.size;
    
    /* < 缩放的比例 > */
    self.myScrollview.maximumZoomScale = 5.f;
    self.myScrollview.minimumZoomScale = 0.2;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

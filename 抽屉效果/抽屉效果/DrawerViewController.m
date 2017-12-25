//
//  DrawerViewController.m
//  抽屉效果
//
//  Created by EPIC_IOS on 2017/12/14.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "DrawerViewController.h"

#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
#define centerPoint self.view.center
#define UIAPP_Share [UIApplication sharedApplication]

@interface DrawerViewController ()<UIGestureRecognizerDelegate>

{
    UIView *_tapView;
    CGPoint _drawerStartPoint;
    CGPoint _mainStartPoint;
}

@end

@implementation DrawerViewController

- (instancetype)initWithDrawer:(UIViewController *)DrawerVC andCurrentVC:(UIViewController *)currentVC
{
    UIViewController *vc = UIAPP_Share.delegate.window.rootViewController;
    
    if (vc && [vc isKindOfClass:[self class]]) {
        return (DrawerViewController *)UIAPP_Share.delegate.window.rootViewController;
    }
    
    if (self = [super init]) {
        _currentVC = currentVC;
        _drawerVC = DrawerVC;
        
        _drawerContentoffset_x = screenWidth * 3 / 4;
        _currentVcPanWithRange = 100;
        
        _isDrawer = YES;
        
        _mainStartPoint = centerPoint;
        CGPoint point = self.view.center;
        point.x = point.x - _drawerContentoffset_x / 2;
        _drawerStartPoint = point;
        
        [self setupWithViewControllers];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void) setupWithViewControllers
{
    [self addChildViewController:_drawerVC];
    
    _drawerVC.view.center = CGPointMake(self.view.center.x - (_drawerContentoffset_x / 2), self.view.center.y);
    _drawerVC.view.bounds = CGRectMake(0, 0, screenWidth, screenHeight);
    
    [self.view addSubview:_drawerVC.view];
    [_currentVC.view addObserver:self forKeyPath:@"center" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    UIPanGestureRecognizer *pangestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [_currentVC.view addGestureRecognizer:pangestureRecognizer];
    pangestureRecognizer.delegate = self;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    _tapView = [[UIView alloc] init];
    _tapView.frame = CGRectMake(0, 0, screenWidth - _drawerContentoffset_x, screenHeight);
    [_tapView addGestureRecognizer:tapGesture];
    _tapView.hidden = YES;
    
    [_currentVC.view addSubview:_tapView];
    [self.view addSubview:_currentVC.view];
    
}

#pragma mark -- open drawer
- (void) panGesture:(UIPanGestureRecognizer *) pan
{
    if ([self isPushWithVC] || !_isDrawer) {
        return;
    }
    
    CGPoint point = [pan velocityInView:_currentVC.view];
    CGPoint movePoint = [pan translationInView:_currentVC.view];
    CGPoint tabBarCenterPoint = _currentVC.view.center;
    
    if (pan.state == UIGestureRecognizerStateChanged) {
        
        CGPoint tabBarVCCenter = _mainStartPoint;
        CGPoint drawerCenter = _drawerStartPoint;
        
        tabBarVCCenter.x = _mainStartPoint.x + movePoint.x;
        drawerCenter.x = centerPoint.x + (movePoint.x * (_drawerContentoffset_x / 2) / _drawerContentoffset_x);
        
        if (tabBarVCCenter.x >= centerPoint.x && (centerPoint.x + _drawerContentoffset_x) >= tabBarVCCenter.x) {
            _currentVC.view.center = tabBarVCCenter;
            _drawerVC.view.center = drawerCenter;
        }else if (centerPoint.x > tabBarVCCenter.x)
        {
            _currentVC.view.center = self.view.center;
            CGPoint point = self.view.center;
            point.x = point.x - (_drawerContentoffset_x / 2);
            _drawerVC.view.center = point;
        }else if (tabBarVCCenter.x > (centerPoint.x + _drawerContentoffset_x))
        {
            CGPoint point = self.view.center;
            point.x = centerPoint.x + _drawerContentoffset_x;
            _currentVC.view.center = point;
            _drawerVC.view.center = self.view.center;
        }
    }else if (pan.state == UIGestureRecognizerStateEnded)
    {
        CGFloat change_x = fabs(point.x);
        CGFloat change_y = fabs(point.y);
        
        if (change_x > change_y && change_x > 50) {
            if (point.x > 0) {
                [self openWithDrawer];
            }else
            {
                [self closeWithDrawer];
            }
        }else
        {
            if ((tabBarCenterPoint.x > self.view.center.x) && self.view.center.x + _drawerContentoffset_x / 2 >= tabBarCenterPoint.x) {
                [self closeWithDrawer];
            }else if (tabBarCenterPoint.x > (self.view.center.x + _drawerContentoffset_x / 2) >= tabBarCenterPoint.x)
            {
                [self openWithDrawer];
            }
        }
    }
}

- (void) openWithDrawer
{
    __weak typeof (self) weakself = self;
    [UIView animateWithDuration:0.2f animations:^{
        _currentVC.view.center = weakself.view.center;
        CGPoint point = weakself.view.center;
        point.x =  point.x - _drawerContentoffset_x / 2;
        _drawerVC.view.center = point;
    } completion:^(BOOL finished) {
        _mainStartPoint = _currentVC.view.center;
        _drawerStartPoint = _drawerVC.view.center;
    }];
}

#pragma mark -- close drawer
- (void) tapGesture : (UITapGestureRecognizer *)tap
{
    [self closeWithDrawer];
}

- (void) closeWithDrawer
{
    __weak typeof(self) weakself = self;
    [UIView animateWithDuration:0.2f animations:^{
        _currentVC.view.center = weakself.view.center;
        CGPoint point = weakself.view.center;
        point.x = point.x - (_drawerContentoffset_x / 2);
        _drawerVC.view.center = point;
    } completion:^(BOOL finished) {
        _mainStartPoint = _currentVC.view.center;
        _drawerStartPoint = _drawerVC.view.center;
    }];
}

#pragma mark -- 判断控制器是否位于根控制器
- (BOOL) isPushWithVC
{
    NSArray *viewControllers = [[NSArray alloc] init];
    viewControllers = self.currentNavctionController.viewControllers;
    
    if (viewControllers.count == 1) {
        return YES;
    }else
    {
        return NO;
    }
}

#pragma mark -- 手势代理方法
- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    CGPoint mainStartview = [touch locationInView:_currentVC.view];
    
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && (screenHeight - self.tabBarController.tabBar.frame.size.height) >= mainStartview.y) {
        if (mainStartview.x < _currentVcPanWithRange) {
            return [self isPushWithVC];
        }else
        {
            return NO;
        }
    }
    return NO;
}

#pragma mark -- 监听currentVC.center 隐藏tapview
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"center"]) {
        NSValue *centerpoint = change[@"new"];
        CGPoint point = [centerpoint CGPointValue];
        if (point.x == (_mainStartPoint.x + _drawerContentoffset_x)) {
            _tapView.hidden = NO;
        }else
        {
            _tapView.hidden = YES;
        }
    }
}

#pragma mark -- 获取当前导航行控制器
- (UINavigationController *)currentNavctionController
{
    UINavigationController *currentNavVC = [[UINavigationController alloc] init];
    if ([_currentVC isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navVC = (UINavigationController *)_currentVC;
        currentNavVC = navVC;
    }else if ([_currentVC isKindOfClass:[UITabBarController class]])
    {
        UITabBarController *tabbarVc = (UITabBarController *)_currentVC;
        currentNavVC = tabbarVc.childViewControllers[tabbarVc.selectedIndex];
    }
    return currentNavVC;
    
}

#pragma mark -- drawer setter
- (void)setDrawerContentoffset_x:(CGFloat)drawerContentoffset_x
{
    _drawerContentoffset_x = drawerContentoffset_x;
    _drawerVC.view.frame = CGRectMake(- _drawerContentoffset_x / 2, 0, screenWidth, screenHeight);
    _currentVC.view.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    _tapView.frame = CGRectMake(0, 0, screenWidth - _drawerContentoffset_x, screenHeight);
}

#pragma mark -- 判断滑动方向
- (void) directByPointInVelocity : (CGPoint) point
{
    /* < 根据X坐标来分析滑动的方向 > */
    CGFloat change_x = fabs(point.x);
    CGFloat change_y = fabs(point.y);
    
    if (change_x > change_y && change_x > 20) {
        if (point.x > 0) {
        
        }else
        {
            
        }
    }
}

@end


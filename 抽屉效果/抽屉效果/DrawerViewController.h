//
//  DrawerViewController.h
//  抽屉效果
//
//  Created by EPIC_IOS on 2017/12/14.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawerViewController : UIViewController

/* < currentVC > */
@property (strong , nonatomic) UIViewController  * currentVC;

/* < drawerVC > */
@property (strong , nonatomic) UIViewController  * drawerVC;

/* < 侧边偏移量 > */
@property (assign , nonatomic) CGFloat   drawerContentoffset_x;

/* < 手势的范围 > */
@property (assign , nonatomic) CGFloat   currentVcPanWithRange;

/* < 抽屉开关 > */
@property (assign , nonatomic) BOOL   isDrawer;

/* < 获取当前VC的导航控制器，用于滑动抽屉 > */
@property (strong , nonatomic , readonly) UINavigationController  * currentNavctionController;

/* < 关闭抽屉 > */
- (void) closeWithDrawer;

/* < 打开抽屉 > */
- (void) openWithDrawer ;


#pragma mark -- 抽屉控制器初始化方法
- (instancetype) initWithDrawer : (UIViewController *) DrawerVC andCurrentVC : (UIViewController *) currentVC;

@end

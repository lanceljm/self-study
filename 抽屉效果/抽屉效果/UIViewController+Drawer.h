//
//  UIViewController+Drawer.h
//  抽屉效果
//
//  Created by EPIC_IOS on 2017/12/15.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DrawerViewController;

@interface UIViewController (Drawer)

/* < 获取 抽屉控制器 > */
@property (strong , nonatomic , readonly) DrawerViewController  * drawerVC;

/* < 左侧 push操作 > */
- (void) drawerPushViewController : (UIViewController *) viewcontroller andAnimated : (BOOL) animated;

/* < 打开 抽屉 > */
- (void) drawerOpenVC;

@end

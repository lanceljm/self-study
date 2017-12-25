//
//  UIViewController+Drawer.m
//  抽屉效果
//
//  Created by EPIC_IOS on 2017/12/15.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "UIViewController+Drawer.h"
#import "DrawerViewController.h"

@implementation UIViewController (Drawer)

- (DrawerViewController *)drawerVC
{
    return (DrawerViewController *)[UIApplication sharedApplication].delegate.window.rootViewController;
}

- (void)drawerPushViewController:(UIViewController *)viewcontroller andAnimated:(BOOL)animated
{
    [self.drawerVC closeWithDrawer];
    [self.drawerVC.currentNavctionController pushViewController:viewcontroller animated:animated];
}

- (void)drawerOpenVC
{
    [self.drawerVC openWithDrawer];
}

@end

//
//  DetailVC.m
//  抽屉效果
//
//  Created by EPIC_IOS on 2017/12/15.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "DetailVC.h"

@interface DetailVC ()

@end

@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:(arc4random()%255) / 255.0 green:(arc4random()%255) / 255.0 blue:(arc4random()%255) / 255.0 alpha:1.f];
    
    self.tabBarController.tabBar.hidden = YES;
    
}


@end

//
//  ViewController.m
//  排序展示
//
//  Created by EPIC_IOS on 2017/11/24.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong , nonatomic) NSArray  * dataArr;

@end

@implementation ViewController

- (NSArray *)dataArr
{
    if (!_dataArr) {
        NSArray *arr = @[@8,@7,@4,@5,@1,@6,@2,@3];
        NSLog(@"排序前：%@\n",arr);
        _dataArr = [NSArray new];
        _dataArr = [arr sortedArrayUsingSelector:@selector(compare:)];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"排序后：%@",self.dataArr);
}





@end

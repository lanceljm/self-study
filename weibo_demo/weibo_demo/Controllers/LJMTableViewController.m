//
//  LJMTableViewController.m
//  weibo_demo
//
//  Created by EPIC_IOS on 2017/10/18.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "LJMTableViewController.h"

@interface LJMTableViewController ()

//保存很多个weiboFrame模型
@property (strong , nonatomic) NSArray  * weiboFrames;

@end

@implementation LJMTableViewController

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.weiboFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    //1、获取模型数据
    LJMWeiboFrame *model = self.weiboFrames[indexPath.row];
    
    //2、创建单元格
    LJMWeiboCell *cell = [LJMWeiboCell weiboCellWithTableview:tableView];
    //3、设置单元格数据
    cell.weiboFrame = model;
    /* < 去掉cell的点击效果 > */
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //4、返回单元格
    return cell;
}

#pragma mark -- 返回每行行高的方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJMWeiboFrame *weiboFrame = self.weiboFrames[indexPath.row];
    return weiboFrame.rowHeight;
}


#pragma mark -- getter 懒加载数据

- (NSArray *)weiboFrames
{
    if (!_weiboFrames) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"statuses.plist" ofType:nil];
        NSArray *arrDic = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrModels = [NSMutableArray array];
        /* < 循环添加数据 > */
        for (NSDictionary *dict in arrDic) {
            //创建一个数据模型
            LJMWeibo *model = [LJMWeibo weiboWithDict:dict];
            //创建一个空的frame模型
            LJMWeiboFrame *modelFrame = [[LJMWeiboFrame alloc] init];
            //把数据模型赋值给了ModelFrame模型中的weibo属性
            modelFrame.weibo = model;
            
            [arrModels addObject:modelFrame];
        }
        _weiboFrames = arrModels;
    }
    return _weiboFrames;
}


@end

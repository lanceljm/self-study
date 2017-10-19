//
//  ViewController.m
//  QQ-chat
//
//  Created by EPIC_IOS on 2017/10/19.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "ViewController.h"
#import "LJMessageCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

//用来保存所有的消息的frame模型对象
@property (strong , nonatomic) NSMutableArray  * messageFrames;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation ViewController

- (BOOL) prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //取消分割线
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    //设置uitableview的背景色
    self.tableview.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.f];
    //设置tableview不允许被选中昂
    self.tableview.allowsSelection = NO;
}

#pragma mark -- uitableview 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messageFrames.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1、获取模型数据
    LJMMessageFrameModel *model = self.messageFrames[indexPath.row];
    
    //2、创建单元格
    LJMessageCell *cell = [LJMessageCell messageCellWithTableview:tableView];
    
    //3、把模型设置给单元格对象
    cell.messageFrame = model;
    
    
    //4、返回单元格
    return cell;
}

#pragma mark -- 返回行高
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJMMessageFrameModel *messageFrame = self.messageFrames[indexPath.row];
    return messageFrame.rowHeight;
}

#pragma mark -- 懒加载（getter）
- (NSMutableArray *)messageFrames
{
    if (!_messageFrames) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil];
        NSArray *arrDic = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *arrModels = [NSMutableArray array];
        
        for (NSDictionary *dic in arrDic) {
            //创建一个数据模型
            LJMMessageModel *model = [LJMMessageModel messageWithDic:dic];
            
            
            
            //获取上一个数据模型
            LJMMessageModel *lastMessage = (LJMMessageModel *)[[arrModels lastObject] messageModel];
            //判断当前模型的消息发送时间是否和上一个模型的消息发送时间一致，如果一致做个标记
            if ([model.time isEqualToString:lastMessage.time]) {
                model.isHideTime = YES;
            }else
            {
                model.isHideTime = NO;
            }

            
            //创建一个frame模型
            LJMMessageFrameModel *modelFrame = [[LJMMessageFrameModel alloc] init];
            modelFrame.messageModel = model;
            [arrModels addObject:modelFrame];
        }
        _messageFrames = arrModels;
    }
    return _messageFrames;
}

@end

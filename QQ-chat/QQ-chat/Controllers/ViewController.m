//
//  ViewController.m
//  QQ-chat
//
//  Created by EPIC_IOS on 2017/10/19.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "ViewController.h"
#import "LJMessageCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

//用来保存所有的消息的frame模型对象
@property (strong , nonatomic) NSMutableArray  * messageFrames;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UITextField *textInput;

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

    /** 设置文本框最左侧有间距 **/
    UIView *leftView = [[UIView alloc] init];
    leftView.frame = CGRectMake(0, 0, 5, 1);
    self.textInput.leftView = leftView;
    /** 设置文本框左侧视图的显示状态  **/
    self.textInput.leftViewMode = UITextFieldViewModeAlways;

    //监听键盘的弹出事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark -- 键盘frame发生变化时候触发的事件
- (void) keyboardWillChangeFrame : (NSNotification *)noteinfo
{
//    NSLog(@"通知名称:%@",noteinfo.name);
//    NSLog(@"通知的发布者:%@",noteinfo.object);
//    NSLog(@"%@",noteinfo.userInfo);


    /** 获取键盘的Y值 **/
    CGRect endRect = [noteinfo.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboard_y = endRect.origin.y;


    [UIView animateWithDuration:0.25f animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, keyboard_y - self.view.frame.size.height) ;
    }];


    //让uitableview的最后一行显示在键盘的最上方
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:self.messageFrames.count - 1 inSection:0];
    [self.tableview scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];

}

#pragma mark -- UItextfield的代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    /** 获取用户文本 **/
    NSString *text = textField.text;

    /** 发送用户消息 **/
    [self sendMessage:text withType:LJMMessageTypeMe];

    /** 发送系统消息 **/
    [self sendMessage:@"不认识" withType:LJMMessageTypeOther];

    /** 清空文本框 **/
    textField.text = nil;

    return YES;
}

#pragma mark -- 发送消息
- (void) sendMessage : (NSString *)message withType : (LJMMessageType) type
{

    /** 创建一个数据模型和frame模型 **/
    LJMMessageModel *model = [[LJMMessageModel alloc] init];
    //获取当前系统时间
    NSDate *date = [NSDate date];
    //格式化系统时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"今天 HH:mm";
    model.time = [formatter stringFromDate:date];

    model.type = type;
    model.text = message;

    LJMMessageFrameModel *modelFrame = [[LJMMessageFrameModel alloc] init];
    modelFrame.messageModel = model;

    //根据当前消息的时间和上一条消息的时间来判断是否需要隐藏时间
    LJMMessageFrameModel *lastMessageFrame =  [self.messageFrames lastObject];
    NSString *lastTime = lastMessageFrame.messageModel.time;
    if ([model.time isEqualToString:lastTime]) {
        model.isHideTime = YES;
    }

    /** 把frame加到集合中 **/
    [self.messageFrames addObject:modelFrame];

    /** 刷新uitableview **/
    [self.tableview reloadData];

    /** 把最后一行滚到最上方 **/
    [self.tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messageFrames.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];

}

#pragma mark -- scrollview 代理方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    /** 收回键盘 **/
    [self.view endEditing:YES];
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

#pragma mark -- 移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

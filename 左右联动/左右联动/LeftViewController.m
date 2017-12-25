//
//  LeftViewController.m
//  左右联动
//
//  Created by EPIC_IOS on 2017/12/14.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "LeftViewController.h"
#import "RightViewController.h"

@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource,RightViewControllerDelegate>

{
    RightViewController *_rightTB;
    UITableView         *_leftTB;
    CGFloat             _selectedHeight;
}

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createWithLeftTB];
    [self createWithRightTB];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rightTableviewSelectedCell:) name:@"SelectedCell" object:nil];
    
    _selectedHeight = 0;
    
}

#pragma mark -- left tableview
- (void) createWithLeftTB
{
    _leftTB = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 0.25, self.view.frame.size.height - 64)];
    _leftTB.delegate = self;
    _leftTB.dataSource = self;
    _leftTB.showsVerticalScrollIndicator = false;
    [self.view addSubview:_leftTB];
}

#pragma mark -- right tableview
- (void) createWithRightTB
{
    _rightTB = [[RightViewController alloc] init];
    [self addChildViewController:_rightTB];
    
    _rightTB.delegate = self;
    [self.view addSubview:_rightTB.view];
}

#pragma mark -- uitableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.text = [NSString stringWithFormat:@"第%ld类",indexPath.row + 1];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
    return cell;
}

#pragma mark -- uitableview DataSource
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_rightTB) {
        [_rightTB scrollToSelectedIndexPath:indexPath];
    }
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    _selectedHeight = 20 * 45;
    
    /* < 计算滑动的偏移量 > */
    CGFloat offset_y = cell.center.y - self.view.frame.size.height / 2;
    CGFloat maxoffset_y = _selectedHeight - self.view.frame.size.height;
    
    if (offset_y < 0 || maxoffset_y < 0) {
        offset_y = 0;
    }else if (offset_y > maxoffset_y)
    {
        offset_y = maxoffset_y;
    }
    
    [_leftTB setContentOffset:CGPointMake(0, offset_y) animated:YES];
}

#pragma mark -- 操作左边滑动右边的代理
- (void)willDisPlayHeaderView:(NSInteger)section
{
    [_leftTB selectRowAtIndexPath:[NSIndexPath indexPathForRow:section inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}
- (void) didEndDisPlayHeaderView:(NSInteger)section
{
    [_leftTB selectRowAtIndexPath:[NSIndexPath indexPathForRow:section + 1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}


#pragma mark -- tableview selected cell
- (void) rightTableviewSelectedCell : (NSNotification *) obj
{
    NSInteger index = [obj.userInfo[@"section"] integerValue];
    
    [_leftTB selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end


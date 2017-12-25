//
//  RightViewController.m
//  左右联动
//
//  Created by EPIC_IOS on 2017/12/14.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "RightViewController.h"
#import "RightDetailViewController.h"

@interface RightViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    UITableView     *_rightTB;
    NSArray         *_rightARR;
    NSArray         *_sectionARR;
    BOOL            IsScrollUP;
    CGFloat         lastOffSet;
}
@end

@implementation RightViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /* < 初始化状态不滚动，无偏移 > */
    IsScrollUP = false;
    lastOffSet = 0;
    
    [self addDatas];
    
    [self createTB];
    
}

#pragma mark -- adddata
- (void) addDatas
{
    if (!_rightARR) {
        NSArray *array = @[@"fucker",@"asshole",@"shit",@"motherfucker",@"bastard"];
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSInteger index = 0; index < array.count / 2; index ++) {
            [arr addObject:array[arc4random() % (array.count)]];
        }
        _rightARR = [arr copy];
    }
}

#pragma mark -- create Tableview
- (void) createTB
{
    /* < view > */
    self.view = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.25, 0, self.view.frame.size.width * 0.75, self.view.frame.size.height - 64)];
    
    /* < tableview > */
    _rightTB = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _rightTB.dataSource = self;
    _rightTB.delegate = self;
    
    [self.view addSubview:_rightTB];
    
}

#pragma mark -- uitableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _rightARR.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"第%ld类",section + 1];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = _rightARR[indexPath.row];
    
    return cell;
}

#pragma mark -- 自定义代理方法
- (void) tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(willDisPlayHeaderView:)] != IsScrollUP && _rightTB.isDecelerating) {
        [self.delegate didEndDisPlayHeaderView:section];
    }
}
- (void) tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didEndDisPlayHeaderView:)] && _rightTB.isDecelerating) {
        [self.delegate didEndDisPlayHeaderView:section];
    }
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    IsScrollUP = lastOffSet < scrollView.contentOffset.y;
    
    lastOffSet = scrollView.contentOffset.y;
}

- (void) scrollToSelectedIndexPath:(NSIndexPath *)indexPath
{
    [_rightTB selectRowAtIndexPath:([NSIndexPath indexPathForRow:0 inSection:indexPath.row]) animated:YES scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark -- uitableview didselectRow
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_rightTB deselectRowAtIndexPath:indexPath animated:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectedCell" object:nil userInfo:@{@"section":@(indexPath.section)}];
    
    RightDetailViewController *rightDVC = [[RightDetailViewController alloc] init];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    rightDVC.title = cell.textLabel.text;
    [self.navigationController pushViewController:rightDVC animated:YES];
}

@end

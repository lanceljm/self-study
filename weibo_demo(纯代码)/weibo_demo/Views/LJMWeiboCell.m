//
//  LJMWeiboCell.m
//  weibo_demo
//
//  Created by EPIC_IOS on 2017/10/18.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "LJMWeiboCell.h"
#import <UIKit/UIKit.h>

@interface LJMWeiboCell ()

@property (weak , nonatomic) UIImageView    * imageviewIcon;
@property (weak , nonatomic) UILabel        * lblNickName;
@property (weak , nonatomic) UIImageView    * imageviewVip;
@property (weak , nonatomic) UILabel        * lblText;
@property (weak , nonatomic) UIImageView    * imageviewPicture;

@end

@implementation LJMWeiboCell

+ (instancetype)weiboCellWithTableview:(UITableView *)tableview
{
    static NSString *ID = @"weibo_cell";
    LJMWeiboCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LJMWeiboCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

#pragma mark -- 重写initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //创建五个子控件
        
        //1、头像
        UIImageView *imgviewIcon = [[UIImageView alloc] init];
        [self.contentView addSubview:imgviewIcon];
        self.imageviewIcon = imgviewIcon;
        
        //2、昵称
        UILabel *lblNickName = [[UILabel alloc] init];
        lblNickName.font = nameFont;
        [self.contentView addSubview:lblNickName];
        self.lblNickName = lblNickName;
        
        //3、会员
        UIImageView *imgviewVip = [[UIImageView alloc] init];
        imgviewVip.image = [UIImage imageNamed:@"vip"];
        [self.contentView addSubview:imgviewVip];
        self.imageviewVip = imgviewVip;
        
        //4、正文
        UILabel *lblText = [[UILabel alloc] init];
        lblText.font = textFont;
        lblText.numberOfLines = 0;
        [self.contentView addSubview:lblText];
        self.lblText = lblText;
        
        //5、图片
        UIImageView *imgviewPicture = [[UIImageView alloc] init];
        [self.contentView addSubview:imgviewPicture];
        self.imageviewPicture = imgviewPicture;
    }
    return self;
}


#pragma mark -- 重写weibo属性的set方法
- (void)setWeiboFrame:(LJMWeiboFrame *)weiboFrame
{
    _weiboFrame = weiboFrame;
    
    //1、设置当前单元格中的子控件的数据
    [self setWithData];
    
    //2、设置当前单元格中的子控件的frame
    [self setWithFrame];
}

#pragma mark -- 设置数据的方法
- (void) setWithData
{
    LJMWeibo *model = self.weiboFrame.weibo;
    
    //1、头像
    self.imageviewIcon.image = [UIImage imageNamed:model.icon];
    
    //2、昵称
    self.lblNickName.text = model.name;
    
    //3、会员
    if (model.isVIP) {
        self.imageviewVip.hidden = NO;
        self.lblNickName.textColor = [UIColor redColor];
    }else
    {
        self.imageviewVip.hidden = YES;
        self.lblNickName.textColor = [UIColor blackColor];
    }
    
    //4、正文
    self.lblText.text = model.text;
    
    //5、配图
    if (model.picture) {
        //有配图
        /* < 如果model.picture的值为nil，异常 > */
        self.imageviewPicture.image = [UIImage imageNamed:model.picture];
        //显示图片框
        self.imageviewPicture.hidden = NO;
    }else
    {
        //隐藏图片框
        self.imageviewPicture.hidden = YES;
    }
}

#pragma mark -- 设置frame
- (void) setWithFrame
{
    //1、头像
    self.imageviewIcon.frame = self.weiboFrame.iconFrame;
    
    //2、昵称
    self.lblNickName.frame = self.weiboFrame.nameFrame;
    
    //3、会员
    self.imageviewVip.frame = self.weiboFrame.vipFrame;
    
    //4、正文
    self.lblText.frame = self.weiboFrame.textFrame;
    
    //5、配图
    self.imageviewPicture.frame = self.weiboFrame.pictureFrame;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  LJMessageCell.m
//  QQ-chat
//
//  Created by EPIC_IOS on 2017/10/19.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "LJMessageCell.h"

@interface LJMessageCell ()

@property (weak , nonatomic) UILabel  * lblTime;
@property (weak , nonatomic) UIImageView  * imagViewIcon;
@property (weak , nonatomic) UIButton  * btnText;

@end

@implementation LJMessageCell

+ (instancetype)messageCellWithTableview:(UITableView *)tableview
{
    static NSString *ID = @"message_cell";
    LJMessageCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LJMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

#pragma mark -- 重写initwithstyle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //创建子控件
        
        //显示时间的label
        UILabel *lblTime = [[UILabel alloc] init];
        lblTime.font = [UIFont systemFontOfSize:12];
        lblTime.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:lblTime];
        self.lblTime = lblTime;
        
        //显示头像的UIimageview
        UIImageView *imgViewIcon = [[UIImageView alloc] init];
        [self.contentView addSubview:imgViewIcon];
        self.imagViewIcon = imgViewIcon;
        
        //显示消息正文的uibutton
        UIButton *btnText = [[UIButton alloc] init];
        btnText.titleLabel.font = textFont;
//        [btnText setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        //让按钮内的文字换行
        btnText.titleLabel.numberOfLines = 0;
        btnText.contentEdgeInsets = UIEdgeInsetsMake(15, 20, 15, 20);
        [self.contentView addSubview:btnText];
        self.btnText = btnText;
    }
    //设置单元格的背景色
    self.backgroundColor = [UIColor clearColor];
    
    return self;
}

#pragma mark -- 重写模型的set方法
- (void)setMessageFrame:(LJMMessageFrameModel *)messageFrame
{
    _messageFrame = messageFrame;
    //获取数据模型
    LJMMessageModel *model = messageFrame.messageModel;
    //分别设计每个子控件的数据和frame
    //设置时间label的数据和frame
    self.lblTime.text = model.time;
    self.lblTime.frame = messageFrame.timeFrame;
    self.lblTime.hidden = model.isHideTime;
    
    //设置头像
    NSString *iconImg = model.type == LJMMessageTypeMe ? @"me" : @"other";
    self.imagViewIcon.image = [UIImage imageNamed:iconImg];
    self.imagViewIcon.frame = messageFrame.iconFrame;
    
    //设置消息正文
    [self.btnText setTitle:model.text forState:UIControlStateNormal];
    self.btnText.frame = messageFrame.textFrame;
    
    //设置正文的背景图
    NSString *imgNor , * imgHighlighted;
    if (model.type == LJMMessageTypeMe) {
        //自己发的消息
        imgNor = @"chat_send_nor";
        imgHighlighted = @"chat_send_press_pic";
        [self.btnText setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else
    {
        imgNor = @"chat_recive_nor";
        imgHighlighted = @"chat_recive_press_pic";
        [self.btnText setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    //加载图片
    UIImage *imagNormal = [UIImage imageNamed:imgNor];
    UIImage *imagHighlighted = [UIImage imageNamed:imgHighlighted];
    
    
    /* < 用评估的方式拉伸图片 > */
    imagNormal = [imagNormal stretchableImageWithLeftCapWidth:imagNormal.size.width * 0.5 topCapHeight:imagNormal.size.height * 0.5];
    imagHighlighted = [imagHighlighted stretchableImageWithLeftCapWidth:imagHighlighted.size.width * 0.5 topCapHeight:imagHighlighted.size.width * 0.5];
    
    
    
    //设置背景图
    [self.btnText setBackgroundImage:imagNormal forState:UIControlStateNormal];
    [self.btnText setBackgroundImage:imagHighlighted forState:UIControlStateHighlighted];
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

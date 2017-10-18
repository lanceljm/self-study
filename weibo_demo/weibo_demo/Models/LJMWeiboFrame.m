//
//  LJMWeiboFrame.m
//  weibo_demo
//
//  Created by EPIC_IOS on 2017/10/18.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "LJMWeiboFrame.h"

@implementation LJMWeiboFrame

//重写weibo属性的set方法
- (void)setWeibo:(LJMWeibo *)weibo
{
    _weibo = weibo;
    
    //计算每个控件的frame和行高
    
    CGFloat margin = 10;
    
    //1、头像
    CGFloat icon_w = 35;
    CGFloat icon_h = 35;
    CGFloat icon_x = margin;
    CGFloat icon_y = margin;
    
    _iconFrame = CGRectMake(icon_x, icon_y, icon_w, icon_h);
    
    //2、昵称
    NSString *nickName = weibo.name;
    CGSize nameSize = [self sizeWithText:nickName andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) andFont:nameFont];
    
    CGFloat name_w = nameSize.width;
    CGFloat name_h = nameSize.height;
    CGFloat name_x = CGRectGetMaxX(_iconFrame) + margin;
    CGFloat name_y = icon_y  + (icon_h - name_h) / 2;
    
    _nameFrame = CGRectMake(name_x, name_y, name_w, name_h);
    
    //3、会员
    CGFloat vip_w = 10;
    CGFloat vip_h = 10;
    CGFloat vip_x = CGRectGetMaxX(_nameFrame) + margin;
    CGFloat vip_y = name_y;
    
    _vipFrame = CGRectMake(vip_x, vip_y, vip_w, vip_h);
    
    //4、正文
    CGFloat text_x = icon_x;
    CGFloat text_y = CGRectGetMaxY(_iconFrame) + margin;
    CGSize textSize = [self sizeWithText:weibo.text andMaxSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20 , MAXFLOAT) andFont:textFont];
    CGFloat text_w = textSize.width;
    CGFloat text_h = textSize.height;
    
    _textFrame = CGRectMake(text_x, text_y, text_w, text_h);
    
    //5、配图
    CGFloat picture_w = 100;
    CGFloat picture_h = 100;
    CGFloat picture_x = icon_x;
    CGFloat picture_y = CGRectGetMaxY(_textFrame) + margin;
    
    _pictureFrame = CGRectMake(picture_x, picture_y, picture_w, picture_h);
    
    //6、计算每行的高度
    CGFloat rowHeight = 0;
    if (self.weibo.picture) {
        //如果有配图，那么行高等于配图最大的Y值 + margin
        rowHeight = CGRectGetMaxY(_pictureFrame) + margin;
    }else
    {
        //如果没有配图，那么行高就等于正文的最大Y值 + margin
        rowHeight = CGRectGetMaxY(_textFrame) + margin;
    }
    _rowHeight = rowHeight;
}

#pragma mark -- 根据给定的字符串、最大值的size、给定的字体，计算占用的大小
- (CGSize) sizeWithText : (NSString *) text andMaxSize : (CGSize) maxSize andFont : (UIFont *) font
{
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}


@end

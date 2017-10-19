//
//  LJMMessageFrameModel.m
//  QQ-chat
//
//  Created by EPIC_IOS on 2017/10/19.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "LJMMessageFrameModel.h"
#import <UIKit/UIKit.h>
#import "NSString+LJMNSStringExt.h"

@implementation LJMMessageFrameModel

- (void)setMessageModel:(LJMMessageModel *)messageModel
{
    _messageModel = messageModel;
    
    //计算每个控件的frame和行高
    CGFloat screen_w = [UIScreen mainScreen].bounds.size.width;
    CGFloat screen_h = [UIScreen mainScreen].bounds.size.height;
    
    CGFloat margin = 5;
    //计算时间
    CGFloat time_x = 0;
    CGFloat time_y = 0;
    CGFloat time_w = screen_w;
    CGFloat time_h = 15;
    //如果时间label需要显示，那么再计算label的frame
    if (!messageModel.isHideTime) {
        _timeFrame = CGRectMake(time_x, time_y, time_w, time_h);
    }

    
    //计算头像
    CGFloat icon_w = 30;
    CGFloat icon_h = icon_w;
    CGFloat icon_y = CGRectGetMaxY(_timeFrame) + margin;
    CGFloat icon_x = messageModel.type == LJMMessageTypeOther ? margin : screen_w - margin - icon_w;
    _iconFrame = CGRectMake(icon_x, icon_y, icon_w, icon_h);
    
    //计算正文
    //1、先计算正文的大小
    CGSize textSize = [messageModel.text sizeOfTextWithMaxSize:CGSizeMake(screen_w - margin * 2 - icon_w * 2, MAXFLOAT) andFont:textFont];
    
    //2、计算x
    CGFloat text_w = textSize.width + 40;
    CGFloat text_h = textSize.height + 30;
    CGFloat text_y = icon_y + margin;
    CGFloat text_x = messageModel.type == LJMMessageTypeOther ? (CGRectGetMaxX(_iconFrame) + margin) : (screen_w - margin -icon_w - text_w);
    _textFrame = CGRectMake(text_x, text_y, text_w, text_h);
    
    //计算行高
    //获取头像最大的y值和正文最大的y值,然后用最大的y值加margin
    CGFloat max_y = MAX(CGRectGetMaxY(_textFrame), CGRectGetMaxY(_iconFrame));
    _rowHeight = max_y + margin;
    
    
}

@end

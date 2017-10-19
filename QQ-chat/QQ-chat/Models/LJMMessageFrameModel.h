//
//  LJMMessageFrameModel.h
//  QQ-chat
//
//  Created by EPIC_IOS on 2017/10/19.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@class LJMMessageModel;
@interface LJMMessageFrameModel : NSObject

//引用数据模型
@property (strong , nonatomic) LJMMessageModel  * messageModel;
//时间的frame
@property (assign , nonatomic , readonly) CGRect timeFrame;
//头像的frame
@property (assign , nonatomic , readonly) CGRect iconFrame;
//正文的frame
@property (assign , nonatomic , readonly) CGRect textFrame;
//行高
@property (assign , nonatomic , readonly) CGFloat rowHeight;

@end

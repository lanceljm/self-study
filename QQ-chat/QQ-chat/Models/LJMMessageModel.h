//
//  LJMMessageModel.h
//  QQ-chat
//
//  Created by EPIC_IOS on 2017/10/19.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    LJMMessageTypeMe = 0,/* < 表示自己 > */
    LJMMessageTypeOther = 1/* < 表示对方 > */
} LJMMessageType;

@interface LJMMessageModel : NSObject
/* < 消息正文 > */
@property (strong , nonatomic) NSString  * text;
/* < 消息发送的时间 > */
@property (strong , nonatomic) NSString  * time;
/* < 消息类型 ; 表示自己发送的消息或对方发送的消息> */
@property (assign , nonatomic) LJMMessageType type;

//用来记录是否需要显示时间label
@property (assign , nonatomic) BOOL isHideTime;

- (instancetype) initWithDic : (NSDictionary *) dict;
+ (instancetype) messageWithDic : (NSDictionary *)dict;

@end

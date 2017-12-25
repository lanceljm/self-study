//
//  LJMFriendModel.h
//  friend_tableview
//
//  Created by EPIC_IOS on 2017/10/20.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJMFriendModel : NSString

@property (copy , nonatomic) NSString  * icon;

@property (copy , nonatomic) NSString  * name;

@property (copy , nonatomic) NSString  * title;

@property (assign , nonatomic , getter=isVIP) BOOL vip;\


- (instancetype) initWithDic : (NSDictionary *) dic;
+ (instancetype) friendWithDic : (NSDictionary *) dic;

@end

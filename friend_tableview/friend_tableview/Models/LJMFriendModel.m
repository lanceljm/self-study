//
//  LJMFriendModel.m
//  friend_tableview
//
//  Created by EPIC_IOS on 2017/10/20.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "LJMFriendModel.h"

@implementation LJMFriendModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)friendWithDic:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}

@end

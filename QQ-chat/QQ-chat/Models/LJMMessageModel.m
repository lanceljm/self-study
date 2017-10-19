//
//  LJMMessageModel.m
//  QQ-chat
//
//  Created by EPIC_IOS on 2017/10/19.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "LJMMessageModel.h"

@implementation LJMMessageModel

- (instancetype)initWithDic:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)messageWithDic:(NSDictionary *)dict
{
    return [[self alloc] initWithDic:dict];
}

@end

//
//  LJMWeibo.m
//  weibo_demo
//
//  Created by EPIC_IOS on 2017/10/18.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "LJMWeibo.h"

@implementation LJMWeibo

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)weiboWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end

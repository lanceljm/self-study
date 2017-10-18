//
//  LJMWeibo.h
//  weibo_demo
//
//  Created by EPIC_IOS on 2017/10/18.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJMWeibo : NSObject

@property (copy , nonatomic) NSString  * text;
@property (copy , nonatomic) NSString  * icon;
@property (copy , nonatomic) NSString  * picture;
@property (copy , nonatomic) NSString  * name;

@property (assign , nonatomic , getter=isVIP) BOOL vip;

- (instancetype) initWithDict : (NSDictionary *) dict;
+ (instancetype) weiboWithDict : (NSDictionary *)dict;

@end

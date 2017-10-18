//
//  LJMWeiboFrame.h
//  weibo_demo
//
//  Created by EPIC_IOS on 2017/10/18.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
@class LJMWeibo;
@interface LJMWeiboFrame : NSObject

@property (strong , nonatomic) LJMWeibo  * weibo;

//用来保存头像的frame
@property (assign , nonatomic , readonly) CGRect   iconFrame;

//昵称
@property (assign , nonatomic , readonly) CGRect   nameFrame;

//vip
@property (assign , nonatomic , readonly) CGRect   vipFrame;

//正文
@property (assign , nonatomic , readonly) CGRect   textFrame;

//配图
@property (assign , nonatomic , readonly) CGRect   pictureFrame;

//行高
@property (assign , nonatomic , readonly) CGFloat rowHeight;

@end


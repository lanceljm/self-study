//
//  LJMWeiboCell.h
//  weibo_demo
//
//  Created by EPIC_IOS on 2017/10/18.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LJMWeiboFrame;

@interface LJMWeiboCell : UITableViewCell

@property (strong , nonatomic) LJMWeiboFrame  * weiboFrame;

+ (instancetype) weiboCellWithTableview : (UITableView *) tableview;

@end

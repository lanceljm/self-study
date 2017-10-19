//
//  LJMessageCell.h
//  QQ-chat
//
//  Created by EPIC_IOS on 2017/10/19.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJMessageCell : UITableViewCell

//为单元格增减一个模型属性
@property (nonatomic , strong) LJMMessageFrameModel *messageFrame;

//创建自定义cell的方法
+ (instancetype) messageCellWithTableview :(UITableView *) tableview;

@end

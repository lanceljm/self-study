//
//  RightViewController.h
//  左右联动
//
//  Created by EPIC_IOS on 2017/12/14.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RightViewControllerDelegate <NSObject>

- (void) willDisPlayHeaderView : (NSInteger) section;

- (void) didEndDisPlayHeaderView : (NSInteger) section;

@end



@interface RightViewController : UIViewController

@property (strong , nonatomic) id  <RightViewControllerDelegate> delegate;

/* < 左边的tableview滚动时，右边的tableview跟随滚动到指定section > */
- (void) scrollToSelectedIndexPath : (NSIndexPath *) indexPath;

@end

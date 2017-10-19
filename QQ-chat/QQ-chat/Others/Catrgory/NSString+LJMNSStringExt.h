//
//  NSString+LJMNSStringExt.h
//  QQ-chat
//
//  Created by EPIC_IOS on 2017/10/19.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (LJMNSStringExt)

//对象方法
- (CGSize) sizeOfTextWithMaxSize : (CGSize)maxSize andFont : (UIFont *) andFont;

//类方法
+ (CGSize)sizeWithText : (NSString *)text andMaxSize : (CGSize)maxSize andFont : (UIFont *)andFont;

@end

//
//  NSString+LJMNSStringExt.m
//  QQ-chat
//
//  Created by EPIC_IOS on 2017/10/19.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "NSString+LJMNSStringExt.h"

@implementation NSString (LJMNSStringExt)

- (CGSize)sizeOfTextWithMaxSize:(CGSize)maxSize andFont:(UIFont *)andFont
{
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : andFont} context:nil].size;
}

+ (CGSize)sizeWithText:(NSString *)text andMaxSize:(CGSize)maxSize andFont:(UIFont *)andFont
{
    return [text sizeOfTextWithMaxSize:maxSize andFont:andFont];
}

@end

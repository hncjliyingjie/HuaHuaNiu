//
//  UILabel+LableHeight.h
//  HuaHuaNiu
//
//  Created by YongHeng on 16/8/4.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LableHeight)
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;

+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;
@end

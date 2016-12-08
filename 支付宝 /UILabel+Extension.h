//
//  UILabel+Extension.h
//  ZiChanBao
//
//  Created by liujinliang on 15/6/15.
//  Copyright (c) 2015年 WorldUnion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)

/**
 *  @author King, 15-06-15 11:06:48
 *
 *  获取Label的Size
 *
 *  @param text    <#text description#>
 *  @param font    <#font description#>
 *  @param maxSize <#maxSize description#>
 *
 *  @return <#return value description#>
 */
- (CGSize )sizeOfStringWithMaxHeight:(CGFloat)maxHeight;


/**
 *  设置背景颜色、字体颜色、字体大小、文字对齐方式
 */
- (void)setTextColor:(UIColor *)textColor fontSize:(CGFloat)fontSize textAlignment:(NSTextAlignment)alignment;

/**
 *  背景颜色、字体颜色、字体大小、文字对齐方式
 */
+ (instancetype)labelWithTextColor:(UIColor *)textColor fontSize:(CGFloat)fontSize textAlignment:(NSTextAlignment)alignment;

/**
 *  position、背景颜色、字体颜色、字体大小、文字对齐方式
 */
+ (instancetype)labelWithTextColor:(UIColor *)textColor fontSize:(CGFloat)fontSize textAlignment:(NSTextAlignment)alignment position:(CGPoint)position;

/**
 *  size、背景颜色、字体颜色、字体大小、文字对齐方式
 */
+ (instancetype)labelWithTextColor:(UIColor *)textColor fontSize:(CGFloat)fontSize textAlignment:(NSTextAlignment)alignment size:(CGSize)size;

/**
 *  frame、背景颜色、字体颜色、字体大小、文字对齐方式
 */
+ (instancetype)labelWithTextColor:(UIColor *)textColor fontSize:(CGFloat)fontSize textAlignment:(NSTextAlignment)alignment frame:(CGRect)frame;
@end

//
//  UILabel+Extension.m
//  ZiChanBao
//
//  Created by liujinliang on 15/6/15.
//  Copyright (c) 2015年 WorldUnion. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

/**
 *  @author King, 15-06-15 11:06:32
 *
 *  获取Label的Size
 *
 *  @param text    <#text description#>
 *  @param font    <#font description#>
 *  @param maxSize <#maxSize description#>
 *
 *  @return <#return value description#>
 */
- (CGSize)sizeOfStringWithMaxHeight:(CGFloat)maxHeight {
//    CGSize size=[self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(self.width ,maxHeight) lineBreakMode:NSLineBreakByWordWrapping];
    CGSize size =[self.text boundingRectWithSize:(CGSize){self.frame.size.width, maxHeight} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.font} context:nil].size;
  
    return size;
}

- (void)setTextColor:(UIColor *)textColor fontSize:(CGFloat)fontSize textAlignment:(NSTextAlignment)alignment
{
    self.backgroundColor = [UIColor clearColor];
    self.textColor = textColor ?: [UIColor blackColor];
    self.font = [UIFont systemFontOfSize:fontSize ?: 15];
    self.textAlignment = alignment;
}

+ (instancetype)labelWithTextColor:(UIColor *)textColor fontSize:(CGFloat)fontSize textAlignment:(NSTextAlignment)alignment
{
    UILabel *label = [[UILabel alloc] init];
    [label setTextColor:textColor fontSize:fontSize textAlignment:alignment];
    return label;
}

+ (instancetype)labelWithTextColor:(UIColor *)textColor fontSize:(CGFloat)fontSize textAlignment:(NSTextAlignment)alignment position:(CGPoint)position
{
    UILabel *label = [self labelWithTextColor:textColor fontSize:fontSize textAlignment:alignment];
    label.frame = (CGRect){position, CGSizeZero};
    return label;
}

+ (instancetype)labelWithTextColor:(UIColor *)textColor fontSize:(CGFloat)fontSize textAlignment:(NSTextAlignment)alignment size:(CGSize)size
{
    UILabel *label = [self labelWithTextColor:textColor fontSize:fontSize textAlignment:alignment];
    label.frame = (CGRect){CGPointZero, size};
    return label;
}

+ (instancetype)labelWithTextColor:(UIColor *)textColor fontSize:(CGFloat)fontSize textAlignment:(NSTextAlignment)alignment frame:(CGRect)frame
{
    UILabel *label = [self labelWithTextColor:textColor fontSize:fontSize textAlignment:alignment];
    label.frame = frame;
    return label;
}


@end

//
//  NSString+Utils.h
//  ZJWR
//
//  Created by myqu on 14-8-31.
//  Copyright (c) 2014年 3TI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 *  字符串NSString扩展类别
 */
@interface NSString (Utils)

/**
 *   根据字体大小获取字体的宽高
 *
 *  @param font 字体大小
 *
 *  @return 字符串的宽高
 */
- (CGSize)sizeForStringWithFont:(UIFont*)font;
+ (CGSize)SizeForString:(NSString*)string Font:(UIFont*)font;
+ (CGSize)SizeForString:(NSString*)string Width:(float)width Font:(UIFont*)font;

/**
 *  判断字符串是否为空
 *
 *  @param content <#content description#>
 *  @param error   为空后提示的错误信息
 *
 *  @return 空：Yes  非空：No
 */
//-(BOOL)checkTextWithError:(NSString*)error;

@end

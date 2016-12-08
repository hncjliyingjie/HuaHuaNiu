//
//  NSString+Category.h
//  iOSCodeProject
//
//  Created by zym on 14-7-18.
//  Copyright (c) 2014年 翔傲信息科技（上海）有限公司. All rights reserved.
//


/*
 * NSString常用的一些基础操作拓展。
 */


#import <Foundation/Foundation.h>




/*
 * Short hand NSLocalizedString, doesn't need 2 parameters
 */
#define LocalizedString(s) NSLocalizedString(s,s)

/*
 * LocalizedString with an additionl parameter for formatting
 */
#define LocalizedStringWithFormat(s,...) [NSString stringWithFormat:NSLocalizedString(s,s),##__VA_ARGS__]

enum {
	NSTruncateStringPositionStart=0,
	NSTruncateStringPositionMiddle,
	NSTruncateStringPositionEnd
}; typedef int NSTruncateStringPosition;


@interface NSString (Category)

/**
 *  解密MD5
 *
 *  @return 解密之后的字符串
 */
- (NSString *) stringFromMD5;


/**
 *  返回一个逗号分隔的字符串
 *
 *  @param integer 距离
 *
 *  @return 字符串
 */
+ (NSString*)stringWithFormattedUnsignedInteger:(NSUInteger)integer;


/**
 *  判断字符串中是否包含指定字符串
 *
 *  @param string 指定字符串
 *
 *  @return 布尔值
 */
- (BOOL)containsString:(NSString*)string;


/**
 *  判断字符串中是否包含指定字符串
 *
 *  @param string  指定字符串
 *  @param options 自定义比较选项
 *
 *  @return 布尔值
 */
- (BOOL)containsString:(NSString*)string options:(NSStringCompareOptions)options;


/**
 *  加密MD5
 *
 *  @return 加密之后的字符串
 */
- (NSString*)md5;


/**
 *  数值转换
 *
 *  @return long型
 */
- (long)longValue;


/**
 *  数值转换
 *
 *  @return longlong类型
 */
- (long long)longLongValue;


/**
 *  数值转换
 *
 *  @return unsigned long long类型
 */
- (unsigned long long)unsignedLongLongValue;

/**
 *  截取字符串
 *
 *  @param length 长度
 *
 *  @return 截取后的字符串
 */
- (NSString*)stringByTruncatingToLength:(int)length;

/**
 *  截取字符串
 *
 *  @param length       长度
 *  @param truncateFrom 截取方向
 *
 *  @return 截取后的字符串
 */
- (NSString*)stringByTruncatingToLength:(int)length direction:(NSTruncateStringPosition)truncateFrom;

/**
 *  截取字符串
 *
 *  @param length       长度
 *  @param truncateFrom 截取方向
 *  @param ellipsis     <#ellipsis description#>
 *
 *  @return 截取后的字符串
 */
- (NSString*)stringByTruncatingToLength:(int)length direction:(NSTruncateStringPosition)truncateFrom withEllipsisString:(NSString*)ellipsis;

/**
 *  去掉字符串前后的空格和换行符号
 *
 *  @return 字符串
 */
- (NSString *)stringByDeleteWhitespaceAndWrap;

/**
 *  将字符串快速转化为url
 *
 *  @return 转化之后的NSURL
 */
- (NSURL *)url;

+ (NSString *)fomatterAmountWith:(NSString*)amount;
@end

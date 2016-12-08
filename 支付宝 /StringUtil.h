//
//  StringUtil.h
//  UC_Iphone
//
//  Created by mingyue.qu on 13-8-8.
//
//

#import <Foundation/Foundation.h>

@interface StringUtil : NSObject
/**
 *	@brief	判断字符串是否为空
 *
 *	@param 	str 	需要判断的字符串
 *
 *	@return	字符串是否为空
 */
+ (BOOL)isStringNull:(const NSString*)aString;
/**
 *	@brief	拼一个有特殊字符的字符串
 *
 /n这个方法主要用户模糊查询时要将”%“拼到查询语句里
 *	@param 	formatString 	需要拼得字符串
 *
 *	@return	目的字符串
 */
+(NSString *)formatSearchString:(NSString *)formatString;
/**
 *	@brief	中英文混合字数统计
 *
 *	@param 	strtemp 	需要计算长度的字符串
 *
 *	@return	字符串的中英文混合长度
 */
+ (int)wordCountToInt:(NSString*)strtemp;

/**
 *	@brief	截取某个字符串之前的字符串
 *
 *	@param 	findment 	包含字符串
 *	@param 	scrString 	需要截断的字符串
 *
 *	@return	截取之后的字符串
 */
+(NSString *)interceptContainingString:(NSString *)findment FromString:(NSString *)scrString;

/**
 *	@brief	将长整型的时间转换为距离现在的具体时间
 *
 *	@param 	theDate 	需要转换的时间
 *
 *	@return	具体时间
 */
+ (NSString *)stringFromIntervalSinceNow:(long long)theDate;

/**
 *	@brief	根据字符串的长度获取字符串的高度或者宽度
 *
 *	@param 	string      需要计算的字符串
 *	@param 	fontSize 	字体大小
 *	@param 	maxWidth 	最大宽度
 *	@param 	maxHeight 	最大高度
 *
 *	@return
 */
+ (CGRect)getStringHeightAndWidth:(NSString *)string
                         fontsize:(float)fontSize
                         maxWidth:(float)maxWidth
                        maxHeight:(float)maxHeight;
/**
 * 判断字符串是否含有别的字符串
 * @param string    字符串
 * @param str       被包含的字符串
 * @return          是/否 包含
 */
+ (BOOL)isContain:(NSString *)string searchStr:(NSString *)str;
/**
 *	@brief	将长整形的时间转换为年月日对应的时间
 *
 *	@param 	intervalTime 	需要转换的时间
 *	@param 	dateFormat 	转换后的格式
 *
 *	@return  转换为年月日后的时间
 */
+(NSString *)stringFromInterval:(long long)intervalTime  format:(NSString *)dateFormat;

/**
 *	@brief	根据指定的时分秒，转换为对应的时间
 *
 *	@param 	hour 	修改的时
 *	@param 	minute 	修改的分
 *	@param 	second 	修改的秒
 *
 *	@return	转换后的对应时间
 */
+(NSDate *)dateFromHour:(int)hour minute:(int)minute second:(int)second;


/**
 *	@brief	修改原时间的时分秒
 *
 *	@param 	hour 	修改的时
 *	@param 	minute 	修改的分
 *	@param 	second 	修改的秒
 *	@param 	date 	修改前的时间
 *
 *	@return	修改后的时间
 */
+(NSDate *)changeDateByHour:(int)hour minute:(int)minute second:(int)second sourceDate:(NSDate*)date;


/**
 *	@brief	获取本地某一天的开始时间【当天的零点】或者结束时间【后一天的零点】
 *
 *	@param 	isStartTime 	是否为date的开始时间 YES:即为date当天零点  NO：即为date后一天的零点
 *	@param 	date 	源时间点
 *
 *	@return	date当天的开始时间或者结束时间
 */
+(NSDate *)getLocalStartTime:(BOOL)isStartTime sourceDate:(NSDate*)date;

/**
 *	@brief	将本地时间转为世界标准时间
 *
 *	@param 	localDate 	本地时间
 *
 *	@return	格林威治时间
 */
+(NSDate *)changeToGMTDate:(NSDate *)localDate;

/**
 *	@brief	将日期的时分转换为分钟数
 *
 *	@param 	Date 	日期的格式为“时：分”【没有年月日】
 *
 *	@return	转换后的分钟数
 */
+(int)minuteFromDate:(NSDate *)date;

/**
 *	@brief	以当前时间的下一个整点为准
 *
 *	@param 	minute 	minute分钟一个区分
 *
 *	@return	如现在时间是10:02，区分的minute=5，那返回的时间默认显示为10:05
 */
+(NSDate*)currentTimeByMinute:(int)minute;

/**
 *获得系统日期（返回long）
 *return 当前日期
 */
+ (long)getCurrentDate;

/**
 *	@brief	根据文件URL获取文件类型
 *
 *	@param 	fileUrl 	文件URL
 *
 *	@return	文件类型字符串
 */
+(NSString *)getFileFromUrl:(NSString *)fileUrl;
/**
 *	@brief	修改文件后缀
 *
 *	@param 	filePath 	文件路径
 *
 *	@return	修改后缀后的文件路径
 */
+ (NSString *)changeFileSuffix:(NSString *)filePath;
/**
 *	@brief 判断一个字符串中是否包含某个或某些字符
 *
 *	@param 	specialString  包含的某个或某些字符
 *
 *	@return	检测结果：有某个字符:yes
 */
+(BOOL)isIncludeSpecialCharact: (NSString *)str specialString:(NSString *)specialString;
/**
 *	@brief	字符串的正则匹配
 *
 *	@param 	chekString 	需要匹配的字符串
 *	@param 	predicateString 	正则表达式
 *
 *	@return 检测匹配结果 匹配：yes  不匹配：no
 */
+ (BOOL)regularMatchString:(NSString *)chekString predicateString:(NSString *)predicateString;
/**
 *	@brief	拼http请求参数
 *
 *	@param 	postDic
 *
 *	@return 带有参数的字符串
 */
+ (NSString *)getRequestString:(NSDictionary *)requestDic;
/**
 *	@brief	过滤字符串里的html标签
 *
 *	@param 	html 	含有html标签的字符串
 *
 *	@return	过滤后的字符串
 */
+ (NSString *)filterHTMLLabel:(NSString *)html;

// 读取文件数据
+ (NSMutableDictionary *)readPlistResourceWithFileName:(NSString *)fileName fileType:(NSString *)fileType;

/**
 *	@brief	获取工程文件
 *
 *	@param 	fileName 	文件名称（带后缀）
 *
 *	@return	文件在工程里的保存路径
 */
+ (NSString *)getApplicationFile:(NSString *)fileName;

/**
 *	@brief	检测字符串是否为手机号码
 *
 *	@param 	mobileNum 	需要检测的字符串
 *
 *	@return	是否为手机号码
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

/**
 *	@brief	检测字符串是否为有效的email地址
 *
 *	@param 	emailStr 	需要检测的字符串
 *
 *	@return	是否有效
 */
+ (BOOL)isValidEmail:(NSString *)emailStr;

/**
 *  读取UserDefault的值
 *
 *  @param  读取目标参数的值
 *
 *  @return 该目标值字符串
 */
+(NSString *)readUserDefaults:(NSString *)stringTmp;

/**
 *  写入UserDefault 前面为名称 后面为所对应名称
 *
 *  @param 前面为名称 后面为所对应名称
 *
 *  @return 无返回值
 */
//
+(void)writeUserDefaults:(NSString *)keyTmp  key:(NSString *)stringTmp;
@end

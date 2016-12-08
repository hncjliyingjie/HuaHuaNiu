//
//  StringUtil.m
//  UC_Iphone
//
//  Created by mingyue.qu on 13-8-8.
//
//

#import "StringUtil.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
@implementation StringUtil
/**
 *	@brief	判断字符串是否为空
 *
 *	@param 	str 	需要判断的字符串
 *
 *	@return	判断结果
 */
+ (BOOL)isStringNull:(const NSString*)aString
{
    if ((NSNull *) aString == [NSNull null]) {
        return YES;
    }
    if (aString == nil) {
        return YES;
    } else if ([aString length] == 0) {
        return YES;
    } else {
        aString = [aString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([aString length] == 0) {
            return YES;
        }
    }
    return NO;
    //    return nil == str || 0 == [str length];
}
/**
 *	@brief	拼一个有特殊字符的字符串
 *
 /n这个方法主要用户模糊查询时要将”%“拼到查询语句里
 *	@param 	formatString 	需要拼得字符串
 *
 *	@return	目的字符串
 */
+(NSString *)formatSearchString:(NSString *)formatString
{
    
    NSArray *stringArray = [[NSArray alloc]initWithObjects:@"%",formatString,@"%", nil];
    NSString *targetString =[NSString stringWithFormat:@"%@%@%@",[stringArray objectAtIndex:0],[stringArray objectAtIndex:1],[stringArray objectAtIndex:2]];
    return targetString;
}
/**
 *	@brief	中英文混合字数统计
 *
 *	@param 	strtemp 	需要计算长度的字符串
 *
 *	@return	字符串的中英文混合长度
 */
+ (int)wordCountToInt:(NSString*)strtemp
{
    int i,n = [strtemp length],l=0,a=0,b=0;
    unichar c;
    for(i = 0;i < n;i ++){
        c = [strtemp characterAtIndex:i];
        if(isblank(c)){
            b++;
        }else if(isascii(c)){
            a++;
        }else{
            l++;
        }
    }
    if(a==0 && l==0) return 0;
    return l+(int)ceilf((float)(a+b)/2.0);
}

/**
 *获取当前设备ip地址
 */
+ (NSString *)getIPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

/**
 *	@brief	截取某个字符串之前的字符串
 *
 *	@param 	findment 	包含字符串
 *	@param 	scrString 	需要截断的字符串
 *
 *	@return	截取之后的字符串
 */
+(NSString *)interceptContainingString:(NSString *)findment FromString:(NSString *)scrString
{
    if ([StringUtil isStringNull:scrString])
    {
        return scrString;
    }
    
    NSRange range = [scrString rangeOfString:findment];
    int length = range.length;
    int location = range.location;
    if (length == 0) {
        
        return scrString;
    }
    NSString *resultString = [scrString substringToIndex:location];
    return resultString;
}
/**
 * 将一个字符串数组 连接成一个字符串
 * @param array     字符串数组
 * @param sep       连接字符串
 * @return          连接后的字符串
 */
//+ (NSString *)jion:(NSMutableArray *)array separator:(NSString *)sep
//{
//    NSString *resultString;
//    if (array.count > 0)
//    {
//        NSArray * array2 = [array componentsJoinedByString:sep];//以字符串中的字符作为分割条件进行分割
//    }
//    return resultString;
//}
/**
 *	@brief	将长整型的时间转换为距离现在的具体时间
 *
 *	@param 	theDate 	需要转换的时间
 *
 *	@return	具体时间
 */
+ (NSString *)stringFromIntervalSinceNow:(long long)theDate
{
    NSDate *nowDate = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval nowInterval = [nowDate timeIntervalSince1970] * 1;
    NSString *timeString = @"";
    NSTimeInterval delta = nowInterval - theDate; ///< 两个时间的差量
    
	if (delta/60 < 1)
    {
        if (delta < 0)
        {
            delta = (-1)*delta;
            if (delta < 1)
            {
                delta = 1;
            }
        }
        /// 一分钟以内的时间
        if (delta <30)
        {
            /// 1-30秒按秒显示：xx秒前
            timeString = [NSString stringWithFormat:@"%f", delta];
            timeString = [timeString substringToIndex:timeString.length-7];
            timeString = [NSString stringWithFormat:@"%@秒前", timeString];
        }
        else
        {
            /// 31-60秒按秒显示：1分钟前
            timeString = @"1分钟前";
        }
	}
    else if (delta/3600 < 0.5)
    {
        /// 1-30分钟显示:xx分钟前
        timeString = [NSString stringWithFormat:@"%f", delta/60];
        timeString = [timeString substringToIndex:timeString.length-7];
		if ([timeString isEqualToString:@"-0"] || [timeString isEqualToString:@"0"] || [timeString isEqualToString:@"-1"]) {
			timeString = @"1";
		}
        timeString = [NSString stringWithFormat:@"%@分钟前", timeString];
    }
	else if (delta/3600 > 0.5 && delta/86400 < 1)
    {
        /// 当天的时间显示：00:00
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setDateFormat:@"HH:mm"];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:theDate];
        timeString = [dateFormatter stringFromDate:date];
        
    }
    else if (delta/86400 > 1)
    {
        ///当年的时间
        /// 获取要转换的时间的年月日
		NSDate *date = [NSDate dateWithTimeIntervalSince1970:theDate];
        NSDateFormatter *inform = [[NSDateFormatter alloc] init];
        [inform setDateFormat:@"yyyy/MM/dd"];
        timeString = [inform stringFromDate:date];
        NSArray *temp = [timeString componentsSeparatedByString:@"/"];
        NSString *firstTime = [temp firstObject];
        
        /// 获取当前时间的年月日
        NSDateFormatter *nowInform = [[NSDateFormatter alloc] init];
        [nowInform setDateFormat:@"yyyy/MM/dd"];
        NSString *nowTimeString = [nowInform stringFromDate:nowDate];
        NSArray *tempNow = [nowTimeString componentsSeparatedByString:@"/"];
        NSString *firstTimeNow = [tempNow firstObject];
        
        if (firstTimeNow.intValue - firstTime.intValue < 1)
        {
            /// 当年
            timeString = [NSString stringWithFormat:@"%@/%@",[temp objectAtIndex:1],[temp objectAtIndex:2]];
        }
        else
        {
            /// 去年以前
            timeString = [inform stringFromDate:date];
        }
    }
    return timeString;
}

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
                        maxHeight:(float)maxHeight

{
    CGRect stringRect;
    if ([self isStringNull:string])
    {
        return stringRect;
    }
    NSAttributedString *attributedText =[[NSAttributedString alloc]initWithString:string attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:fontSize]
                                                                                                      }];
    //注：如果想得到宽度的话，size的width应该设为MAXFLOAT。
    stringRect = [attributedText boundingRectWithSize:CGSizeMake(maxWidth, maxHeight)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                              context:nil];
    return stringRect;
}

/**
 * 判断字符串是否含有别的字符串
 * @param string    字符串
 * @param str       被包含的字符串
 * @return          是/否 包含
 */
+ (BOOL)isContain:(NSString *)string searchStr:(NSString *)str
{
    if([self isStringNull:str])
        return NO;
    NSRange foundObj=[string rangeOfString:str options:NSCaseInsensitiveSearch];
    if(foundObj.length > 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+(NSString *)stringFromInterval:(long long)intervalTime  format:(NSString *)dateFormat
{
    /// 获取要转换的时间的年月日
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:intervalTime];
    NSDateFormatter *inform = [[NSDateFormatter alloc] init];
    [inform setDateFormat:dateFormat];
    NSString *timeString = [inform stringFromDate:date];
    return timeString;
}

+(NSDate *)dateFromHour:(int)hour minute:(int)minute second:(int)second
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components =[[NSDateComponents alloc] init];
    [components setHour:hour];
    [components setMinute:minute];
    [components setSecond:second];
    NSDate *date = [calendar dateFromComponents:components];
    return date;
}

+(NSDate *)changeDateByHour:(int)hour minute:(int)minute second:(int)second sourceDate:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    NSDate *newDate = [calendar dateFromComponents:components];
    return newDate;
}

+(NSDate *)getLocalStartTime:(BOOL)isStartTime sourceDate:(NSDate*)date
{
    //要查询某天会议的开始时间的最大值(24点，不包括在内）
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    if(isStartTime == NO) // 获取当天的结束时间【极为后一天的开始时间，因此day+1】
        [components setDay:[components day]+1];
    NSDate *newDate = [calendar dateFromComponents:components];
    return newDate;
}

+(NSDate *)changeToGMTDate:(NSDate *)localDate
{
    // 转换为本地时间
    NSTimeZone *zone = [NSTimeZone  systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:localDate];
    NSDate *gmtDate = [localDate  dateByAddingTimeInterval:interval];
    return gmtDate;
}

+(int)minuteFromDate:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSWeekdayCalendarUnit fromDate:date];
    int hour = [components hour];
    int minute = [components minute];
    int periodTime = hour*60+minute;
    return periodTime;
}

+(NSDate*)currentTimeByMinute:(int)minute
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSWeekdayCalendarUnit fromDate:[NSDate date]];
    int min = [components minute]+minute-[components minute]%minute;
    [components setMinute:min];
    NSDate *date = [calendar dateFromComponents:components];
    return date;
}

/**
 *获得系统日期（返回long）
 *return 当前日期
 */
+ (long )getCurrentDate
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [dat timeIntervalSince1970];
    NSString *time = [NSString stringWithFormat:@"%f",now];
    return time.longLongValue;
}


/**
 *	@brief	获取lable的自适应大小
 *
 *	@param 	font 	字体大小
 *	@param 	content 	内容
 *
 *	@return	自适应宽高
 */
//- (CGSize)sizeWithMyFont:(UIFont *)font text:(NSString *)content
//{
//    // 获取宽度，获取字符串不折行单行显示时所需要的长度
//    CGSize fontSize;
//    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
//
//        // code here for iOS 7.0
//        NSAttributedString *attributedText =[[NSAttributedString alloc]initWithString:content attributes:@{NSFontAttributeName:font
//                                                                                                           }];
//        //注：如果想得到宽度的话，size的width应该设为MAXFLOAT。
//        CGRect rect = [attributedText boundingRectWithSize:CGSizeMake(WIDTH_SCREEN, CELL_HEIGHT)
//                                                   options:NSStringDrawingUsesLineFragmentOrigin
//                                                   context:nil];
//        fontSize = rect.size;
//
//    }
//    else {
//        // code here for iOS 5.0,6.0 and so on
//        //        fontSize = [content sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, CELL_HEIGHT) lineBreakMode:lineBreakMode];
//    }
//    return fontSize;
//}
/**
 *	@brief	根据文件URL获取文件类型
 *
 *	@param 	fileUrl 	文件URL
 *
 *	@return	文件类型字符串
 */
+(NSString *)getFileFromUrl:(NSString *)fileUrl
{
    if ([StringUtil isStringNull:fileUrl])
    {
        return nil;
    }
    NSArray *temp = [fileUrl componentsSeparatedByString:@"/"];
    NSString *fileType = [temp lastObject];
    
    temp = [fileType componentsSeparatedByString:@"."];
    fileType = [temp lastObject];
    
    return fileType;
}

/**
 *	@brief	修改文件后缀
 *
 *	@param 	filePath 	文件路径
 *
 *	@return	修改后缀后的文件路径
 */
+ (NSString *)changeFileSuffix:(NSString *)filePath
{
    NSArray *temp = [filePath componentsSeparatedByString:@"/"];
    NSString *fileName = [temp lastObject];
    NSArray *temp2 = [filePath componentsSeparatedByString:@"."];
    if ([[temp2 lastObject] isEqualToString:@"wav"])
    {
        fileName = [NSString stringWithFormat:@"%@.amr",[temp2 objectAtIndex:0]];
    }
    else if ([[temp2 lastObject] isEqualToString:@"amr"])
    {
        fileName = [NSString stringWithFormat:@"%@.wav",[temp2 objectAtIndex:0]];
    }
    return fileName;
}

/**
 *	@brief 判断一个字符串中是否包含某个或某些字符
 *
 *	@param 	specialString  包含的某个或某些字符
 *
 *	@return	检测结果：有某个字符:yes
 */
+(BOOL)isIncludeSpecialCharact: (NSString *)str specialString:(NSString *)specialString
{
    NSRange urgentRange = [str rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString:specialString]];
    if (urgentRange.location == NSNotFound)
        return NO;
    return YES;
}

/**
 *	@brief	字符串的正则匹配
 *
 *	@param 	chekString 	需要匹配的字符串
 *	@param 	predicateString 	正则表达式
 *
 *	@return 检测匹配结果 匹配：yes  不匹配：no
 */
+ (BOOL)regularMatchString:(NSString *)chekString predicateString:(NSString *)predicateString
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", predicateString];
    if ([predicate evaluateWithObject:chekString] == YES)
        return YES;
    else
        return NO;
}

/**
 *	@brief	拼http请求参数
 *
 *	@param 	postDic
 *
 *	@return 带有参数的字符串
 */
+ (NSString *)getRequestString:(NSDictionary *)requestDic
{
    NSString *requestString;
    NSMutableArray *requestArray = [[NSMutableArray alloc] init];
    for (NSString *keyString in  [requestDic allKeys])
    {
        requestString =[NSString stringWithFormat:@"%@=%@",keyString,[requestDic objectForKey:keyString]];
        [requestArray addObject:requestString];
    }
    requestString = [requestArray componentsJoinedByString:@"&"];
    return requestString;
}

+ (NSString *)filterHTMLLabel:(NSString *)html
{
    if ([self isStringNull:html])
    {
        return nil;
    }
    NSScanner *theScanner;
    NSString *text = nil;
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO)
    {
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        [theScanner scanUpToString:@">" intoString:&text] ;
        html = [html stringByReplacingOccurrencesOfString:
                [NSString stringWithFormat:@"%@>", text]
                                               withString:@""];
    }
    /// 去除掉首尾的空白字符和换行字符
    html = [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return html;
}
// 读取文件数据
+ (NSMutableDictionary *)readPlistResourceWithFileName:(NSString *)fileName fileType:(NSString *)fileType
{
    //    NSMutableArray *arr = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileName ofType:fileType]];
    NSMutableDictionary *resourceDic = [NSMutableDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileName ofType:fileType]];
    return resourceDic;
}

/**
 *	@brief	获取工程文件
 *
 *	@param 	fileName 	文件名称（带后缀）
 *
 *	@return	文件在工程里的保存路径
 */
+ (NSString *)getApplicationFile:(NSString *)fileName
{
    NSArray *aArray = [fileName componentsSeparatedByString:@"."];
    NSString *filename = [aArray objectAtIndex:0];
    NSString *sufix = [aArray objectAtIndex:1];
    return  [[NSBundle mainBundle] pathForResource:filename ofType:sufix];
}
// 判断是否是手机号码
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


+ (BOOL)isValidEmail:(NSString *)emailStr
{
    NSString *Email = @"((?<=^)|(?<=\\s))[-\\w]+([-.]\\w+)*@\\w+([-.]\\w+)*\\.([A-Za-z])+";
    //@"\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*";
    NSPredicate *regextestEmail = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Email];
    
    if ([regextestEmail evaluateWithObject:emailStr] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }

}
// 写入UserDefaultRewit
+(void)writeUserDefaults:(NSString *)keyTmp  key:(NSString *)stringTmp
{
    NSString *token = stringTmp;
    NSUserDefaults *SKUserDefaultRewite = [NSUserDefaults standardUserDefaults];
    [SKUserDefaultRewite setObject:token forKey:keyTmp];
}

// 读取UserDefaultRewit
+(NSString *)readUserDefaults:(NSString *)stringTmp
{
    NSUserDefaults *SKUserDefault = [NSUserDefaults standardUserDefaults];
    NSString *asd = [SKUserDefault objectForKey:stringTmp];
    return asd;
}
@end

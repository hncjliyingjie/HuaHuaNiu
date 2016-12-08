//
//  NSDate+Utils.m
//  iOSCodeProject
//
//  Created by Fox on 14-7-18.
//  Copyright (c) 2014年 翔傲信息科技（上海）有限公司. All rights reserved.
//

#import "NSDate+Utils.h"
#import "NSDateFormatter+Category.h"

#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926


#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]


@implementation NSDate (Utils)

#pragma mark - Date Property


-(NSInteger)numDaysInMonth{
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSRange rng = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self];
    NSUInteger numberOfDaysInMonth = rng.length;
    return numberOfDaysInMonth;
}

#pragma mark - Format Date

+ (NSString *)currentTimeString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    
    return [dateFormatter stringFromDate:[NSDate date]];
}

+ (NSString *)currentFullTimeString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    return [dateFormatter stringFromDate:[NSDate date]];
}

+ (NSString *)currentDetailTimeString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"HH:mm:ss"];
    
    return [dateFormatter stringFromDate:[NSDate date]];
}

+ (NSDate*)dateWithString:(NSString*)dateString formatString:(NSString*)dateFormatterString {
    if(!dateString) return nil;
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormatterString];
    
    NSDate *theDate = [formatter dateFromString:dateString];
    
    return theDate;
}

+ (NSDate*)dateWithDateString:(NSString*)str{
    return [[self class] dateWithString:str formatString:@"yyyy-MM"];
}

+ (NSDate*)dateWithDateTimeString:(NSString*)str{
    return [[self class] dateWithString:str formatString:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSDate*)dateWithDateTimeString:(NSString*)timeStr format:(NSString *)format
{
    return [[self class] dateWithString:timeStr formatString:format];
}

- (NSString *)formatStringWithFormat:(NSString *)formatString{
    
    if (formatString.length == 0) {
        return @"";
    }
    //@"yyyy-MM-dd"
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatString];
    
    return [dateFormatter stringFromDate:self];
}

+ (NSString *)dateFormTimestampString:(NSString *)timestamp{
    
    NSTimeInterval timeInterval = [timestamp doubleValue];
    NSDate *confromTimsp = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:MM:ss"];
    
    return [formatter stringFromDate:confromTimsp];
}

+ (NSString *)dateFormTimestampString:(NSString *)timestamp format:(NSString *)format
{
    NSTimeInterval timeInterval = [timestamp doubleValue];
    NSDate *confromTimsp = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    
    return [formatter stringFromDate:confromTimsp];
}

+ (NSString *)dateFormMoreTimestampString:(NSString *)timestamp format:(NSString *)format
{
    NSTimeInterval timeInterval = [timestamp doubleValue]/1000;
    NSDate *confromTimsp = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:format];
    if(format == nil)
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *dateString = [dateFormatter stringFromDate:confromTimsp];
    return dateString;
}


+ (NSString *)dateFormmterFormSecond:(int)count{
    
    //先计算天数
    int laveCounts = count;
    int days = laveCounts/(60*60*12);
    laveCounts = laveCounts - days*(60*60*12);
    
    //计算小时
    int hours = laveCounts/(60*60);
    laveCounts = laveCounts - hours*(60*60);
    
    //计算分钟
    int minutes = laveCounts/60;
    laveCounts = laveCounts - minutes*60;
    
    //剩余未秒数
    int second = laveCounts;
    
    return [NSString stringWithFormat:@"%d天%d小时%d分%d秒",days,hours,minutes,second];
}

- (NSString*)formattedExactRelativeDate{
    
    NSTimeInterval time = [self timeIntervalSince1970];
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval diff = now - time;
    
    if(diff < 10) {
        return [NSString stringWithFormat:@"just now"];
    } else if(diff < 60) {
        return [NSString stringWithFormat:@"%d seconds ago",(int)diff];
    }
    
    diff = round(diff/60);
    if(diff < 60) {
        if(diff == 1) {
            return [NSString stringWithFormat:@"%d minutes ago",(int)diff];
        } else {
            return [NSString stringWithFormat:@"%d minutes ago",(int)diff];
        }
    }
    
    diff = round(diff/60);
    if(diff < 24) {
        if(diff == 1) {
            return [NSString stringWithFormat:@"%d hours ago",(int)diff];
        } else {
            return [NSString stringWithFormat:@"%d hours ago",(int)diff];
        }
    }
    
    if(diff < 7) {
        if(diff == 1) {
            return @"昨天";
        } else {
            return [NSString stringWithFormat:@"%d days ago", (int)diff];
        }
    }
    
    return [self formattedDateWithFormatString:@"MM/dd/yy"];
}

- (NSString*)formattedDateWithFormatString:(NSString*)dateFormatterString {
    if(!dateFormatterString) return nil;
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormatterString];
    [formatter setAMSymbol:@"am"];
    [formatter setPMSymbol:@"pm"];
    return [formatter stringFromDate:self];
}

+ (NSString *)pastDateString:(int )pageDays{
    
    NSDate *lastDate = [[NSDate date] dateByAddingTimeInterval:pageDays*86400*-1];
    NSMutableString *currentString = [NSMutableString stringWithFormat:@"%@",lastDate];
    return [currentString substringToIndex:10];
}

+ (NSString *)addDateString:(int )pageDays{
    
    NSDate *lastDate = [[NSDate date] dateByAddingTimeInterval:pageDays*86400];
    NSMutableString *currentString = [NSMutableString stringWithFormat:@"%@",lastDate];
    return [currentString substringToIndex:10];
}

+ (NSString *)pastMonthDateString:(int )pastMonth{
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:-1 * pastMonth];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:[NSDate date] options:0];
    NSMutableString *currentString = [NSMutableString stringWithFormat:@"%@",mDate];
    return [currentString substringToIndex:10];
}

#pragma mark - Time comparison

- (BOOL)isPastDate{
    NSDate* now = [NSDate date];
    if([[now earlierDate:self] isEqualToDate:self]) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)isDateToday{
    return [[[NSDate date] midnightDate] isEqual:[self midnightDate]];
}

- (BOOL)isDateYesterday{
    return [[[NSDate dateWithTimeIntervalSinceNow:-86400] midnightDate]
            isEqual:[self midnightDate]];
}

- (NSDate*)midnightDate {
    return [[NSCalendar currentCalendar] dateFromComponents:
            [[NSCalendar currentCalendar] components:
             (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self]];
}

//后加
+ (NSString *)ymmdateFormTimestampString:(NSString *)timestamp{
    
    NSTimeInterval timeInterval = [timestamp doubleValue];
    NSDate *confromTimsp = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    return [formatter stringFromDate:confromTimsp];
}

//后加
+ (NSString *)homeNewsdateFormTimestampString:(NSString *)timestamp{
    
    NSTimeInterval timeInterval = [timestamp doubleValue];
    NSDate *confromTimsp = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    return [formatter stringFromDate:confromTimsp];
}

#pragma mark -- 环信使用数据
/*距离当前的时间间隔描述*/
- (NSString *)timeIntervalDescription
{
    NSTimeInterval timeInterval = -[self timeIntervalSinceNow];
    if (timeInterval < 60) {
        return NSLocalizedString(@"NSDateCategory.text1", @"");
    } else if (timeInterval < 3600) {
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text2", @""), timeInterval / 60];
    } else if (timeInterval < 86400) {
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text3", @""), timeInterval / 3600];
    } else if (timeInterval < 2592000) {//30天内
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text4", @""), timeInterval / 86400];
    } else if (timeInterval < 31536000) {//30天至1年内
        NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatterWithFormat:NSLocalizedString(@"NSDateCategory.text5", @"")];
        return [dateFormatter stringFromDate:self];
    } else {
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text6", @""), timeInterval / 31536000];
    }
}

/*精确到分钟的日期描述*/
- (NSString *)minuteDescription
{
    NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"yyyy-MM-dd"];
    
    NSString *theDay = [dateFormatter stringFromDate:self];//日期的年月日
    NSString *currentDay = [dateFormatter stringFromDate:[NSDate date]];//当前年月日
    if ([theDay isEqualToString:currentDay]) {//当天
        [dateFormatter setDateFormat:@"ah:mm"];
        return [dateFormatter stringFromDate:self];
    } else if ([[dateFormatter dateFromString:currentDay] timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] == 86400) {//昨天
        [dateFormatter setDateFormat:@"ah:mm"];
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text7", @'"'), [dateFormatter stringFromDate:self]];
    } else if ([[dateFormatter dateFromString:currentDay] timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] < 86400 * 7) {//间隔一周内
        [dateFormatter setDateFormat:@"EEEE ah:mm"];
        return [dateFormatter stringFromDate:self];
    } else {//以前
        [dateFormatter setDateFormat:@"yyyy-MM-dd ah:mm"];
        return [dateFormatter stringFromDate:self];
    }
}

/*标准时间日期描述*/
-(NSString *)formattedTime{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString * dateNow = [formatter stringFromDate:[NSDate date]];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:[[dateNow substringWithRange:NSMakeRange(8,2)] intValue]];
    [components setMonth:[[dateNow substringWithRange:NSMakeRange(5,2)] intValue]];
    [components setYear:[[dateNow substringWithRange:NSMakeRange(0,4)] intValue]];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:components]; //今天 0点时间
    
    NSInteger hour = [self hoursAfterDate:date];
    NSDateFormatter *dateFormatter = nil;
    NSString *ret = @"";
    
    //hasAMPM==TURE为12小时制，否则为24小时制
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM = containsA.location != NSNotFound;
    
    if (!hasAMPM) { //24小时制
        if (hour <= 24 && hour >= 0) {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"HH:mm"];
        }else if (hour < 0 && hour >= -24) {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:NSLocalizedString(@"NSDateCategory.text8", @"")];
        }else {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"yyyy-MM-dd HH:mm"];
        }
    }else {
        if (hour >= 0 && hour <= 6) {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:NSLocalizedString(@"NSDateCategory.text9", @"")];
        }else if (hour > 6 && hour <=11 ) {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:NSLocalizedString(@"NSDateCategory.text10", @"")];
        }else if (hour > 11 && hour <= 17) {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:NSLocalizedString(@"NSDateCategory.text11", @"")];
        }else if (hour > 17 && hour <= 24) {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:NSLocalizedString(@"NSDateCategory.text12", @"")];
        }else if (hour < 0 && hour >= -24){
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:NSLocalizedString(@"NSDateCategory.text13", @"")];
        }else  {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"yyyy-MM-dd HH:mm"];
        }
    }
    
    ret = [dateFormatter stringFromDate:self];
    return ret;
}

/*格式化日期描述*/
- (NSString *)formattedDateDescription
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *theDay = [dateFormatter stringFromDate:self];//日期的年月日
    NSString *currentDay = [dateFormatter stringFromDate:[NSDate date]];//当前年月日
    
    NSInteger timeInterval = -[self timeIntervalSinceNow];
    if (timeInterval < 60) {
        return NSLocalizedString(@"NSDateCategory.text1", @"");
    } else if (timeInterval < 3600) {//1小时内
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text2", @""), timeInterval / 60];
    } else if (timeInterval < 21600) {//6小时内
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text3", @""), timeInterval / 3600];
    } else if ([theDay isEqualToString:currentDay]) {//当天
        [dateFormatter setDateFormat:@"HH:mm"];
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text14", @""), [dateFormatter stringFromDate:self]];
    } else if ([[dateFormatter dateFromString:currentDay] timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] == 86400) {//昨天
        [dateFormatter setDateFormat:@"HH:mm"];
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text7", @""), [dateFormatter stringFromDate:self]];
    } else {//以前
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        return [dateFormatter stringFromDate:self];
    }
}

- (double)timeIntervalSince1970InMilliSecond {
    double ret;
    ret = [self timeIntervalSince1970] * 1000;
    
    return ret;
}

+ (NSDate *)dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond {
    NSDate *ret = nil;
    double timeInterval = timeIntervalInMilliSecond;
    // judge if the argument is in secconds(for former data structure).
    if(timeIntervalInMilliSecond > 140000000000) {
        timeInterval = timeIntervalInMilliSecond / 1000;
    }
    ret = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    return ret;
}

+ (NSString *)formattedTimeFromTimeInterval:(long long)time{
    return [[NSDate dateWithTimeIntervalInMilliSecondSince1970:time] formattedTime];
}

#pragma mark Relative Dates

+ (NSDate *) dateWithDaysFromNow: (NSInteger) days
{
    // Thanks, Jim Morrison
    return [[NSDate date] dateByAddingDays:days];
}

+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days
{
    // Thanks, Jim Morrison
    return [[NSDate date] dateBySubtractingDays:days];
}

+ (NSDate *) dateTomorrow
{
    return [NSDate dateWithDaysFromNow:1];
}

+ (NSDate *) dateYesterday
{
    return [NSDate dateWithDaysBeforeNow:1];
}

+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

#pragma mark Comparing Dates

- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}

- (BOOL) isToday
{
    return [self isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL) isTomorrow
{
    return [self isEqualToDateIgnoringTime:[NSDate dateTomorrow]];
}

- (BOOL) isYesterday
{
    return [self isEqualToDateIgnoringTime:[NSDate dateYesterday]];
}

// This hard codes the assumption that a week is 7 days
- (BOOL) isSameWeekAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
    
    // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
    if (components1.week != components2.week) return NO;
    
    // Must have a time interval under 1 week. Thanks @aclark
    return (fabs([self timeIntervalSinceDate:aDate]) < D_WEEK);
}

- (BOOL) isThisWeek
{
    return [self isSameWeekAsDate:[NSDate date]];
}

- (BOOL) isNextWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self isSameWeekAsDate:newDate];
}

- (BOOL) isLastWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self isSameWeekAsDate:newDate];
}

// Thanks, mspasov
- (BOOL) isSameMonthAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:aDate];
    return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}

- (BOOL) isThisMonth
{
    return [self isSameMonthAsDate:[NSDate date]];
}

- (BOOL) isSameYearAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:aDate];
    return (components1.year == components2.year);
}

- (BOOL) isThisYear
{
    // Thanks, baspellis
    return [self isSameYearAsDate:[NSDate date]];
}

- (BOOL) isNextYear
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:[NSDate date]];
    
    return (components1.year == (components2.year + 1));
}

- (BOOL) isLastYear
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:[NSDate date]];
    
    return (components1.year == (components2.year - 1));
}

- (BOOL) isEarlierThanDate: (NSDate *) aDate
{
    return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL) isLaterThanDate: (NSDate *) aDate
{
    return ([self compare:aDate] == NSOrderedDescending);
}

// Thanks, markrickert
- (BOOL) isInFuture
{
    return ([self isLaterThanDate:[NSDate date]]);
}

// Thanks, markrickert
- (BOOL) isInPast
{
    return ([self isEarlierThanDate:[NSDate date]]);
}


#pragma mark Roles
- (BOOL) isTypicallyWeekend
{
    NSDateComponents *components = [CURRENT_CALENDAR components:NSWeekdayCalendarUnit fromDate:self];
    if ((components.weekday == 1) ||
        (components.weekday == 7))
        return YES;
    return NO;
}

- (BOOL) isTypicallyWorkday
{
    return ![self isTypicallyWeekend];
}

#pragma mark Adjusting Dates

- (NSDate *) dateByAddingDays: (NSInteger) dDays
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_DAY * dDays;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *) dateBySubtractingDays: (NSInteger) dDays
{
    return [self dateByAddingDays: (dDays * -1)];
}

- (NSDate *) dateByAddingHours: (NSInteger) dHours
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *) dateBySubtractingHours: (NSInteger) dHours
{
    return [self dateByAddingHours: (dHours * -1)];
}

- (NSDate *) dateByAddingMinutes: (NSInteger) dMinutes
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *) dateBySubtractingMinutes: (NSInteger) dMinutes
{
    return [self dateByAddingMinutes: (dMinutes * -1)];
}

- (NSDate *) dateAtStartOfDay
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [CURRENT_CALENDAR dateFromComponents:components];
}

- (NSDateComponents *) componentsWithOffsetFromDate: (NSDate *) aDate
{
    NSDateComponents *dTime = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate toDate:self options:0];
    return dTime;
}

#pragma mark Retrieving Intervals

- (NSInteger) minutesAfterDate: (NSDate *) aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger) minutesBeforeDate: (NSDate *) aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger) hoursAfterDate: (NSDate *) aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_HOUR);
}

- (NSInteger) hoursBeforeDate: (NSDate *) aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_HOUR);
}

- (NSInteger) daysAfterDate: (NSDate *) aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_DAY);
}

- (NSInteger) daysBeforeDate: (NSDate *) aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_DAY);
}

// Thanks, dmitrydims
// I have not yet thoroughly tested this
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit fromDate:self toDate:anotherDate options:0];
    return components.day;
}

#pragma mark Decomposing Dates

- (NSInteger) nearestHour
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * 30;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    NSDateComponents *components = [CURRENT_CALENDAR components:NSHourCalendarUnit fromDate:newDate];
    return components.hour;
}

- (NSInteger) hour
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.hour;
}

- (NSInteger) minute
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.minute;
}

- (NSInteger) seconds
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.second;
}

- (NSInteger) day
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.day;
}

- (NSInteger) month
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.month;
}

- (NSInteger) week
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.week;
}

- (NSInteger) weekday
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.weekday;
}

- (NSInteger) nthWeekday // e.g. 2nd Tuesday of the month is 2
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.weekdayOrdinal;
}

- (NSInteger) year
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.year;
}

//后加，判断日期是星期几
+(NSString *)WeekForDay:(int)year mon:(int)month day:(int)day
{
    NSString *weekDayStr = @"";
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:year];
    [comps setMonth:month];
    [comps setDay:day];
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *_date = [gregorian dateFromComponents:comps];
    NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:_date];
    int week = (int)[weekdayComponents weekday];
    //week ++;
    switch (week) {
        case 1:
            weekDayStr = @"星期日";
            break;
        case 2:
            weekDayStr = @"星期一";
            break;
        case 3:
            weekDayStr = @"星期二";
            break;
        case 4:
            weekDayStr = @"星期三";
            break;
        case 5:
            weekDayStr = @"星期四";
            break;
        case 6:
            weekDayStr = @"星期五";
            break;
        case 7:
            weekDayStr = @"星期六";
            break;
        default:
            weekDayStr = @"";
            break;
    }
    return weekDayStr;
}
@end

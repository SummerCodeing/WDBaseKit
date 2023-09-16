//
//  NSString+Time.h
//
//
//  Copyright © 2017年 summer. All rights reserved.
//  时间处理

#import <Foundation/Foundation.h>

@interface NSString (Time)

///获取当前时间
+(NSString *)getCurrentDateWithFormat:(NSString *)format;

///获取当前时间 ms 为单位
+(NSString *)getNowTimeforMsec;


/**
 获取指定时间的时间戳

 @param year 指定的年
 @param month 指定的约
 @param day 指定的天
 @param hour 指定的小时
 @param minute 指定的分
 @param second 指定的秒
 @return 时间戳
 */
+ (NSTimeInterval )getSelectTimeForMsecWithYear:(NSInteger)year
                                          month:(NSInteger)month
                                            day:(NSInteger)day
                                           hour:(NSInteger)hour
                                         minute:(NSInteger)minute
                                         second:(NSInteger)second;


+(NSString *)getNowTimeTimestamp;

+(NSString *)zeroCurrentDayOfDate;
+(NSString *)zeroOfDate:(NSUInteger)timeStemp;
///字符串转日期
-(NSDate *)stringToDateWithFormat:(NSString *)format;

///时间戳转标准时间
+(NSString *)timeStempToBaseTime:(long long )timeStemp;

/**
 时间戳--->转 标准时间
 @param timeStemp 待转换的时间(long long 类型)
 @param formatStr 时间格式
 */
+(NSString *)timeStempToBaseTime:(long long )timeStemp Format:(NSString *)formatStr;



/**
 标准时间--->转 时间戳

 @param baseTime 待转换的标准时间
 @param formatStr 日期时间格式
 @return 时间戳
 */
+(NSUInteger)baseTimeToTimestamp:(NSString *)baseTime format:(NSString *)formatStr;


///date转指定日期格式
+(NSString *)dateFormatString:(NSString *)format date:(NSDate *)date;

/**
 计算指定的两个时间的差值

 @param startTime 开始时间:格式2017-06-23 12:18:15
 @param endTime 结束时间:格式2017-06-23 12:18:18
 @param callback 差
 */
+ (void)datePoorWithStatrTime:(NSString *)startTime
                      endTime:(NSString *)endTime
                     callback:(void (^)(NSString * timePoor))callback;
/**
 计算指定的两个时间的差(天)

 @param startStamp 开始时间时间戳
 @param endStamp 结束时间时间戳
 @return 差（天）
 */
+ (NSInteger)caculateDatePoorWithStatrTime:(NSInteger)startStamp
                      endTime:(NSInteger)endStamp;
/**
 计算秒对应的时间

 @param seconds 秒
 @param callback 回调
 */
+ (void)caculateTimeFromSecond:(NSInteger)seconds
                      callback:(void (^)(NSString * timeStr))callback;
/**
 计算指定的两个时间的差值
 
 @param startTime 开始时间:格式2017-06-23 12:18:15
 @param endTime 结束时间:格式2017-06-23 12:18:18
 */
+ (NSString*)datePoorWithStatrTime:(NSString *)startTime
                      endTime:(NSString *)endTime;
/**
 获取上月今天的日期

 @param callback 上月今天的日期
 */
+ (void)getLastMouthWithtoday:(void (^)(NSString *lastMonth))callback;

/**
 出生日期转换为年龄

 @param birthday 出生日期
 @return 年龄
 */
+(NSString *)birthdayToAge:(NSString *)birthday;

/**
时间转 昨天 *月*日  指定格式

 @param time 需要判断的时间
 @param callBack 结果
 */
+(void)dateSwitchToSpecify:(NSString *)time callBack:(void(^)(NSString *timeStr))callBack;

/**
 获取输入时间的下一秒

 @param time 输入时间 格式@"yyyy-MM-dd HH:mm:ss"
 @return 输出 下一秒时间  @"yyyy-MM-dd HH:mm:ss"
 */
+(NSString *)getNextSecondForTime:(NSString *)time;//输出当前时间的上一秒
/**
 获取输入时间的上一秒

 @param time 输入时间 格式@"yyyy-MM-dd HH:mm:ss"
 @return 输出 上一秒时间  @"yyyy-MM-dd HH:mm:ss"
 */
+(NSString *)getLastSecondForTime:(NSString *)time;

/**
 输出当前时间前后指定秒数

 @param time 输入时间 格式@"yyyy-MM-dd HH:mm:ss"
 @param addTime 时间增量
 @return 变化后的时间  格式@"yyyy-MM-dd HH:mm:ss"
 */
+(NSString *)getAppointFormTime:(NSString *)time addTimeInterval:(NSTimeInterval) addTime;

///转换成年月日
+(NSString *)timeChangeToChinese:(NSString *)time;


/**
 根据标准日期计算星期几

 @param timeSr 基础时间 YYYY-MM-dd HH:mm
 @return 星期几
 */
+ (NSString *)getWeekWithTime:(NSString *)timeSr;


/**
 根据标准时间计算出星期和星期的下标

 @param baseTime 基础时间 YYYY-MM-dd HH:mm
 @param callBack 星期和下标
 */
+ (void)getWeekDayWithBaseTime:(NSString *)baseTime
                      callBack:(void(^)(NSString *weekStr,NSInteger weekInteger))callBack;

/**
 上周
 */
+ (NSString*)lastWeekTimeFrowNow;
/**
 上个月
 */
+ (NSString*)lastMonthTimeFrowNow;

/**
 某时间后N月
 */
+ (NSString*)afterNMonth:(NSInteger)month withStartDate:(NSString *)dateString;
/**
某时间后N天
*/
+(NSString *)afterNDay:(NSInteger)day withStartDate:(NSString *)dateString;

/**
某具体后N天
*/
+(NSString *)afterN2Day:(NSInteger)day withStartDate:(NSString *)dateString;
@end

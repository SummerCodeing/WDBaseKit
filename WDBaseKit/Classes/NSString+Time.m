//
//  NSString+Time.m
//  summer
//
//  Copyright © 2017年 summer. All rights reserved.
//

#import "NSString+Time.h"
#import "WDBaseKitHeader.h"

@implementation NSString (Time)

///获取当前时间
+(NSString *)getCurrentDateWithFormat:(NSString *)format{
    NSDate *senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:format];
    NSString * locationString=[dateformatter stringFromDate:senddate];
    return locationString;
}
///时间戳转标准时间
+(NSString *)timeStempToBaseTime:(long long)timeStemp{
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeStemp/1000];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
    return [formatter stringFromDate:date];
}

#pragma mark -- 时间戳--->标准时间 --
//时间戳转标准时间
+(NSString *)timeStempToBaseTime:(long long )timeStemp Format:(NSString *)formatStr
{
    if (timeStemp==0) {
        return @"";
    }
	long long tempTime = timeStemp;
	if (tempTime>1000000000000) {
		tempTime = tempTime/1000;
	}
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:tempTime];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    if (formatStr) {
        [formatter setDateFormat:formatStr];
    }else{
        [formatter setDateFormat:@"yyyyMMdd_HHmmss"];
    }
    return [formatter stringFromDate:date];
}

#pragma mark -- 标准时间--->时间戳 --
//标准时间--->时间戳
+(NSUInteger)baseTimeToTimestamp:(NSString *)baseTime format:(NSString *)formatStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];//设置为本地时区
    if (formatStr) {
        [formatter setDateFormat:formatStr];
    }else{
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    NSDate *tempDate = [formatter dateFromString:baseTime];
    NSUInteger timeStamp = [[NSNumber numberWithDouble:[tempDate timeIntervalSince1970]*1000] integerValue];
    return timeStamp;
}

#pragma mark -- date转指定日期格式 --
+ (NSString *)dateFormatString:(NSString *)format date:(NSDate *)date{
    if (kStringIsEmpty(format)) {
        format = @"yyyy-MM-dd HH:mm:ss";
    }
    if (date==nil) {
        date = [NSDate date];
    }
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:format];
    NSString *locationString=[dateformatter stringFromDate:date];
    return locationString;
}
///字符串转日期
-(NSDate *)stringToDateWithFormat:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    return  [formatter dateFromString:self];
}

///获取当前时间 ms 为单位
+(NSString *)getNowTimeforMsec{
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
  [formatter setDateStyle:NSDateFormatterMediumStyle];
  [formatter setTimeStyle:NSDateFormatterShortStyle]; // 设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制 //YYYY-MM-dd HH:mm:ss SSS [formatter setDateFormat:@"HH:mm:ss SSS"]; //设置时区,这个对于时间的处理有时很重要
  NSTimeZone* timeZone = [NSTimeZone systemTimeZone];
  [formatter setTimeZone:timeZone];
  NSDate *datenow = [NSDate date];//现在时间
  NSString *timeSp = [NSString stringWithFormat:@"%lld", (long long)[datenow timeIntervalSince1970]*1000];
//  NSNumber *timeNumber=[NSNumber n:(long)[datenow timeIntervalSince1970]*1000];
  return timeSp;
}

/**
 获取指定时间的时间戳
 */
+ (NSTimeInterval )getSelectTimeForMsecWithYear:(NSInteger)year
                                      month:(NSInteger)month
                                        day:(NSInteger)day
                                       hour:(NSInteger)hour
                                     minute:(NSInteger)minute
                                     second:(NSInteger)second
{
    NSDate *currentDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSUIntegerMax fromDate:currentDate];
    if (year>=0) {
        components.year = year;
    }
    if (month>=0) {
        components.month = month;
    }
    if (day>=0) {
        components.day = day;
    }
    if (hour>=0) {
        components.hour = hour;
    }
    if (minute>=0) {
        components.minute = minute;
    }
    if (second>=0) {
        components.second = second;
    }
    NSTimeInterval ts = (double)(int)[[calendar dateFromComponents:components] timeIntervalSince1970];
    return ts * 1000;
}


+ (NSString *)getNowTimeTimestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // 设置格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    return timeSp;
}

+ (NSString *)zeroCurrentDayOfDate{
    NSDate *currentDate = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:currentDate];
    NSDate *localeDate = [currentDate dateByAddingTimeInterval:interval];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSUIntegerMax fromDate:localeDate];
//    components.hour = 0;
//    components.minute = 0;
//    components.second = 0;
    NSTimeInterval ts = (double)(int)[[calendar dateFromComponents:components] timeIntervalSince1970];
    return[NSString stringWithFormat:@"%ld", (long)ts];
}
+(NSString *)zeroOfDate:(NSUInteger)timeStemp{
    NSDate *currentDate = [NSDate dateWithTimeIntervalSince1970:timeStemp];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSUIntegerMax fromDate:currentDate];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    NSTimeInterval ts = (double)(int)[[calendar dateFromComponents:components] timeIntervalSince1970];
    return[NSString stringWithFormat:@"%ld", (long)ts];;
}
//计算指定时间的时间差
+ (void)datePoorWithStatrTime:(NSString *)startTime
                      endTime:(NSString *)endTime
                     callback:(void (^)(NSString * timePoor))callback
{
	NSString *str = [self datePoorWithStatrTime:startTime endTime:endTime];
	callback(str);
}
+ (NSInteger)caculateDatePoorWithStatrTime:(NSInteger)startStamp endTime:(NSInteger)endStamp{
	if (startStamp > 1000000000000) {
		startStamp = startStamp/1000;
	}
	if (endStamp > 1000000000000) {
		endStamp = endStamp/1000;
	}
    NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:startStamp];
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:endStamp];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date2];
    NSDate *localeDate = [date2 dateByAddingTimeInterval:interval];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit type = NSCalendarUnitDay;
    // 4.利用日历对象比较两个时间的差值
    NSDateComponents *cmps = [calendar components:type fromDate:date1 toDate:localeDate options:NSCalendarMatchFirst];
    if (cmps.hour > 0 || cmps.minute > 0 || cmps.second > 0) {
        return cmps.day + 1;
    }else{
        return cmps.day;
    }
}
//计算秒数对应的时间
+ (void)caculateTimeFromSecond:(NSInteger)seconds
      callback:(void (^)(NSString * timeStr))callback{
    NSInteger d = seconds / (24*60*60);
    NSInteger h = seconds % (24*60*60) / (60*60);
    NSInteger m = seconds % (24*60*60) % (60*60) / 60;
    NSInteger s = seconds % (24*60*60) % (60*60) % 60;
    NSString *time;
    if (d > 0){
        time = [NSString stringWithFormat:@"%ld日%ld小时%02ld分%02ld秒",d,h,m,s];
    } else if (h > 0){
        time = [NSString stringWithFormat:@"%ld小时%02ld分%02ld秒",h,m,s];
    } else if (m > 0){
        time = [NSString stringWithFormat:@"%02ld分%02ld秒",m,s];
    } else if (s > 0){
        time = [NSString stringWithFormat:@"%02ld秒",s];
    }
    if (callback){
        callback(time);
    }
}
//计算指定时间的时间差
+ (NSString*)datePoorWithStatrTime:(NSString *)startTime endTime:(NSString *)endTime{
    if (kStringIsEmpty(startTime)||kStringIsEmpty(endTime)) {
        return @"0";
    }
        // 1.确定时间
        //    NSString *time1 = @"2015-06-23 12:18:15";
        //    NSString *time2 = @"2015-06-23 10:10:10";
        // 2.将时间转换为date
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSDate *date1 = [formatter dateFromString:startTime];
        NSDate *date2 = [formatter dateFromString:endTime];
        // 3.创建日历
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSCalendarUnit type = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        // 4.利用日历对象比较两个时间的差值
        NSDateComponents *cmps = [calendar components:type fromDate:date1 toDate:date2 options:0];
        // 5.输出结果
        NSString * str = @"0";
        if (cmps.month==0 && cmps.day != 0) {
            if (cmps.day == 1) {
                long newHour = cmps.day * 24 + cmps.hour;
                str = [NSString stringWithFormat:@"%ld小时%ld分%ld秒",newHour, (long)cmps.minute, (long)cmps.second];
            } else {
                str = [NSString stringWithFormat:@"%ld日%ld小时%ld分%ld秒",(long)cmps.day, (long)cmps.hour, (long)cmps.minute, (long)cmps.second];
            }
        }if (cmps.month==0 && cmps.day==0 && cmps.hour != 0) {
            str = [NSString stringWithFormat:@"%ld小时%ld分%ld秒",(long)cmps.hour, (long)cmps.minute, (long)cmps.second];
        }else if (cmps.month==0 && cmps.day==0 && cmps.hour ==0 && cmps.minute != 0){
            str = [NSString stringWithFormat:@"%ld分%ld秒", (long)cmps.minute, (long)cmps.second];
        }else if (cmps.month==0 && cmps.day==0 && cmps.hour ==0 && cmps.minute == 0){
            if (cmps.second==0) {
                str = [NSString stringWithFormat:@"%ld秒",(long)cmps.second];
            }else{
                str = [NSString stringWithFormat:@"%ld秒",(long)cmps.second];
            }
        }else if (cmps.second == 0){
            str = [NSString stringWithFormat:@"%ld",(long)cmps.nanosecond];
        }
      return str;
}
//获取上月今天的日期
+ (void)getLastMouthWithtoday:(void (^)(NSString *lastMonth))callback
{
    //获取当前日期
    NSString *timeStr = [NSString getCurrentDateWithFormat:@"yyyy-MM-dd"];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    NSDate *data = [format dateFromString:timeStr];
    //利用NSCalendar处理日期
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger year = [calendar component:NSCalendarUnitYear fromDate:data];
    NSInteger mouth = [calendar component:NSCalendarUnitMonth fromDate:data];
    NSInteger day = [calendar component:NSCalendarUnitDay fromDate:data];
    if (mouth <= 12 && mouth>1) {
        callback([NSString stringWithFormat:@"%ld-%02ld-%02ld",(long)year,(mouth-1),(long)day]);
    }else if (mouth==1){
        callback([NSString stringWithFormat:@"%ld-12-%02ld",(long)year-1,(long)day]);
    }
}
//生日转年龄
+(NSString *)birthdayToAge:(NSString *)birthday
{
    if (!birthday) {
        return @"0";
    }
	//获取当前时间
	NSString *nowTime = [self getCurrentDateWithFormat:@"yyyy"];
	birthday = [NSString deleteWhiteSpaceHeadAndFoot:birthday];
	NSString *birthYear=[birthday substringWithRange:NSMakeRange(0, 4)];
	return [NSString stringWithFormat:@"%ld",([nowTime integerValue]-[birthYear integerValue])];
}
///时间转 昨天 *月*日  指定格式
+(void)dateSwitchToSpecify:(NSString *)time callBack:(void(^)(NSString *timeStr))callBack
{
	// 1.确定时间
//		time = @"2017-07-31 12:18:15";
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
	NSDate *date= [formatter dateFromString:time];
	//获取日历
	NSCalendar *clendar = [NSCalendar currentCalendar];
	NSCalendarUnit type = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
	NSDateComponents *cmpsTime = [clendar components:type fromDate:date];
	NSDateComponents *cmpsNow = [clendar components:type fromDate:[NSDate date]];
    NSString *timeStr=@"";
	//判断年
	if (cmpsNow.year==cmpsTime.year) {
		//判断月
		if (cmpsTime.month==cmpsNow.month) {
			//今天
			if (cmpsTime.day==cmpsNow.day) {
				timeStr = [NSString stringWithFormat:@"%02ld:%02ld",(long)cmpsTime.hour,(long)cmpsTime.minute];
			}
			//昨天
			else if (cmpsNow.day-cmpsTime.day==1) {
				timeStr = [NSString stringWithFormat:@"昨天 %02ld:%02ld",(long)cmpsTime.hour,(long)cmpsTime.minute];
			}else{
				timeStr=[NSString stringWithFormat:@"%ld月%ld日",(long)cmpsTime.month,(long)cmpsTime.day];
			}
		}
		else
		{
			///不同月需判断是当前时间否是1号  并且 传入时间是否在28到30号之间
			if (cmpsNow.day==1&&cmpsTime.day>=28) {
				///区分月份
				NSInteger totalDay=31;
				//28 29天
				if (cmpsTime.month==2)
				{
					//平年闰年
					if (cmpsTime.year%4==0&&cmpsTime.year%100!=0) {
						totalDay=29;
					} else {
						totalDay =28;
					}
				}
				//30天
				else if(cmpsTime.month==4||cmpsTime.month==6||cmpsTime.month==9||cmpsTime.month==11)
				{
					totalDay =30;
				}
		
				if (cmpsTime.day==totalDay) {
					timeStr = [NSString stringWithFormat:@"昨天 %02ld:%02ld",(long)cmpsTime.hour,(long)cmpsTime.minute];

				}
				else
				{
					timeStr=[NSString stringWithFormat:@"%ld月%ld日",(long)cmpsTime.month,(long)cmpsTime.day];
				}
			}
			else
			{
       timeStr=[NSString stringWithFormat:@"%ld月%ld日",(long)cmpsTime.month,(long)cmpsTime.day];
			}
		}
	}
	else {
		
	timeStr=[NSString stringWithFormat:@"%ld年%ld月%ld日",(long)cmpsTime.year,(long)cmpsTime.month,(long)cmpsTime.day];
		
	}
	callBack(timeStr);
}
//输出当前时间的下一秒
+(NSString *)getNextSecondForTime:(NSString *)time
{
	NSDateFormatter *formatter =[[NSDateFormatter alloc]init];

	formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
	NSDate *date = [formatter dateFromString:time];
	date =[NSDate dateWithTimeInterval:1 sinceDate:date];
	
	NSString *next=[formatter stringFromDate:date];
	return next;
}
//输出当前时间的上一秒
+(NSString *)getLastSecondForTime:(NSString *)time
{
	NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
	
	formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
	NSDate *date = [formatter dateFromString:time];
	date =[NSDate dateWithTimeInterval:-1 sinceDate:date];
	
	NSString *last=[formatter stringFromDate:date];
	return last;
}
//输出当前时间前后指定秒数
+(NSString *)getAppointFormTime:(NSString *)time addTimeInterval:(NSTimeInterval) addTime
{
	NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
	formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
	NSDate *date = [formatter dateFromString:time];
	date =[NSDate dateWithTimeInterval:addTime sinceDate:date];
	NSString *AppointTime=[formatter stringFromDate:date];
	return AppointTime;
}
//转换成年月日
+(NSString *)timeChangeToChinese:(NSString *)time
{
	if(time.length>=17)
	{
		NSString *str =[NSString stringWithFormat:@"%@年%@月%@日 %@",[time substringWithRange:NSMakeRange(0, 4)],[time substringWithRange:NSMakeRange(5, 2)],[time substringWithRange:NSMakeRange(8, 2)],[time substringWithRange:NSMakeRange(11, 5)]];
		return str;
	}
	return nil;
}

#pragma mark -- 根据日期计算出星期几 --
+ (NSString *)getWeekWithTime:(NSString *)timeStr;
{
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSDate *date = [formatter dateFromString:timeStr];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [gregorian setTimeZone: timeZone];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSCalendarUnitWeekday fromDate:date];
    return [weekdays objectAtIndex:weekdayComponents.weekday];
}

//根据基础时间计算出星期和星期的下标
+ (void)getWeekDayWithBaseTime:(NSString *)baseTime
                      callBack:(void(^)(NSString *weekStr,NSInteger weekInteger))callBack
{
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSDate *date = [NSDate date];
    if (baseTime) {
        date = [formatter dateFromString:baseTime];
    }
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [gregorian setTimeZone: timeZone];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSCalendarUnitWeekday fromDate:date];
    NSInteger weekInteger = weekdayComponents.weekday;
    callBack([weekdays objectAtIndex:weekInteger],weekInteger);
    
}
+ (NSString *)lastWeekTimeFrowNow{
    NSDate * date = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //一周的秒数
    NSTimeInterval time = 7 * 24 * 60 * 60;
    //下周就把"-"去掉
    NSDate *lastWeek = [date dateByAddingTimeInterval:-time];
    NSString *startDate =  [dateFormatter stringFromDate:lastWeek];
    
    return  startDate;
}
+ (NSString *)lastMonthTimeFrowNow{
    NSDate * date = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //一月的秒数
    NSTimeInterval time = 30 * 24 * 60 * 60;
    //下周就把"-"去掉
    NSDate *lastMonth = [date dateByAddingTimeInterval:-time];
    NSString *startDate =  [dateFormatter stringFromDate:lastMonth];
    
    return  startDate;
}
+(NSString *)afterNMonth:(NSInteger)month withStartDate:(NSString *)dateString{
    NSTimeInterval time = [self baseTimeToTimestamp:dateString format:@"yyyy-MM-dd"];
    NSTimeInterval dertTime = 30 * 24 * 60 * 60 * month;
    NSTimeInterval afterTime = time/1000 + dertTime;
    return  [self timeStempToBaseTime:afterTime*1000 Format:@"yyyy-MM-dd"];
}
+(NSString *)afterNDay:(NSInteger)day withStartDate:(NSString *)dateString{
    NSTimeInterval time = [self baseTimeToTimestamp:dateString format:@"yyyy-MM-dd"];
    NSTimeInterval dertTime = 24 * 60 * 60 * day;
    NSTimeInterval afterTime = time/1000 + dertTime;
    return  [self timeStempToBaseTime:afterTime*1000 Format:@"yyyy-MM-dd"];
}

+(NSString *)afterN2Day:(NSInteger)day withStartDate:(NSString *)dateString{
    NSTimeInterval time = [self baseTimeToTimestamp:dateString format:@"yyyy年MM月dd日 HH:mm"];
    NSTimeInterval dertTime = 24 * 60 * 60 * day;
    NSTimeInterval afterTime = time/1000 + dertTime;
    return  [self timeStempToBaseTime:afterTime*1000 Format:@"yyyy年MM月dd日 HH:mm"];
}
@end

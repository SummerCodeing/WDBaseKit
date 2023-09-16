//
//  WeekDayAndTime.h
//  
//
//  Created by summer on 2018/1/11.
//  Copyright © 2018年 summer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,WeekDay)
{
    WeekDayOnce = 0,  //单次
    WeekDaySunday,     //星期日
	WeekDayMonday,     //星期一
	WeekDayTuesday,	  //星期二
	WeekDayWednesday, //星期三
	WeekDayThursday,  //星期四
	WeekDayFriday,	  //星期五
	WeekDaySaturday,  //星期六
    WeekDayEveryday,   //每天
	
};
typedef void (^SelectPicker)(WeekDay weekDay,NSString *time);
@interface WeekDayAndTime : NSObject
@property(nonatomic,strong)NSString *titleName;///<标题
@property (nonatomic, strong) UIColor *titleColor;///<标题颜色
@property (nonatomic,strong) UIColor *datePickerTitleColor;///<pickerView 的文本颜色
///<获取一个实例
+(WeekDayAndTime *)shareInstance;
///<初始化并显示
-(void) initWithWeekDay:(WeekDay) weekDay andTime:(NSString *)time;
//选中的日期
- (void)selectDate:(SelectPicker)callback;
@end

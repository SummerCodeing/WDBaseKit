//
//  DatePickViewAndTime.h
//  THDatePickerView
//
//  Created by summer on 2017/12/19.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SelectPickerDate)(NSDate *selectDate);
@interface DatePickViewAndTime : NSObject
@property(nonatomic,strong)NSString *titleName;      ///<标题
@property (nonatomic,assign)  BOOL  isBeforeTimeEnable;///<今天之前时间是否可选
@property (nonatomic,assign)  BOOL  isAfterTimeEnable;///<今天之后时间是否可选
@property (nonatomic, strong) UIColor *titleColor;   ///<标题颜色
@property (nonatomic,strong) UIColor *datePickerTitleColor;///<pickerView 的文本颜色
- (void)initDatePickerWithDefaultDate:(NSDate *)date;
- (void)selectDate:(SelectPickerDate)callback;
@end

//
//  DatePickerView.h
//  日期选择器
//
//  Created by summer on 2017/6/28.
//  Copyright © 2017年 summer . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePickerView : UIView
@property(nonatomic, assign) BOOL isToddy;///<是否可以选择今天之后的时间,默认为NO
- (instancetype)initDatePickerWithDefaultDate:(NSDate *)date
                            andDatePickerMode:(UIDatePickerMode )mode;

- (void)selectDate:(void (^)(NSString *selectDate))callback;

/**
 移除PickerView
 */
- (void)remove;

/**
 显示PickerView
 */
- (void)show;

@end

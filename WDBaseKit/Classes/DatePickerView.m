//
//  DatePickerView.m
//  日期选择器
//
//  Created by summer on 2017/6/28.
//  Copyright © 2017年 summer. All rights reserved.
//

#import "DatePickerView.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height

typedef void (^SelectDate)(NSString *selectDateBlock);

static float ToolbarH = 44;

static float DatePickerH = 216;

@interface DatePickerView ()

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIToolbar *toolBar;

// 保存PickView的Y值
@property (nonatomic, assign) CGFloat toolViewY;
@property (nonatomic, strong) UIView *screenView;
@property (nonatomic, strong) SelectDate selectDateBlock;

@end

@implementation DatePickerView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)tapAction {
    [self remove];
}

- (instancetype)initDatePickerWithDefaultDate:(NSDate *)date
                            andDatePickerMode:(UIDatePickerMode )mode {
    self = [super init];
    if (self) {
        [self addSubview:self.toolBar];
        [self addSubview:self.datePicker];
        self.datePicker.datePickerMode = mode;
        if (date) {
          [self.datePicker setDate:date];
        }
        [self setUpFrame];
    }
    return self;
}

- (void)setIsToddy:(BOOL)isToddy {
    _isToddy = isToddy;
    if (isToddy) {
        //UIDatePicker时间最大值
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDate *currentDate = [NSDate date];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setYear:100];
        _datePicker.maximumDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    }else{
        //UIDatePicker时间范围限制
        NSDate *maxDate = [[NSDate alloc]initWithTimeIntervalSinceNow:24*60*60];
        _datePicker.maximumDate = maxDate;
        NSDate *minDate = [NSDate date];
        _datePicker.maximumDate = minDate;
    }
}

- (void)setUpFrame {
    // self 高度
    CGFloat ViewH;
    if (@available(iOS 11.0, *)) {
        ViewH = DatePickerH + ToolbarH + [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom;
    } else {
        ViewH = DatePickerH + ToolbarH;
        // Fallback on earlier versions
    }
    // 默认self Y值
    self.toolViewY = kScreenHeight - ViewH;
    // 默认设置self的Y值在屏幕下方
    self.frame = CGRectMake(0, kScreenHeight, kScreenWidth, ViewH);
}

/**
 确定
 */
- (void)doneClick {
    NSDate *select = self.datePicker.date;
    NSDateFormatter *dateFormmater = [[NSDateFormatter alloc]init];
    [dateFormmater setDateFormat:@"yyyy-MM-dd"];
    NSString *resultString = [dateFormmater stringFromDate:select];
//    NSLog(@"选中的日期:%@----%@",resultString,self.datePicker.date);
    if (self.selectDateBlock != nil) {
        if (resultString.length > 0) {
           self.selectDateBlock(resultString);
        }
    }
    [self remove];
}

//选中的日期
- (void)selectDate:(void (^)(NSString *))callback {
    self.selectDateBlock = callback;
}

/**
 显示PickerView
 */
- (void)show {
    self.screenView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.screenView.backgroundColor = [UIColor colorWithRed:0/255.0
                                                      green:0/255.0
                                                       blue:0/255.0
                                                      alpha:0.3];
    self.screenView.alpha = 0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.screenView  addGestureRecognizer:tap];
    [[UIApplication sharedApplication].keyWindow addSubview:self.screenView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.2 animations:^ {
        self.screenView.alpha = 1.0;
        if (@available(iOS 11.0, *)) {
            self.transform = CGAffineTransformMakeTranslation(0, -(DatePickerH + ToolbarH + [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom));
        } else {
            self.transform = CGAffineTransformMakeTranslation(0, -(DatePickerH + ToolbarH));
            // Fallback on earlier versions
        }
    } completion:nil];
}

/**
 移除PickerView
 */
- (void)remove {
    [UIView animateWithDuration:0.2 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, kScreenHeight);
        self.screenView.alpha = 0;
    } completion:^(BOOL finished){
        [self.screenView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

#pragma mark -- 懒加载
/**
 DatePicker
 */
- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        if (@available(iOS 13.4, *)) {
            _datePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
        } else {
            // Fallback on earlier versions
        }
        _datePicker.frame = CGRectMake(0, ToolbarH , kScreenWidth, DatePickerH);
        //设置中国东八区
        _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        _datePicker.timeZone = [NSTimeZone timeZoneWithName:@"GTM+8"];
        _datePicker.backgroundColor = [UIColor whiteColor];
        //UIDatePicker时间范围限制
        NSDate *maxDate = [[NSDate alloc] initWithTimeIntervalSinceNow:24*60*60];
        _datePicker.maximumDate = maxDate;
        NSDate *minDate = [NSDate date];
        _datePicker.maximumDate = minDate;
    }
    return _datePicker;
}
/**
 工具栏
 */
- (UIToolbar *)toolBar {
    if (!_toolBar) {
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, ToolbarH)];
        _toolBar.barStyle = UIBarStyleDefault;
        // 设置UIToolbar背景色
        _toolBar.barTintColor = [UIColor whiteColor];
        // 取消按钮
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"   取消"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(remove)];
        [leftItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16]}
                                forState:UIControlStateNormal];
        [leftItem setTintColor:[UIColor blackColor]];
        UIBarButtonItem *centerSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        // 确定按钮
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"确定   "
                                                                      style:UIBarButtonItemStyleDone
                                                                     target:self
                                                                     action:@selector(doneClick)];
        [rightItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}
                                 forState:UIControlStateNormal];
        [rightItem setTintColor:[UIColor blackColor]];
        _toolBar.items = @[leftItem, centerSpace, rightItem];
    }
    return _toolBar;
}

@end

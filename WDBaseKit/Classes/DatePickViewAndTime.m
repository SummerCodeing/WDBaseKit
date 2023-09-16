//
//  DatePickViewAndTime.m
//  THDatePickerView
//
//  Created by summer on 2017/12/19.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "DatePickViewAndTime.h"
#import <objc/runtime.h>
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height
#define M_RGB(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
//static float ToolbarH = 44;
@interface DatePickViewAndTime ()
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, copy) NSArray<NSString *> *contentsAry;
@property (nonatomic, weak) UIView *view;
@property (nonatomic, weak) UILabel *titleLab;
@property (nonatomic, weak) UIButton *okBtn;
@property (nonatomic, weak) UIButton *cancelBtn;
@property (nonatomic,strong)UIView *backgroundView;///<背景
// 保存PickView的Y值
@property (nonatomic, assign) CGFloat toolViewY;
@property (nonatomic,strong) UIView *screenView;
@property(nonatomic,strong)SelectPickerDate selectDateBlock;
@end

@implementation DatePickViewAndTime
- (void)initDatePickerWithDefaultDate:(NSDate *)date {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        UIView *backgroundView =[[UIView alloc] initWithFrame:window.frame];
        backgroundView.backgroundColor =[UIColor clearColor];
        [window makeKeyAndVisible];
        [window addSubview:backgroundView];
        // view frame
        CGRect wFrame = window.frame;
        CGFloat height = CGRectGetHeight(wFrame) * 1 / 2;
        CGFloat width  = CGRectGetWidth(wFrame) * 4.5 / 5;
        width = width > 338 ? 338 : width;
        height = height > 334 ? 334 : height;
        CGRect vFrame = CGRectMake((CGRectGetWidth(wFrame) - width) / 2.0,
                                     (CGRectGetHeight(wFrame) - height) / 2.0,
                                     width,
                                     height);
        // view
        UIView *view = [[UIView alloc] initWithFrame:vFrame];
        view.backgroundColor = [UIColor grayColor];
        view.layer.cornerRadius = 7.0f;
        view.layer.masksToBounds = YES;
        // title label
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                      0,
                                                                      CGRectGetWidth(vFrame),
                                                                      59.5)];
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.backgroundColor =[UIColor whiteColor];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDate *titleDate = [NSDate date];
        if (date) {
            titleDate = date;
        }
        NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:titleDate];
        titleLab.text = self.titleName ? self.titleName:[NSString stringWithFormat:@"%ld年", (long)nowYear];
        [titleLab setFont:[UIFont systemFontOfSize:25]];
        titleLab.textColor = self.titleColor ? self.titleColor : [UIColor blackColor];
        [view addSubview:titleLab];
        
        /*
         // 上月 button
         UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
         [backBtn setTitle:@"上月"
         forState:UIControlStateNormal];
         [backBtn setImage:[UIImage imageNamed:@"left"]
         forState:UIControlStateNormal];
         [backBtn addTarget:self
         action:@selector(backClick:)
         forControlEvents:UIControlEventTouchUpInside];
         backBtn.frame = CGRectMake(5, 0, 60, 44);
         backBtn.titleLabel.font = [UIFont systemFontOfSize:18];
         [view addSubview:backBtn];
         
         // 下月 button
         UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
         nextBtn.frame = CGRectMake(CGRectGetWidth(vFrame) - 70,
         0,
         70,
         44);
         [nextBtn setTitle:@"下月"
         forState:UIControlStateNormal];
         [nextBtn setImage:[UIImage imageNamed:@"right"]
         forState:UIControlStateNormal];
         //{top, left, bottom, right}
         float  spacing = 1;//图片和文字的左右间距
         CGSize imageSize = nextBtn.imageView.frame.size;
         CGSize titleSize = nextBtn.titleLabel.frame.size;
         CGSize textSize = [nextBtn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : nextBtn.titleLabel.font}];
         CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
         if (titleSize.width + 0.5 < frameSize.width) {
         titleSize.width = frameSize.width;
         }
         CGFloat totalLeft = (titleSiself->ze.width + spacing);
         nextBtn.imageEdgeInsets = UIEdgeInsetsMake(0.0,tself->otalLeft+15, 0.0, 0.0);
         nextBtn.titleEdgeInsets = UIEdgeInsetself->sMake(0.0, - imageSize.width, 0.0, 0.0);
         nextBtn.titleLabel.foself->nt = [UIFont systemFontOfSize:18];
         
         [nextBtn addTarget:self
         action:@selector(nextClick:)
         forControlEvents:UIControlEventTouchUpInside];
         
         [view addSubview:nextBtn];
         */
        // UIDatePicker
        self.datePicker = [[UIDatePicker alloc] init];
        if (@available(iOS 13.4, *)) {
            self.datePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
        } else {
            // Fallback on earlier versions
        }
        self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        //设置中国东八区
        self.datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        self.datePicker.timeZone = [NSTimeZone timeZoneWithName:@"GTM+8"];
        self.datePicker.backgroundColor = [UIColor whiteColor];
        if (date) {
            self.datePicker.date = date;
        }
        //UIDatePicker默认高度216
        self.datePicker.frame = CGRectMake(0,
                                       60,
                                       CGRectGetWidth(vFrame),
                                       CGRectGetHeight(vFrame) -45-59.5);
//        if (self.datePickerTitleColor) {
//            //设置文本颜色
//            [self setDatePickerTitleColor:self.datePickerTitleColor];
//        }
        if (!self.isBeforeTimeEnable) {
            //UIDatePicker时间范围限制
            NSDate *minDate = [NSDate date];
            self.datePicker.minimumDate = minDate;
        }
        if (!self.isAfterTimeEnable) {
            //UIDatePicker时间范围限制
            NSDate *minDate = [NSDate date];
            self.datePicker.maximumDate = minDate;
        }
        //添加事件
        [self.datePicker addTarget:self action:@selector(oneDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        [view addSubview:self.datePicker];
        //ok button
        UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [okBtn setTitle:@"确定"
               forState:UIControlStateNormal];
        [okBtn setTitleColor:[UIColor colorWithRed:243/255.0 green:152/255.0 blue:0 alpha:1.0] forState:UIControlStateNormal];
        [okBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        [okBtn.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [okBtn setBackgroundColor:[UIColor whiteColor]];
        [okBtn addTarget:self
                  action:@selector(okClick:)
        forControlEvents:UIControlEventTouchUpInside];
        okBtn.frame = CGRectMake(CGRectGetWidth(vFrame)/2.0,
                                 CGRectGetHeight(vFrame) - 44,
                                 CGRectGetWidth(vFrame)/2.0 + 1,
                                 45);
        [view addSubview:okBtn];
        //cancel button
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [cancelBtn setTitleColor:[UIColor redColor]
                        forState:UIControlStateNormal];
        [cancelBtn setBackgroundColor:[UIColor whiteColor]];
        [cancelBtn setTitle:@"取消"
                   forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor colorWithRed:86/255.0 green:86/255.0 blue:86/255.0 alpha:1.0] forState:UIControlStateNormal];
        [cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [cancelBtn addTarget:self
                      action:@selector(cancelClick:)
            forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.frame = CGRectMake(-1,
                                     CGRectGetHeight(vFrame) - 44,
                                     CGRectGetWidth(vFrame)/2.0 + 2,
                                     45);
        [view addSubview:cancelBtn];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(vFrame)/2.0-0.25, CGRectGetHeight(vFrame) - 44, 0.5, 45)];
        label.backgroundColor = [UIColor grayColor];
        [view addSubview:label];
        //全局变量
        self.window = window;
        self.titleLab = titleLab;
        self.view = view;
        self.okBtn = okBtn;
        self.cancelBtn = cancelBtn;
        self.backgroundView = backgroundView;
        [self.window addSubview:view];
        [UIView animateWithDuration:0.5
                              delay:0.0
             usingSpringWithDamping:0.6
              initialSpringVelocity:0.5
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             view.frame = vFrame;
                             self.backgroundView.backgroundColor = M_RGB(0, 0, 0, 0.5);
                         }
                         completion:^(BOOL finished) {
                             
                         }];
    });
}
//停止滚动调用
- (void)oneDatePickerValueChanged:(UIDatePicker *)datePicker {
    NSInteger nowYear = [datePicker.calendar component:NSCalendarUnitYear fromDate:datePicker.date];
    self.titleLab.text = self.titleName ?  self.titleName:[NSString stringWithFormat:@"%ld年",(long)nowYear];
}

- (void)hide {
    CGRect wFrame = self.window.frame;
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.backgroundView.backgroundColor = M_RGB(0, 0, 0, 0);
                         self.view.frame = CGRectMake(CGRectGetWidth(wFrame)*1/10,
                                                      CGRectGetHeight(wFrame),
                                                      CGRectGetWidth(wFrame)*4/5,
                                                      CGRectGetHeight(wFrame)*4/5);
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             self.contentsAry = nil;
                             [self.view removeFromSuperview];
                             [self.backgroundView removeFromSuperview];
                         }
                     }];
}

- (void)backClick:(UIButton *)sender {
    
}

- (void)cancelClick:(UIButton *)sender {
    [self hide];
}

- (void)okClick:(UIButton *)sender {
    [self hide];
    if (self.selectDateBlock) {
        self.selectDateBlock(self.datePicker.date);
    }
}

- (void)nextClick:(UIButton *)sender {
    
}
//选中的日期
- (void)selectDate:(SelectPickerDate)callback {
    self.selectDateBlock = callback;
}
///运行时机制设置文本颜色
- (void)setDatePickerTitleColor:(UIColor *)color {
    //	unsigned int outCount;
    //	objc_objectptr_t *pProperty = class_copyPropertyList([UIDatePicker class],&outCount);
    //	for (int i=outCount-1; i>=0; i--) {
    //		///循环获取属性名， property_getName函数返回一个属性的名称    //		NSString *getPropertyNameString =[NSString stringWithCString:property_getAttributes(pProperty[i]) encoding:NSUTF8StringEncoding];
    //		if ([getPropertyNameString isEqualToString:@"textColor"]) {
    //			[_datePicker setValue:color forKey:@"textColor"];
    //		}
    //		NSLog(@" %@",getPropertyNameString);
    //	}
    [_datePicker setValue:color forKey:@"textColor"];}
#pragma mark -- 懒加载
/**
 DatePicker
 */
//- (UIDatePicker *)datePicker
//{
//    if (!_datePicker)
//    {
//        _datePicker   = [[UIDatePicker alloc] init];
//        //设置中国东八区
//        _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
//        _datePicker.timeZone = [NSTimeZone timeZoneWithName:@"GTM+8"];
//        _datePicker.backgroundColor = [UIColor whiteColor];
//
//        // UIDatePicker默认高度216
//        _datePicker.frame = CGRectMake(0, ToolbarH , kScreenWidth, _datePicker.frame.size.height);
//        //UIDatePicker时间范围限制
//        NSDate *maxDate = [[NSDate alloc]initWithTimeIntervalSinceNow:24*60*60
//                           ];
//        _datePicker.maximumDate = maxDate;
//        NSDate *minDate = [NSDate date];
//        _datePicker.maximumDate = minDate;
//    }
//    return _datePicker;
//}
@end

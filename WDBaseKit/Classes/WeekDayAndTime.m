//
//  WeekDayAndTime.m
//  
//
//  Created by summer on 2018/1/11.
//  Copyright © 2018年 summer. All rights reserved.
//

#import "WeekDayAndTime.h"
#import <objc/runtime.h>
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height
#define M_RGB(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
@interface WeekDayAndTime()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, weak) UIView *view;
@property (nonatomic, weak) UILabel *titleLab;
@property (nonatomic, weak) UIButton *okBtn;
@property (nonatomic, weak) UIButton *cancelBtn;
@property (nonatomic,strong)UIView *backgroundView;///<背景
@property (nonatomic,strong)NSArray *weekArray;///<星期的array
@property (nonatomic,assign)WeekDay weekday;
@property (nonatomic,assign)WeekDay selectWeekDay;
@property (nonatomic,assign)NSInteger selectHours;///
@property (nonatomic,assign)NSInteger selectMin;///
// 保存PickView的Y值
@property (nonatomic, assign) CGFloat toolViewY;
@property (nonatomic,strong) UIView *screenView;
@property(nonatomic,strong)SelectPicker selectDateBlock;
@end
@implementation WeekDayAndTime
+(WeekDayAndTime *)shareInstance
{
    return [[self alloc]init];
}
- (void)initWithWeekDay:(WeekDay)weekDay andTime:(NSString *)time
{
    
    if (weekDay==WeekDayEveryday) {
        self.weekArray=@[@"每一天"];
        self.weekday=weekDay;
    } else if (weekDay <= WeekDaySaturday && weekDay >= WeekDaySunday) {
        self.weekArray=@[@"",@"每周日",@"每周一",@"每周二",@"每周三",@"每周四",@"每周五",@"每周六"];
        self.weekday=weekDay-1;
    }else{
        NSLog(@"星期格式不正确！");
        return;
    }
    
    
    self.selectWeekDay=weekDay;
    NSString *subTime =[time substringWithRange:NSMakeRange(time.length-5, 5)];
    NSArray *timeArray =[subTime componentsSeparatedByString:@":"];
    if (timeArray.count!=2) {
        NSLog(@"时间格式不正确！");
        return;
    }
    NSInteger hours =[timeArray.firstObject integerValue];
    NSInteger minitue =[timeArray.lastObject integerValue];
    if (hours<0||hours>23||minitue<0||minitue>59) {
        NSLog(@"时间超出范围！");
        return;
    }
    
    self.selectHours =hours;
    self.selectMin =minitue;
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        UIView *backgroundView =[[UIView alloc] initWithFrame:window.frame];
        backgroundView.backgroundColor =[UIColor clearColor];
        [window addSubview:backgroundView];
        // view frame
        CGRect wFrame = window.frame;
        CGFloat height = CGRectGetHeight(wFrame)*1/2;
        CGFloat width  = CGRectGetWidth(wFrame)*4.5/5;
        width =width>338? 338:width;
        height =height>334? 334:height;
        
        CGRect  vFrame =  CGRectMake((CGRectGetWidth(wFrame)-width)/2.0,
                                     (CGRectGetHeight(wFrame)-height)/2.0,
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
        NSInteger nowYear =[calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
        titleLab.text =self.titleName ?  self.titleName:[NSString stringWithFormat:@"%ld年",(long)nowYear];
        [titleLab setFont:[UIFont systemFontOfSize:25]];
        titleLab.textColor = self.titleColor ? self.titleColor :[UIColor blackColor];
        [view addSubview:titleLab];
        
        UIPickerView *pickerView =[[UIPickerView alloc] initWithFrame:CGRectMake(0, 60, CGRectGetWidth(vFrame),  CGRectGetHeight(vFrame) -45-60)];
        pickerView.delegate =self;
        pickerView.dataSource =self;
        pickerView.backgroundColor =[UIColor whiteColor];
        pickerView.showsSelectionIndicator =YES;
        [view addSubview:pickerView];
        
        UILabel *hourUnitLabel =[[UILabel alloc] init];
        [hourUnitLabel setTextColor:[UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0]];
        hourUnitLabel.adjustsFontSizeToFitWidth =YES;
        [hourUnitLabel setTextAlignment:NSTextAlignmentLeft];
        [hourUnitLabel setBackgroundColor:[UIColor clearColor]];
        [hourUnitLabel setFont:[UIFont systemFontOfSize:16]];
        hourUnitLabel.text=@"时";
        CGRect frame =CGRectZero;
        frame.origin.x =CGRectGetWidth(view.frame)*0.6;
        frame.origin.y =CGRectGetHeight(view.frame)*0.5;
        frame.size.width =50;
        frame.size.height =21;
        hourUnitLabel.frame =frame;
        [view addSubview:hourUnitLabel];
        UILabel *minitueUnitLabel =[[UILabel alloc] init];
        [minitueUnitLabel setTextColor:[UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.0]];
        minitueUnitLabel.adjustsFontSizeToFitWidth =YES;
        [minitueUnitLabel setTextAlignment:NSTextAlignmentLeft];
        [minitueUnitLabel setBackgroundColor:[UIColor clearColor]];
        [minitueUnitLabel setFont:[UIFont systemFontOfSize:16]];
        minitueUnitLabel.text=@"分";
        frame.origin.x =CGRectGetWidth(view.frame)*0.86;
        frame.origin.y =CGRectGetHeight(view.frame)*0.5;
        frame.size.width =50;
        frame.size.height =21;
        minitueUnitLabel.frame =frame;
        [view addSubview:minitueUnitLabel];
        // ok button
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
        
        // cancel button
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
        UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(vFrame)/2.0-0.25, CGRectGetHeight(vFrame) - 44, 0.5, 45)];
        label.backgroundColor =[UIColor grayColor];
        [view addSubview:label];
        
        // 全局变量
        self.window = window;
        self.titleLab = titleLab;
        self.view = view;
        self.okBtn = okBtn;
        self.cancelBtn = cancelBtn;
        self.backgroundView = backgroundView;
        self.pickerView = pickerView;
        [self.backgroundView addSubview:view];
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
                             [pickerView reloadAllComponents];
                             if (weekDay<WeekDayEveryday) {
                                 [pickerView selectRow:self.weekday inComponent:0 animated:NO];
                             } else  {
                                 [pickerView selectRow:0 inComponent:0 animated:NO];
                             }
                             [pickerView selectRow:hours inComponent:1 animated:NO];
                             [pickerView selectRow:minitue inComponent:2 animated:NO];
                         }];
    });
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
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.selectDateBlock) {
            if (self.selectWeekDay==WeekDayEveryday) {
                self.selectDateBlock(self.selectWeekDay, [NSString stringWithFormat:@"%02ld:%02ld",self.selectHours,self.selectMin]);
            } else {
                self.selectDateBlock(self.selectWeekDay, [NSString stringWithFormat:@"%@ %02ld:%02ld",self.weekArray[self.selectWeekDay] ,self.selectHours,self.selectMin]);
            }
            
        }
    });
    [self hide];
    
    
}

- (void)nextClick:(UIButton *)sender
{
    
}

//选中的日期
- (void)selectDate:(SelectPicker)callback
{
    self.selectDateBlock = callback;
    
}
///运行时机制设置文本颜色
//-(void)setDatePickerTitleColor:(UIColor *)color
//{
//
//		unsigned int outCount;
//		objc_objectptr_t *pProperty = class_copyPropertyList([UIPickerView class],&outCount);
//		for (int i=outCount-1; i>=0; i--) {
//			///循环获取属性名， property_getName函数返回一个属性的名称
//			NSString *getPropertyNameString =[NSString stringWithCString:property_getAttributes(pProperty[i]) encoding:NSUTF8StringEncoding];
//			if ([getPropertyNameString isEqualToString:@"textColor"]) {
//			}
//			NSLog(@" %@",getPropertyNameString);
//		}
//}
#pragma mark pickerView 代理
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component==0) {
        if (self.weekArray.count>1) {
            return self.weekArray.count-1;
        } else {
            return self.weekArray.count;
        }
    } else if(component==1) {
        return 24;
    }else{
        return 60;
    }
}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    CGFloat width =CGRectGetWidth(self.view.frame);
    if (component==0) {
        return width*0.4;
    } else if(component ==1){
        return width*0.2;
    } else {
        return width*0.3;
    }
    
}
//每行内容
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component==0) {
        if (self.weekArray.count>1) {
            return self.weekArray[row+1];
        }else{
            return self.weekArray[row];
        }
    } else if(component ==1) {
        return [NSString stringWithFormat:@"%02ld",(long)row];
    }else{
        return [NSString stringWithFormat:@"%02ld",(long)row];
    }
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component==0) {
        if (self.weekArray.count>1) {
            self.selectWeekDay = row+1;
        } else {
            self.selectWeekDay=row;
        }
    }else if(component ==1){
        self.selectHours =row;
    }else{
        self.selectMin =row;
    }
    
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    //设置分割线颜色
    for (UIView *singliLine in pickerView.subviews) {
        if (singliLine.frame.size.width<=5) {
            singliLine.backgroundColor =[UIColor grayColor];
        }
    }
    //重新定义ROW
    UILabel *pickerLabel =(UILabel *)view;
    if (!pickerLabel) {
        pickerLabel =[[UILabel alloc] init];
        [pickerLabel setTextColor:[UIColor darkGrayColor]];
        pickerLabel.adjustsFontSizeToFitWidth =YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
    }
    if (component==0) {
        [pickerLabel setFont:[UIFont systemFontOfSize:20]];
    }else{
        [pickerLabel setFont:[UIFont systemFontOfSize:25]];
    }
    pickerLabel.text =[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}
@end


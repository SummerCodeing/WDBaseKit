//
//  PickView.m
//  
//
//  Created by summer on 16/9/6.
//  Copyright © 2016年 summer. All rights reserved.
//

#import "PickView.h"
#import "WDBaseKitHeader.h"

static PickView *pickView = nil;
static NSArray *dataSource;///<数据源
static PickViewCallBack selectCallBack;///回调
static NSInteger  tolerantNumber;///<默认选中的数据
static NSString *unitString;///<单位
static NSString *selectData;///选中的数据;
@interface PickView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (strong, nonatomic) UIPickerView *pickView;

@end
@implementation PickView

+ (PickView *)sharedInstance
{
    PickView *pickView = [[PickView alloc] init];
    return pickView;

}
- (void)setBaseView {
    
    CGFloat height = screen_height;
    CGFloat width = screen_width;
    self.frame =CGRectMake(0, 0, screen_width, screen_height);
    UIView *backGroundView=[[UIView alloc]initWithFrame:self.frame];
    backGroundView.backgroundColor =[UIColor blackColor];
    backGroundView.alpha=0.2;
    [self addSubview:backGroundView];
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removePickView)];
    tap.numberOfTapsRequired=1;
    [self addGestureRecognizer:tap];
    UIColor *color = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    UIColor *btnColor = [UIColor blackColor];
    self.selectView = [[UIView alloc] initWithFrame:CGRectMake(0, height - 340, width, 30)];
    self.selectView .backgroundColor = color;
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setTitle:@"取消" forState:0];
    [cancleBtn setTitleColor:btnColor forState:0];
    cancleBtn.frame = CGRectMake(0, 0, 60, 40);
    [cancleBtn addTarget:self action:@selector(dateCancleAction) forControlEvents:UIControlEventTouchUpInside];
    [self.selectView  addSubview:cancleBtn];
    
    UIButton *ensureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [ensureBtn setTitle:@"确定" forState:0];
    [ensureBtn setTitleColor:btnColor forState:0];
    ensureBtn.frame = CGRectMake(width - 60, 0, 60, 40);
    [ensureBtn addTarget:self action:@selector(dateEnsureAction) forControlEvents:UIControlEventTouchUpInside];
    [self.selectView  addSubview:ensureBtn];
    [self addSubview:self.selectView ];
    
    
    self.pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(ensureBtn.frame)+5, width,  310)];
    self.pickView.delegate   = self;
    self.pickView.dataSource = self;
    self.pickView.backgroundColor = [UIColor whiteColor];
    [self.selectView addSubview:self.pickView];
    [self.pickView reloadAllComponents];
    [self.pickView selectRow:tolerantNumber inComponent:0 animated:NO];
    
    UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(screen_width/2+50, 185, screen_width/2, 30)];
    label.text =unitString;
    label.textColor =[UIColor blackColor];
    label.textAlignment =NSTextAlignmentLeft;
    label.font =[UIFont systemFontOfSize:18];
    [self.selectView addSubview:label];
    [self showPickView];
}


//添加
+ (void)addPickView:(NSArray*)array tolerantStr:(NSString *)str UnitStr:(NSString *)unitStr callback:(PickViewCallBack)callback
{
    //获取默认显示的位置
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isEqualToString:str]) {
                tolerantNumber=idx;
                *stop =YES;
            }
    }];
    selectData =str;
    unitString =unitStr;
    [PickView removePickView];//先移除已添加的视图
    dataSource =array;
    [[PickView sharedInstance] setBaseView];
    selectCallBack =callback;
}

//移除
- (void)removePickView
{
	[PickView removePickView];
}
+ (void)removePickView
{
	[[UIApplication sharedApplication].keyWindow.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		if ([obj isKindOfClass:[PickView class]]) {
			PickView *view=obj;
      [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
				if (![obj isEqual:view.selectView]) {
					[obj removeFromSuperview];
				}
			}];
			[UIView animateWithDuration:0.5 animations:^{
				view.selectView.frame =CGRectMake(0,screen_height, screen_width, 0);
				
			} completion:^(BOOL finished) {
				[view removeFromSuperview];
			}];
		}
	}];
	selectCallBack =nil;
}

//确定
- (void)dateEnsureAction{
	if (selectCallBack) {
		selectCallBack(selectData);
	}
  [PickView removePickView];
}

//取消
- (void)dateCancleAction
{
	[PickView removePickView];
}
- (void)showPickView
{
	self.selectView.frame =CGRectMake(0,screen_height, screen_width, 0);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
	[UIView animateWithDuration:0.5 animations:^{
		self.selectView.frame =CGRectMake(0,screen_height - 340, screen_width,340);
	}];
}
#pragma mark pickViewDelegate

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	
    return dataSource.count;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}
//- (CGSize)rowSizeForComponent:(NSInteger)component
//{
//	return CGSizeMake(self.selectView.frame.size.width*0.5, self.selectView.frame.size.height);
//}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	NSString *str=@"";
	if (row<dataSource.count) {
		str =dataSource[row];
	}
	return str;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	if (row>=0&&row<dataSource.count) {
		selectData =[dataSource objectAtIndex:row];
	}
	
}


//获取Window当前显示的ViewController
+ (UIViewController*)currentViewController{
    //获得当前活动窗口的根视图
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1)
    {
        //根据不同的页面切换方式，逐步取得最上层的viewController
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}

@end

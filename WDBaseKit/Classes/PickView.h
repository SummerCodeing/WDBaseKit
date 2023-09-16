//
//  PickView.h
//  
//
//  Created by summer on 16/9/6.
//  Copyright © 2016年 summer. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^PickViewCallBack) (NSString *data);

@interface PickView : UIView
@property (nonatomic,strong) UIView *selectView;///选择视图
+ (PickView *)sharedInstance;

/**
  添加单个选项PickView

 @param array 内容
 @param str 默认选中的位置的数据
 @param unitStr 单位
 @param callback  回调本次选择的位置。
 */
+ (void)addPickView:(NSArray*)array tolerantStr:(NSString *)str UnitStr:(NSString *)unitStr callback:(PickViewCallBack)callback;

///移除PickView
+ (void)removePickView;

@end

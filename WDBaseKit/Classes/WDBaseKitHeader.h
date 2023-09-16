//
//  WDBaseKitHeader.h
//  Demo2222
//
//  Created by summer on 2023/9/16.
//

#ifndef WDBaseKitHeader_h
#define WDBaseKitHeader_h

#define fix(value) ((NSNull*)value==[NSNull null] ? nil : value)
#define fixWith(value,default) ((NSNull*)value==[NSNull null] ? default : value)
#define kObjectIsNull(value) ((!value) || ((NSNull*)value==[NSNull null]))
#define kObjectIsUNull(value) (value && ((NSNull*)value!=[NSNull null]))

#define money(value) ([NSString stringWithFormat:@"%.2f",[value doubleValue]])

/**
 根据字典的key取值
 
 @param DictInValue 传入字典
 @param key key
 @return key对应的值
 */
#define DictInValue(DictInValue,key) ((DictInValue && notNull(key) && [DictInValue.allKeys containsObject:key]) ? DictInValue[key] : nil)

/**
 根据数组下标取值

 @param ArrayInValue 数值
 @param index 下标
 @return 返回数组中的元素
 */
#define ArrayInValue(ArrayInValue,index) ((ArrayInValue && index>=0 && index < ArrayInValue.count) ? ArrayInValue[index] : nil)


/**字符串拼接*/
#define StrFORMAT(str,...) [NSString stringWithFormat:str,## __VA_ARGS__]

#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height

//字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [[str stringByReplacingOccurrencesOfString:@" " withString:@""] length] < 1 ? YES : NO )
//数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys.count == 0||dic.allValues.count == 0)
//是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

/**
 *     便捷定义@property属性
 */

//id
#define id_(name,...) \
zzn_strong_property(id,name,__VA_ARGS__)


///block
#define zzn_set_block(class,name,...) \
zzn_set_property(class,(^name)(__VA_ARGS__),copy)

//baseMacro
#define zzn_set_property(class,var,...) \
@property (nonatomic, __VA_ARGS__) class var;


/**
 *     其他宏
 */

//block的调用
#define Call(block,...) \
!block?:block(__VA_ARGS__);
//block的调用，并带有返回值
#define CallRerurn(block,failReturnValue,...) \
block?(block(__VA_ARGS__)):(failReturnValue)

//防止block的强硬用循环相关
#define Weak(arg) \
__weak typeof(arg) wArg = arg;
#define Strong(arg) \
__strong typeof(arg) arg = wArg;

#define WeakSelf \
Weak(self)
#define StrongSelf \
Strong(self)

/////////////////////////////////////////////////////////////////////////////////////////////////////
#import "Camera.h"
#import "Config.h"
#import "JSON.h"
#import "Notification.h"
#import "RegExp.h"
#import "Alert.h"
#import "UIColor+BaseSDK.h"
#import "NSString+string.h"
#import "NSString+MD5.h"
#import "NSString+Time.h"
#import "NSString+FontSize.h"
#import "NSString+DeviceInfo.h"
#import "NSString+ID.h"
#import "NSObject+Model.h"
#import "NSObject+Property.h"
#import "MIMETypeInfo.h"
#import "DatePickerView.h"
#import "PickView.h"
#import "NSString+Emoji.h"
#import "UILabel+TextAlignment.h"
#import "NSString+ChineseNumber.h"
#import "DatePickViewAndTime.h"
#import "PlayMusic.h"
#import "WeekDayAndTime.h"
#import "UIViewController+findController.h"
#import "PDFImage.h"
#import "CaculateFrameTool.h"
#import "DetectJailBreakHelper.h"
#import "GCDTimer.h"
#import "RuntimeTool.h"
#import "XJKSafeDictionary.h"


#endif /* WDBaseKitHeader_h */

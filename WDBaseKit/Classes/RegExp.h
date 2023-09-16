//
//  RegExp.h
//  BaseKit
//
//  Created by summer on 16/8/29.
//  Copyright © 2016年 summer. All rights reserved.
//正则表达式

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RegExp : NSObject
+ (NSString *)htmlShuangyinhao:(NSString *)values;
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;
+ (NSString *) nullDefultString: (NSString *)fromString null:(NSString *)nullStr;

///正则匹配邮箱号
+ (BOOL)checkMailInput:(NSString *)mail;
///正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *)telNumber;
/// 正则匹配用户密码6-16位数字和字母组合
+ (BOOL)checkPassword:(NSString *)password;
/// 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName:(NSString *)userName;
/// 正则匹配用户身份证号
+ (BOOL)checkUserIdCard:(NSString *)idCard;
/// 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber:(NSString *)number;
/// 正则匹配URL
+ (BOOL)checkURL:(NSString *)url;
/// 正则匹配昵称
+ (BOOL) checkNickname:(NSString *)nickname;
/// 正则匹配以C开头的18位字符
+ (BOOL) checkCtooNumberTo18:(NSString *)nickNumber;
/// 正则匹配以C开头字符
+ (BOOL) checkCtooNumber:(NSString *)nickNumber;
/// 正则匹配银行卡号是否正确
+ (BOOL) checkBankNumber:(NSString *)bankNumber;
/// 正则匹配17位车架号
+ (BOOL) checkCheJiaNumber:(NSString *)CheJiaNumber;
/// 正则只能输入数字和字母
+ (BOOL) checkTeshuZifuNumber:(NSString *)CheJiaNumber;
/// 正则只能输入4位数字
+ (BOOL)checkShuziNumber:(NSString *)cheJiaNumber;

/// 正则是否为纯数字
+ (BOOL)checkNumber:(NSString *)numberStr;

/// 是否为纯字母(A-Z/a-z)
+ (BOOL)checkLetter:(NSString *)letterStr;

//判断是否为整形：
+ (BOOL)isPureInt:(NSString*)string;

//判断是否为浮点形：
+ (BOOL)isPureFloat:(NSString*)string;

//判断是否为double型：
+ (BOOL)isPureDouble:(NSString*)string;


///  #pragma 正则只能输入2-3位数字首位不能为0
+  (BOOL)checkHeightWeightNumber:(NSString *)cheJiaNumber;

///只能输入一个小数点
+ (BOOL)checkOnePotInNumber:(NSString *)number;
/// 车牌号验证
+ (BOOL) checkCarNumber:(NSString *)CarNumber;

///校验18位身份证号码
+(BOOL)checkUserIDCard:(NSString *)userID;

///正则匹配用户身份证号15或18位
+ (BOOL)validateIDCardNumber:(NSString *)value;
///<匹配输入时间是否是时间格式 2017-08-08 10：24：36
+ (BOOL)checkTimeString:(NSString *)time;

/**
 根据身份证号码得到生日

 @param card 省份证号码
 @return 生日
 */
+ (NSString *)getIDCardBirthday:(NSString *)card;


/**
 根据身份证得到性别

 @param card 身份证号码
 @return 1:男/0:女 / -1:未知
 */
+ (NSInteger)getIDCardSex:(NSString *)card;


@end

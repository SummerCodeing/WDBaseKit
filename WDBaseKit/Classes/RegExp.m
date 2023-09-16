//
//  RegExp.m
//
//
//  Created by summer on 16/8/29.
//  Copyright © 2016年 summer. All rights reserved.
//

#import "RegExp.h"

@implementation RegExp
+ (NSString *) nullDefultString: (NSString *)fromString null:(NSString *)nullStr{
    if ([fromString isEqualToString:@""] || [fromString isEqualToString:@"(null)"] || [fromString isEqualToString:@"<null>"] || [fromString isEqualToString:@"null"] || fromString==nil) {
        return nullStr;
    }else{
        return fromString;
    }
}
+ (NSString *)htmlShuangyinhao:(NSString *)values{
    if (values == nil) {
        return @"";
    }
    /*
     字符串的替换
     注：将字符串中的参数进行替换
     参数1：目标替换值
     参数2：替换成为的值
     参数3：类型为默认：NSLiteralSearch
     参数4：替换的范围
     */
    NSMutableString *temp = [NSMutableString stringWithString:values];
    [temp replaceOccurrencesOfString:@"\"" withString:@"'" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    [temp replaceOccurrencesOfString:@"\r" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    return temp;
}

+ (UIColor *) colorWithHexString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor colorWithWhite:1.0 alpha:0.5];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor colorWithWhite:1.0 alpha:0.5];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}




#pragma 正则匹配邮箱号
+ (BOOL)checkMailInput:(NSString *)mail{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:mail];
}

#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,177
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|7[7]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,183,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[356])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    //     NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:telNumber] == YES)
        || ([regextestcm evaluateWithObject:telNumber] == YES)
        || ([regextestct evaluateWithObject:telNumber] == YES)
        || ([regextestcu evaluateWithObject:telNumber] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}


#pragma 正则匹配用户密码6-16位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password
{
    NSString *pattern = @"^([a-zA-Z]|[a-zA-Z0-9]|[0-9]|\\S){6,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
    
}

#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString *) userName
{
    
    //    NSString *pattern = @"^[A-Za-z0-9]{6,20}+$";
    NSString *pattern = @"^([\u4e00-\u9fa5]+|([a-zA-Z]+?)+)$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:userName];
    return isMatch;
    
}


#pragma 正则匹配用户身份证号18位
+ (BOOL)checkUserIdCard: (NSString *) idCard
{
    BOOL flag;
    if (idCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{17})(\\d|[xX])$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    BOOL isMatch = [pred evaluateWithObject:idCard];
    return isMatch;
}

#pragma 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber : (NSString *) number
{
    NSString *pattern = @"^[0-9]{12}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
    
}

#pragma 正则匹配URL
+ (BOOL)checkURL : (NSString *) url
{
    NSString *pattern = @"^[0-9A-Za-z]{1,50}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:url];
    return isMatch;
    
}

#pragma 正则匹配昵称
+ (BOOL) checkNickname:(NSString *) nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    BOOL isMatch = [pred evaluateWithObject:nickname];
    return isMatch;
}

#pragma 正则匹配以C开头的18位字符
+ (BOOL) checkCtooNumberTo18:(NSString *) nickNumber
{
    NSString *nickNum=@"^C{1}[0-9]{18}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nickNum];
    BOOL isMatch = [pred evaluateWithObject:nickNumber];
    return isMatch;
}
#pragma 正则匹配以C开头字符
+ (BOOL) checkCtooNumber:(NSString *) nickNumber
{
    NSString *nickNum=@"^C{1}[0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nickNum];
    BOOL isMatch = [pred evaluateWithObject:nickNumber];
    return isMatch;
}
#pragma 正则匹配银行卡号是否正确
+ (BOOL) checkBankNumber:(NSString *) bankNumber{
    NSString *bankNum=@"^([0-9]{16}|[0-9]{19})$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",bankNum];
    BOOL isMatch = [pred evaluateWithObject:bankNumber];
    return isMatch;
}
#pragma 正则匹配17位车架号
+ (BOOL) checkCheJiaNumber:(NSString *) CheJiaNumber{
    NSString *bankNum=@"^(\\d{17})$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",bankNum];
    BOOL isMatch = [pred evaluateWithObject:CheJiaNumber];
    return isMatch;
}
#pragma 正则只能输入数字和字母
+ (BOOL) checkTeshuZifuNumber:(NSString *) CheJiaNumber{
    NSString *bankNum=@"^[A-Za-z0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",bankNum];
    BOOL isMatch = [pred evaluateWithObject:CheJiaNumber];
    return isMatch;
}
#pragma 正则只能输入4位数字
+  (BOOL)checkShuziNumber:(NSString *)cheJiaNumber
{
    NSString *bankNum = @"^[0-9]{4}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",bankNum];
    BOOL isMatch = [pred evaluateWithObject: cheJiaNumber];
    return isMatch;
}

#pragma mark -- 正则是否为纯数字 --
+ (BOOL)checkNumber:(NSString *)numberStr
{
    NSString *bankNum = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",bankNum];
    BOOL isMatch = [pred evaluateWithObject:numberStr];
    return isMatch;
}
#pragma mark -- 是否为纯字母(A-Z/a-z) --
+ (BOOL)checkLetter:(NSString *)letterStr
{
    NSString *bankNum=@"^[A-Za-z]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",bankNum];
    return [pred evaluateWithObject:letterStr];
}

#pragma mark -- 正则是否为数字或者浮点数 --
//判断是否为整形：
+ (BOOL)isPureInt:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形：
+ (BOOL)isPureFloat:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

//判断是否为double型：
+ (BOOL)isPureDouble:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    double val;
    return[scan scanDouble:&val] && [scan isAtEnd];
}

#pragma 正则只能输入2-3位数字首位不能为0
+  (BOOL)checkHeightWeightNumber:(NSString *)cheJiaNumber
{
    NSString *bankNum = @"^[1-9][0-9]{1,2}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",bankNum];
    BOOL isMatch = [pred evaluateWithObject: cheJiaNumber];
    return isMatch;
}
#pragma 只能输入一个小数点
+ (BOOL)checkOnePotInNumber:(NSString *)number
{
    NSString *checkNum=@"^[.]{0,1}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",checkNum];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
}
#pragma 车牌号验证
+ (BOOL) checkCarNumber:(NSString *) CarNumber{
    NSString *bankNum = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",bankNum];
    BOOL isMatch = [pred evaluateWithObject:CarNumber];
    return isMatch;
}

//校验18位身份证号码
+(BOOL)checkUserIDCard:(NSString *)userID
{
    //长度不为15/18的都排除掉
    if (userID.length!=18||userID.length!=15) {
        return NO;
    }
    
    //校验格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    BOOL flag = [identityCardPredicate evaluateWithObject:userID];
    
    if (!flag) {
        return flag;  //格式错误
    }else {
        //格式正确在判断是否合法
        //将前17位加权因子保存在数组里
        NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
        //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
        
        //用来保存前17位各自乖以加权因子后的总和
        NSInteger idCardWiSum = 0;
        for(int i = 0;i < 17;i++){
            NSInteger subStrIndex = [[userID substringWithRange:NSMakeRange(i, 1)] integerValue];
            NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
            idCardWiSum+= subStrIndex * idCardWiIndex;
        }
        
        //计算出校验码所在数组的位置
        NSInteger idCardMod=idCardWiSum%11;
        
        //得到最后一位身份证号码
        NSString * idCardLast= [userID substringWithRange:NSMakeRange(17, 1)];
        
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2){
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]){
                return YES;
            }else{
                return NO;
            }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]){
                return YES;
            }else{
                return NO;
            }
        }
    }
    
}

//正则匹配用户身份证号15或18位
+ (BOOL)validateIDCardNumber:(NSString *)value
{
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger length =0;
    if (!value) {
        return NO;
    }else {
        length = value.length;
        //不满足15位和18位，即身份证错误
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray = @[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    // 检测省份身份行政区代码
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag =NO; //标识省份代码是否正确
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return NO;
    }
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year =0;
    //分为15位、18位身份证进行校验
    switch (length) {
        case 15:
            //获取年份对应的数字
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                //创建正则表达式 NSRegularExpressionCaseInsensitive：不区分字母大小写的模式
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }
            //使用正则表达式匹配字符串 NSMatchingReportProgress:找到最长的匹配字符串后调用block回调
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            
            if(numberofMatch >0) {
                //1：校验码的计算方法 身份证号码17位数分别乘以不同的系数。从第一位到第十七位的系数分别为：7－9－10－5－8－4－2－1－6－3－7－9－10－5－8－4－2。将这17位数字和系数相乘的结果相加。
                
                int S = [value substringWithRange:NSMakeRange(0,1)].intValue*7 + [value substringWithRange:NSMakeRange(10,1)].intValue *7 + [value substringWithRange:NSMakeRange(1,1)].intValue*9 + [value substringWithRange:NSMakeRange(11,1)].intValue *9 + [value substringWithRange:NSMakeRange(2,1)].intValue*10 + [value substringWithRange:NSMakeRange(12,1)].intValue *10 + [value substringWithRange:NSMakeRange(3,1)].intValue*5 + [value substringWithRange:NSMakeRange(13,1)].intValue *5 + [value substringWithRange:NSMakeRange(4,1)].intValue*8 + [value substringWithRange:NSMakeRange(14,1)].intValue *8 + [value substringWithRange:NSMakeRange(5,1)].intValue*4 + [value substringWithRange:NSMakeRange(15,1)].intValue *4 + [value substringWithRange:NSMakeRange(6,1)].intValue*2 + [value substringWithRange:NSMakeRange(16,1)].intValue *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                
                
                //2：用加出来和除以11，看余数是多少？余数只可能有0－1－2－3－4－5－6－7－8－9－10这11个数字
                //这是除以11后，可能产生的11位余数、验证码，也保存成数组
                NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
                
                int Y = S %11;
                //得到最后一位身份证号码
                NSString * idCardLast= [value substringWithRange:NSMakeRange(17, 1)];
                //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
                if(Y==2){
                    if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]){
                        return YES;
                    }else{
                        return NO;
                    }
                }else{
                    //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
                    if([idCardLast isEqualToString: [idCardYArray objectAtIndex:Y]]){
                        return YES;
                    }else{
                        return NO;
                    }
                }
                
                //
                //                NSString *M =@"F";
                //                NSString *JYM =@"10X98765432";
                //                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 3：获取校验位
                //                //4：检测ID的校验位
                //                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                //
                //                    return YES;
                //                }else {
                //                    return NO;
                //                }
                
            }else {
                return NO;
            }
        default:
            return NO;
    }
    
}
+ (BOOL)checkTimeString:(NSString *)time
{
	NSString *timeNum=@"^[1-9]\\d{4}-(([0]\\d{1}[1-9]\\d{1})|([1]\\d{1}[0-2]\\d{1}))-(([0]\\d{1}[1-9]\\d{1})|([1-2]\\d{1}[0-9]\\d{1})|([3]\\d{1}[0-1]\\d{1})) (([0-1]\\d{1}[0-9]\\d{1})|([2]\\d{1}[0-3]\\d{1})):([0-5]\\d{1}[0-9]\\d{1}):([0-5]\\d{1}[0-9]\\d{1})$";
	NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",timeNum];
	BOOL isMatch = [pred evaluateWithObject:time];
	return isMatch;
}
//获取生日
+ (NSString *)getIDCardBirthday:(NSString *)card
{
    NSString *birthady = @"";
    if (![RegExp validateIDCardNumber:card]) {
        return nil;
    }
    
    //15位身份证补全18位
    NSString *carid = card;
    //    加权因子
    int R[] = {7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2};
    //校验码
    unsigned char sChecker[11] = {'1','0','X','9','8','7','6','5','4','3','2'};
    
    //将15位身份证号转换为18位
    NSMutableString *mString = [NSMutableString stringWithString:card];
    if (card.length == 15) {
        [mString insertString:@"19" atIndex:6];
        long p =0;
        
        [mString UTF8String];
        
        for (int i =0; i<17; i++){
            NSString * s = [mString substringWithRange:NSMakeRange(i, 1)];
            p += [s intValue] * R[i];
            //            p += (long)(pid-48) * R;//
            
        }
        int o = p%11;
        NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        carid = mString;
        //        NSLog(@"%@",carid);
    }
    
    
    if (card.length ==18) {
        birthady = [NSString stringWithFormat:@"%@-%@-%@",[card substringWithRange:NSMakeRange(6,4)], [card substringWithRange:NSMakeRange(10,2)], [card substringWithRange:NSMakeRange(12,2)]];
        //        NSLog(@"生日:%@",birthady);
    }else {
        birthady = [NSString stringWithFormat:@"%@-%@-%@",[carid substringWithRange:NSMakeRange(6,4)], [carid substringWithRange:NSMakeRange(10,2)], [carid substringWithRange:NSMakeRange(12,2)]];
        
        
    }
    
    NSLog(@"生日:%@",birthady);
    
    return birthady;
}

//根据身份证得到性别
+ (NSInteger)getIDCardSex:(NSString *)card
{
    if (![RegExp validateIDCardNumber:card]) {
        return -1;
    }
    card = [card stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (card.length==18) {
        NSInteger number = [[card substringWithRange:NSMakeRange(16,1)] integerValue];
        if (number % 2==0) {//偶数位女
            return 0;
        }else{
            return 1;
        }
    }else if (card.length == 15){
        
        NSInteger number = [[card substringWithRange:NSMakeRange(14,1)] integerValue];
        if (number % 2==0) {//偶数位女
            return 0;
        }else{
            return 1;
        }
    }
    return -1;
}




@end

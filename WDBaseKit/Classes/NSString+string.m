//
//  NSString+string.m
//
//
//  Created by summer on 16/8/29.
//  Copyright © 2016年 summer. All rights reserved.
//

#import "NSString+string.h"
#import "WDBaseKitHeader.h"

@implementation NSString (string)

//判断字符串是否为空
+ (BOOL)isEmpty:(NSString*)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}
//数组转字符串
+ (NSString *)toString:(NSArray *)array seperator:(NSString*)seperator {
    if (array == nil || array.count <= 0) {
        return nil;
    }else{
        return [array componentsJoinedByString:seperator];
    }
}
///json转数组
+ (NSArray *)jsonToArry:(NSString *)jsonStr {
    if (kStringIsEmpty(jsonStr)) {
        return nil;
    }
    //string转data
    NSData * jsonData = [jsonStr
                         dataUsingEncoding:NSUTF8StringEncoding];
    //json解析
    NSArray *newArry = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    return newArry;
}
//去掉特殊字符
+ (NSString *)deleteSepecialSymbol:(NSString *)string {
    string = [string stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\\\\" withString:@""];
    return string;
}
//去掉字符串首尾空格
+ (NSString *)deleteWhiteSpaceHeadAndFoot:(NSString *)string {
	string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	return string;
}
//字典转字符串
+ (NSString *)convertDictionaryToString:(NSDictionary *)dic {
    if (kDictIsEmpty(dic)) {
        return nil;
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc]initWithData:data encoding:(NSUTF8StringEncoding)];
    return [NSString deleteSepecialSymbol:jsonStr];
}
///字符串转字典
+ (NSDictionary *)converStringToDict:(NSString *)string {
    NSString * str = [NSString deleteSepecialSymbol:string];
    NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NSLog(@"字符串转字典失败");
    }
    return dic;
}
///去掉json转义字符
+ (NSString *)removeEscapeCharacters:(NSString *)jsonStr {
    NSMutableString *responseString = [NSMutableString stringWithString:jsonStr];
    NSString *character = nil;
    for (int i = 0; i < responseString.length; i ++) {
        character = [responseString substringWithRange:NSMakeRange(i, 1)];
        if ([character isEqualToString:@"\\"]) {
            [responseString deleteCharactersInRange:NSMakeRange(i, 1)];
        }
    }
    return responseString;
}
@end

//
//  NSString+string.h
//  BaseKit
//
//  Created by summer on 16/8/29.
//  Copyright © 2016年 summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (string)
/**
 *  判断是否为空
 *
 *  @param string 字符串
 *
 *  @return 判断结果
 */
+ (BOOL)isEmpty:(NSString*)string;
/**
 *  数组转字符串
 *
 *  @param array     数组
 *  @param seperator 分割标识
 *
 *  @return 结果
 */
+ (NSString *)toString:(NSArray *)array seperator:(NSString*)seperator;
/**
 json转数组

 @param jsonStr josn字符串
 @return 数组
 */
+ (NSArray *)jsonToArry:(NSString *)jsonStr;
///json解析中去除制表符
+(NSString *)deleteSepecialSymbol:(NSString *)string;
///将字典变为字符串
+(NSString *)convertDictionaryToString:(NSDictionary *)dic;
///将字符串转为字典
+ (NSDictionary *)converStringToDict:(NSString *)string;
///去掉字符串首尾空格
+(NSString *)deleteWhiteSpaceHeadAndFoot:(NSString *)string;
///去掉json转义字符
+ (NSString *)removeEscapeCharacters:(NSString *)jsonStr;
@end

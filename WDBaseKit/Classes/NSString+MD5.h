//
//  NSString+MD5.h
//
//
//  Created by summer on 2017/5/7.
//  Copyright © 2017年 summer. All rights reserved.
//  MD5字符串加密

#import <Foundation/Foundation.h>

@interface NSString (MD5)
/**
 *  MD5加密, 32位 小写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+(NSString *)MD5ForLower32Bate:(NSString *)str;


/**
 *  MD5加密, 32位 大写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+(NSString *)MD5ForUpper32Bate:(NSString *)str;


/**
 *  MD5加密, 16位 小写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+(NSString *)MD5ForLower16Bate:(NSString *)str;


/**
 *  MD5加密, 16位 大写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+(NSString *)MD5ForUpper16Bate:(NSString *)str;

/**
 获取文件的MD5

 @param filePath 文件路径
 @return MD5值
 */
+(NSString *)fileMD5forPath:(NSString *)filePath;
/**
 获取大文件MD5 后台执行

 @param filePath 文件路径
 @param callBack 反回MD5
 */
+(void)fileMD5forPath:(NSString *)filePath CallBack:(void(^)(NSString *MD5Str))callBack;
/**
 uuid-唯一标识符
 */
+ (NSString *)uuidString;


/**
 获取data到MD5值

 @param data data
 @return md5字符串
 */
+ (NSString *)getMD5Data:(NSData *)data;

+ (NSString *)sha256ForString:(NSString *)inputString;

@end

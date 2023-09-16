//
//  CONFIG.h
//  BaseSDK
//
//  Created by summer on 16/8/29.
//  Copyright © 2016年 summer. All rights reserved.
//数据存储

#import <Foundation/Foundation.h>
typedef NSString * CONFIG_KEY NS_STRING_ENUM;
@interface Config: NSObject
/**
 *  系统单例存储DATA
 *
 *  @param key   key
 *  @param value value
 */
+ (void)set:(CONFIG_KEY _Nonnull)key value:(id _Nonnull)value;
/**
 *  NSInteger类型数据的存储
 *
 *  @param key key
 *
 *  @param value value
 */
+ (void)set:(CONFIG_KEY _Nonnull)key integerValue:(NSInteger)value;
/**
 *  获取NSInteger类型的存储
 *
 *  @param key key
 *
 *  @return 返回value
 */
+ (NSInteger)getInteger:(CONFIG_KEY _Nonnull)key;
/**
 *  BOOL类型数据的存储
 *
 *  @param key key
 *
 *  @param value value
 */
+ (void)set:(CONFIG_KEY _Nonnull)key boolValue:(BOOL)value;
/**
 *  获取BOOL类型的存储
 *
 *  @param key key
 *
 *  @return 返回value
 */
+ (BOOL)getBool:(CONFIG_KEY _Nonnull)key;
///自定义模型类data形式存储
+ (void)setArchivedDataWithKey:(CONFIG_KEY _Nonnull)key value:(id _Nonnull)value;
///读取自定义模型data形式的存储数据
+ (id _Nonnull)getArchivedDataWithKey:(CONFIG_KEY _Nonnull)key;
/**
 *  获取系统单例的存储DATA
 *
 *  @param key key
 *
 *  @return 返回value
 */
+ (nullable id)get:(CONFIG_KEY _Nonnull)key;
/**
 *  删除系统单例的存储DATA
 *
 *  @param key 根据key删除对应的数据
 */
+ (void)remove:(CONFIG_KEY _Nullable)key;
/// 把对象归档存到沙盒里
+(void)saveObject:(id _Nullable )object byFileName:(NSString*_Nullable)fileName;
/// 通过文件名从沙盒中找到归档的对象
+(id _Nullable )getObjectByFileName:(NSString*_Nullable)fileName;
/// 根据文件名删除沙盒中的 plist 文件
+(void)removeFileByFileName:(NSString*_Nullable)fileName;
///使用keychain来存储,也就是钥匙串.如存储一些用户敏感信息 Token
+ (void)save:(NSString *_Nullable)service data:(id _Nullable )data;

+ (id _Nullable )load:(NSString *_Nullable)service;

+ (void)delete:(NSString *_Nullable)service;

@end

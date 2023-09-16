//
//  CONFIG.m
//  BaseSDK
//
//  Created by summer on 16/8/29.
//  Copyright © 2016年 summer. All rights reserved.
//

#import "Config.h"
#import <Security/Security.h>
#import "WDBaseKitHeader.h"

@implementation Config
+ (void)set:(CONFIG_KEY)key value:(id)value {
    @synchronized (self) {
        if (value && value != [NSNull new] && value != nil) {
			if (key == nil || key == [NSNull class]) {
				return;
			}
            [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
}

+ (nullable id)get:(CONFIG_KEY)key {
    if (kStringIsEmpty(key)) {
        return nil;
    }
    @synchronized (self) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:key];
    }
}

+ (void)set:(CONFIG_KEY)key integerValue:(NSInteger)value {
    @synchronized (self) {
        if (key == nil || key == [NSNull class]) {
            return;
        }
        [[NSUserDefaults standardUserDefaults] setInteger:value forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (NSInteger)getInteger:(CONFIG_KEY)key {
    @synchronized (self) {
        return [[NSUserDefaults standardUserDefaults] integerForKey:key];
    }
}

+ (void)set:(CONFIG_KEY)key boolValue:(BOOL)value {
    @synchronized (self) {
        if (key == nil || key == [NSNull class]) {
            return;
        }
        [[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (BOOL)getBool:(CONFIG_KEY)key {
    if (kStringIsEmpty(key)) {
        return nil;
    }
    @synchronized (self) {
        return [[NSUserDefaults standardUserDefaults] boolForKey:key];
    }
}

+ (void)remove:(CONFIG_KEY)key {
    if (!kStringIsEmpty(key)) {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:key];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}
///自定义模型类data形式存储
+ (void)setArchivedDataWithKey:(CONFIG_KEY)key value:(id)value {
    if ((value && value != [NSNull new] && value != nil)&& key) {
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:value];
        [[NSUserDefaults standardUserDefaults]setObject:data forKey:key];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}

///读取自定义模型data形式的存储数据
+ (id)getArchivedDataWithKey:(CONFIG_KEY)key {
    if (kStringIsEmpty(key)) {
        return nil;
    }
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data =  [userDefaults objectForKey:key];
    @try {
        [NSKeyedUnarchiver unarchiveObjectWithData:data];
    } @catch (NSException *exception) {
        return nil;
    } @finally {
        
    }
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

/// 把对象归档存到沙盒里
+ (void)saveObject:(id)object byFileName:(NSString*)fileName {
    NSString *path  = [self appendFilePath:fileName];
    [NSKeyedArchiver archiveRootObject:object toFile:path];
}
/// 通过文件名从沙盒中找到归档的对象
+ (id)getObjectByFileName:(NSString*)fileName {
    NSString *path  = [self appendFilePath:fileName];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

// 根据文件名删除沙盒中的 plist 文件
+ (void)removeFileByFileName:(NSString*)fileName {
    NSString *path  = [self appendFilePath:fileName];
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}

/// 拼接文件路径
+ (NSString*)appendFilePath:(NSString*)fileName {
    NSString *documentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *file = [NSString stringWithFormat:@"%@/%@.archiver",documentsPath,fileName];
    return file;
}
///钥匙串存储
+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge_transfer id)kSecClassGenericPassword,(__bridge_transfer id)kSecClass,
            service, (__bridge_transfer id)kSecAttrService,
            service, (__bridge_transfer id)kSecAttrAccount,
            (__bridge_transfer id)kSecAttrAccessibleAfterFirstUnlock,(__bridge_transfer id)kSecAttrAccessible,
            nil];
}

+ (void)save:(NSString *)service data:(id)data {
    // 获得搜索字典
    NSMutableDictionary *keychainQuery = nil;
    keychainQuery = [self getKeychainQuery:service];
    // 添加新的删除旧的
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
    // 添加新的对象到字符串
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge_transfer id)kSecValueData];
    // 查询钥匙串
    SecItemAdd((__bridge_retained CFDictionaryRef)keychainQuery, NULL);
}


+ (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    // 配置搜索设置
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge_transfer id)kSecReturnData];
    [keychainQuery setObject:(__bridge_transfer id)kSecMatchLimitOne forKey:(__bridge_transfer id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge_retained CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge_transfer NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
            
        }
    }
    return ret;
}

+ (void)delete:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
}
@end

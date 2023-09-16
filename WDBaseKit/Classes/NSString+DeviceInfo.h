//
//  NSString+DeviceInfo.h
//  XJKHealth
//
//  Created by summer on 2017/6/17.
//  Copyright © 2017年 summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(DeviceInfo)
///获取当前设备型号
+(NSString *_Nonnull)getCurrentDeviceModel;
///获取当前设备的PPI
+(NSString *_Nonnull)getCurrentDevicePPI;

///获取当前连接的WiFi
+ (NSString *_Nonnull)getCurrentWiFiName;


/// 获取当前应用版本号
+ (NSString *_Nonnull)getAPPShortVersion;

/// 获取当前应用的详细版本号(3段以上表示)
+ (NSString *_Nonnull)getAPPClientVersion;

///获取当前ip地址
+ (nullable NSString*)getCurrentLocalIP;

///获取手机型号
+ (void)getDeviceModel:(void (^_Nonnull) (NSString*_Nonnull phoneModel))callback;

///设备操作系统版本
+ (void)getDeviceSystemVersion:(void (^_Nonnull) (NSString*_Nonnull systemVersion))callback;

/// 当前应用名称 应用版本号
+ (void)getAppCurName:(void (^_Nonnull) (NSDictionary*_Nonnull appCurName))callback;

/// 当前应用版本号
+ (void)getAppCurVersion:(void (^_Nonnull) (NSString *_Nonnull curVersion))callback;


///获取设备型号信息
+ (void)getDeviceVersionInfo:(void (^_Nonnull) (NSString*_Nonnull versionInfo))callback;

///获取设备总内存大小
+ (void)getTotalMemorySize:(void (^_Nonnull)(NSString *_Nonnull memorySize))callback;

///获取当前可用内存大小
+ (void)getAvailableMemorySize:(void (^_Nonnull)(NSString *_Nonnull memorySize))callback;


@end

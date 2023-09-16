//
//  NSString+DeviceInfo.m
//  XJKHealth
//
//  Created by summer on 2017/6/17.
//  Copyright © 2017年 summer. All rights reserved.
//  //设备信息获取

#import "NSString+DeviceInfo.h"
#import <UIKit/UIKit.h>
#import <sys/types.h>
#import <sys/sysctl.h>
#import <mach/task_info.h>
#import <mach/task.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import "sys/utsname.h"
#import <mach/mach.h>//内存

@implementation NSString(DeviceInfo)
//获取当前设备型号
+(NSString *)getCurrentDeviceModel
{
	int mib[2];
	size_t len;
	char *machine;
	
	mib[0] = CTL_HW;
	mib[1] = HW_MACHINE;
	sysctl(mib, 2, NULL, &len, NULL, 0);
	machine = malloc(len);
	sysctl(mib, 2, machine, &len, NULL, 0);
	
	NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
	free(machine);
	// iPhone
	if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone2G";
	if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone3G";
	if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone3GS";
	if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone4";
	if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone4";
	if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone4";
	if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone4S";
	if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone5";
	if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone5";
	if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone5c";
	if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone5c";
	if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone5s";
	if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone5s";
	if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone6";
	if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone6Plus";
	if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone6s";
	if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone6sPlus";
	if ([platform isEqualToString:@"iPhone8,3"]) return @"iPhoneSE";
	if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhoneSE";
	if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone7";
	if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone7Plus";
	if ([platform isEqualToString:@"iPhone9,3"]) return @"iPhone7";
	if ([platform isEqualToString:@"iPhone9,4"]) return @"iPhone7Plus";
	if ([platform isEqualToString:@"iPhone10,1"]) return @"iPhone8";
	if ([platform isEqualToString:@"iPhone10,2"]) return @"iPhone8Plus";
	if ([platform isEqualToString:@"iPhone10,4"]) return @"iPhone8";
	if ([platform isEqualToString:@"iPhone10,5"]) return @"iPhone8Plus";
	if ([platform isEqualToString:@"iPhone10,3"]) return @"iPhoneX";
	if ([platform isEqualToString:@"iPhone10,6"]) return @"iPhoneX";
	if ([platform isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
	if ([platform isEqualToString:@"iPhone11,4"]) return @"iPhone XS Max";
	if ([platform isEqualToString:@"iPhone11,6"]) return @"iPhone XS Max";
	if ([platform isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
	if ([platform isEqualToString:@"iPhone12,1"]) return @"iPhone 11";
	if ([platform isEqualToString:@"iPhone12,3"]) return @"iPhone 11Pro";
	if ([platform isEqualToString:@"iPhone12,5"]) return @"iPhone 11Pro Max";
	if ([platform isEqualToString:@"iPhone12,8"]) return @"iPhone SE2";
	
	//iPod Touch
	if ([platform isEqualToString:@"iPod1,1"])   return @"iPodTouch";
	if ([platform isEqualToString:@"iPod2,1"])   return @"iPodTouch2G";
	if ([platform isEqualToString:@"iPod3,1"])   return @"iPodTouch3G";
	if ([platform isEqualToString:@"iPod4,1"])   return @"iPodTouch4G";
	if ([platform isEqualToString:@"iPod5,1"])   return @"iPodTouch5G";
	if ([platform isEqualToString:@"iPod7,1"])   return @"iPodTouch6G";
	
	//iPad
	if ([platform isEqualToString:@"iPad1,1"])   return @"iPad";
	if ([platform isEqualToString:@"iPad2,1"])   return @"iPad2";
	if ([platform isEqualToString:@"iPad2,2"])   return @"iPad2";
	if ([platform isEqualToString:@"iPad2,3"])   return @"iPad2";
	if ([platform isEqualToString:@"iPad2,4"])   return @"iPad2";
	if ([platform isEqualToString:@"iPad3,1"])   return @"iPad3";
	if ([platform isEqualToString:@"iPad3,2"])   return @"iPad3";
	if ([platform isEqualToString:@"iPad3,3"])   return @"iPad3";
	if ([platform isEqualToString:@"iPad3,4"])   return @"iPad4";
	if ([platform isEqualToString:@"iPad3,5"])   return @"iPad4";
	if ([platform isEqualToString:@"iPad3,6"])   return @"iPad4";
	
	//iPad Air
	if ([platform isEqualToString:@"iPad4,1"])   return @"iPadAir";
	if ([platform isEqualToString:@"iPad4,2"])   return @"iPadAir";
	if ([platform isEqualToString:@"iPad4,3"])   return @"iPadAir";
	if ([platform isEqualToString:@"iPad5,3"])   return @"iPadAir2";
	if ([platform isEqualToString:@"iPad5,4"])   return @"iPadAir2";
	
	//iPad mini
	if ([platform isEqualToString:@"iPad2,5"])   return @"iPadmini1G";
	if ([platform isEqualToString:@"iPad2,6"])   return @"iPadmini1G";
	if ([platform isEqualToString:@"iPad2,7"])   return @"iPadmini1G";
	if ([platform isEqualToString:@"iPad4,4"])   return @"iPadmini2";
	if ([platform isEqualToString:@"iPad4,5"])   return @"iPadmini2";
	if ([platform isEqualToString:@"iPad4,6"])   return @"iPadmini2";
	if ([platform isEqualToString:@"iPad4,7"])   return @"iPadmini3";
	if ([platform isEqualToString:@"iPad4,8"])   return @"iPadmini3";
	if ([platform isEqualToString:@"iPad4,9"])   return @"iPadmini3";
	if ([platform isEqualToString:@"iPad5,1"])   return @"iPadmini4";
	if ([platform isEqualToString:@"iPad5,2"])   return @"iPadmini4";
	
	if ([platform isEqualToString:@"i386"])      return @"iPhoneSimulator";
	if ([platform isEqualToString:@"x86_64"])    return @"iPhoneSimulator";
	return platform;
}
//获取当前设备的PPI
+(NSString *)getCurrentDevicePPI
{
	NSString *deviceType=[self getCurrentDeviceModel];
	if ([deviceType isEqualToString:@"iPhone6Plus"]|| [deviceType isEqualToString:@"iPhone6sPlus"]||[deviceType isEqualToString:@"iPhone7Plus"]) {
		return @"461";///虚拟PPI ，实际PPI是401
	} else if ([deviceType isEqualToString:@"iPhoneX"]) {
		return @"458";
	} else {
		return @"326";
	}
}

///获取当前连接的WiFi
+ (NSString *)getCurrentWiFiName
{
    NSString *ssid = @"Not Found";
    CFArrayRef myArray = CNCopySupportedInterfaces();
    if (myArray != nil) {
        CFDictionaryRef myDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
        if (myDict != nil) {
            NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
            ssid = [dict valueForKey:@"SSID"];
        }
    }
    return ssid;
}
/// 获取当前应用版本号
+ (NSString *_Nonnull)getAPPShortVersion
{
	NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
	//当前应用软件版本
	return [NSString stringWithFormat:@"%@",[infoDictionary objectForKey:@"CFBundleShortVersionString"]];
}

/// 当前应用版本号
+ (NSString *)getAPPClientVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    //详细版本号
    return [NSString stringWithFormat:@"%@",[infoDictionary objectForKey:@"sys-clientVersion"]];
}

///获取当前ip地址
+ (nullable NSString*)getCurrentLocalIP
{
    NSString *address = nil;
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
//    NSLog(@"ip地址:%@",address);
    return address;
}


///手机系统型号
+ (void)getDeviceModel:(void (^)(NSString *phoneModel))callback
{
    NSString* phoneModel = [[UIDevice currentDevice] model];
    callback(phoneModel);
}

///手机操作系统版本
+ (void)getDeviceSystemVersion:(void (^)(NSString *systemVersion))callback
{
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    callback(phoneVersion);
}
/// 当前应用名称 应用版本号
+ (void)getAppCurName:(void (^) (NSDictionary* appCurName))callback
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appCurName = [infoDictionary objectForKey:@"CFBundleName"];
    NSString *appCurVersionNum = [infoDictionary objectForKey:@"CFBundleVersion"];
    NSDictionary * appCurInfo = @{@"name":appCurName,@"versionID":appCurVersionNum};
    callback(appCurInfo);
    
    //    NSLog(@"%@",infoDictionary);
}

/// 当前应用版本号
+ (void)getAppCurVersion:(void (^) (NSString *curVersion))callback
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDictionary objectForKey:@"sys-clientVersion"];
    callback(currentVersion);
}

///获取设备型号信息
+ (void)getDeviceVersionInfo:(void (^) (NSString* versionInfo))callback
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithFormat:@"%s", systemInfo.machine];
    callback(platform);
}

///获取设备总内存大小
+ (void)getTotalMemorySize:(void (^)(NSString *memorySize))callback
{
    long long menorySize = [NSProcessInfo processInfo].physicalMemory;
    callback ([NSString fileSizeToString:menorySize]);
    
}

///获取当前可用内存大小
+ (void)getAvailableMemorySize:(void (^)(NSString *memorySize))callback
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (kernReturn != KERN_SUCCESS)
    {
        callback ([NSString fileSizeToString:NSNotFound]);
    }
    callback ([NSString fileSizeToString:(vm_page_size * vmStats.free_count + vm_page_size * vmStats.inactive_count)]);
    
}

///容量转换
+ (NSString *)fileSizeToString:(unsigned long long)fileSize
{
    NSInteger KB = 1024;
    //    NSInteger MB = KB * KB;
    //    NSInteger GB = MB  * KB;
    if (fileSize < 10) {
        return @" 0 B";
    }else if (fileSize < KB){
        return @" < 1 KM";
    }else {
        return [NSString stringWithFormat:@"%.1f KB",((CGFloat)fileSize/KB)];
        //    }else if (fileSize < GB){
        //
        //        return [NSString stringWithFormat:@"%.1f MB",((CGFloat)fileSize/MB)];
        //
        //    }else{
        //        return [NSString stringWithFormat:@"%.1f MB",((CGFloat)fileSize/MB)];
        ////        return [NSString stringWithFormat:@"%.1f GB",((CGFloat)fileSize/GB)];
    }
    
}

@end

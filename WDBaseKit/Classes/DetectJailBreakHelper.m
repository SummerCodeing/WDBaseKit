//  越狱检测工具类
//  DetectJailBreakHelper.m
//
//  Created by summer on 2017/6/27.
//  Copyright © 2017年 WW. All rights reserved.
//

#import "DetectJailBreakHelper.h"
#import <sys/stat.h>
#import "dlfcn.h"
@implementation DetectJailBreakHelper
+(BOOL)jailBreakStatus{
    //以下检测的过程是越往下，越狱越高级
    // /Applications/Cydia.app, /privte/var/stash
    NSString *cydiaPath = @"/Applications/Cydia.app";
    NSString *aptPath = @"/private/var/lib/apt/";
    if ([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath]) {
        return true;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:aptPath]) {
        return true;
    }
    
    //可能存在hook了NSFileManager方法，此处用底层C stat去检测
    struct stat stat_info;
    if (0 == stat("/Library/MobileSubstrate/MobileSubstrate.dylib", &stat_info)) {
        return true;
    }
    if (0 == stat("/Applications/Cydia.app", &stat_info)) {
        return true;
    }
    if (0 == stat("/var/lib/cydia/", &stat_info)) {
        return true;
    }
    if (0 == stat("/var/cache/apt", &stat_info)) {
        return true;
    }
    //    /Library/MobileSubstrate/MobileSubstrate.dylib 最重要的越狱文件，几乎所有的越狱机都会安装MobileSubstrate
    //    /Applications/Cydia.app/ /var/lib/cydia/绝大多数越狱机都会安装
    //    /var/cache/apt /var/lib/apt /etc/apt
    //    /bin/bash /bin/sh
    //    /usr/sbin/sshd /usr/libexec/ssh-keysign /etc/ssh/sshd_config
    
    //可能存在stat也被hook了，可以看stat是不是出自系统库，有没有被攻击者换掉
    //这种情况出现的可能性很小
    int ret;
    Dl_info dylib_info;
    int (*func_stat)(const char *,struct stat *) = stat;
    if ((ret = dladdr(func_stat, &dylib_info))) {
        NSLog(@"lib:%s",dylib_info.dli_fname);      //如果不是系统库，肯定被攻击了
         //相等为0
        if (strcmp(dylib_info.dli_fname, "/usr/lib/system/libsystem_kernel.dylib")) {
            return true;
        }
    }
    
    //还可以检测链接动态库，看下是否被链接了异常动态库，但是此方法存在appStore审核不通过的情况，这里不作罗列
    //通常，越狱机的输出结果会包含字符串： Library/MobileSubstrate/MobileSubstrate.dylib——之所以用检测链接动态库的方法，是可能存在前面的方法被hook的情况。这个字符串，前面的stat已经做了
    
    //如果攻击者给MobileSubstrate改名，但是原理都是通过DYLD_INSERT_LIBRARIES注入动态库
    //那么可以，检测当前程序运行的环境变量
    char *env = getenv("DYLD_INSERT_LIBRARIES");
    if (env != NULL) {
        return true;
    }
    return false;
}
@end

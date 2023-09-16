//
//  Notification.h
//  BaseSDK
//
//  Created by summer on 16/8/29.
//  Copyright © 2016年 summer. All rights reserved.
//通知

#import <Foundation/Foundation.h>

@interface Notification: NSObject

/**
 发送通知

 @param notificationName 通知的名称
 @param userInfo 广播数据体
 */
+ (void)postNotificationWithName:(NSString *)notificationName userInfo:(NSDictionary *)userInfo;

/**
 监听广播通知

 @param notificationName 监听广播通知的名
 @param callback 广播/通知内容
 */
+ (void)addObserverForNotificationName:(NSString *)notificationName
                              callback:(void (^)(NSDictionary* data))callback;

@end

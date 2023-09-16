//
//  MESSAGE.m
//  BaseSDK
//
//  Created by summer on 16/8/29.
//  Copyright © 2016年 summer. All rights reserved.
//

#import "Notification.h"

@implementation Notification

//发送通知消息
+ (void)postNotificationWithName:(NSString *)notificationName
                        userInfo:(NSDictionary *)userInfo
{
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName
                                                        object:nil
                                                      userInfo:userInfo];
}

//监听通知消息
+ (void)addObserverForNotificationName:(NSString *)notificationName
                              callback:(void (^)(NSDictionary* data))callback
{
    [[NSNotificationCenter defaultCenter] addObserverForName:notificationName object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        callback(note.userInfo);
    }];
}

@end

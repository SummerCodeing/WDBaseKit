//
//  JSON.h
//  BaseSDK
//
//  Created by summer on 16/8/29.
//  Copyright © 2016年 summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSON : NSObject
/**
 *  用字符串转JSON对象
 *
 *  @param string 字符串
 *
 *  @return JSON对象
 */
+ (id)convretStringToJson:(NSString *)string;

/**
 *  JSON对象转换为字符串
 *
 *  @param json JSON对象
 *
 *  @return 字符串
 */
+ (NSString *)convretJsonToString:(id)json;
/**
 *  数组转换成JSON
 *
 *  @param arry 数组
 *
 *  @return string
 */
+ (NSString *)convretJsonWithArray:(NSArray *)arry;
@end

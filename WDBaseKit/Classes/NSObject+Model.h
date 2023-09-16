//
//  NSObject+Model.h
//  BaseSDK
//
//  Created by summer on 2017/2/9.
//  Copyright © 2017年 summer. All rights reserved.
//  RunTime字典转模型

#import <Foundation/Foundation.h>

@interface NSObject (Model)

+ (instancetype)modelWithDice:(NSDictionary *)dict;

#pragma mark - 转换为JSON
/**
 *  转换为JSON Data
 */
- (NSData *)xjk_JSONData;
/**
 *  转换为字典或者数组
 */
- (id)xjk_JSONObject;
/**
 *  转换为JSON 字符串
 */
- (NSString *)xjk_JSONString;
@end

//
//  NSObject+Model.m
//  BaseSDK
//
//  Created by summer on 2017/2/9.
//  Copyright © 2017年 summer. All rights reserved.
//

#import "NSObject+Model.h"
#import <objc/message.h>


@implementation NSObject (Model)

+ (instancetype)modelWithDice:(NSDictionary *)dict {
    // runtime:遍历模型中所有成员属性,去字典中查找
    id objc = [[self alloc]init];
    unsigned int count = 0 ;
    Ivar *ivarList =  class_copyIvarList(self, &count);
    for (int i = 0 ; i <count; i++) {
        // 获取成员属性
        Ivar ivar = ivarList[i];
        // 获取成员名
        NSString *propertyName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        NSString * key = [propertyName substringFromIndex:1];
        id value = dict[key];
        // 成员属性类型
        NSString *propertyType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        // 二级转换:如果字典中还有字典，也需要把对应的字典转换成模型
        // 判断下value是否是字典
        if ([value isKindOfClass:[NSDictionary class]] && ![propertyType containsString:@"NS"]) {
            //@"@"User""
            NSRange range = [propertyType rangeOfString:@"\""];
            propertyType = [propertyType substringFromIndex:range.location + range.length];
            // User\"";
            range = [propertyType rangeOfString:@"\""];
            propertyType = [propertyType substringToIndex:range.location];
            // 获取需要转换类的类对象
            Class modelClass =  NSClassFromString(propertyType);
            if (modelClass) {
              value = [modelClass modelWithDice:value];
            }
            // 三级转换：NSArray中也是字典，把数组中的字典转换成模型.
            // 判断值是否是数组
        }
        if (value) {
            // KVC赋值:不能传空
            [objc setValue:value forKey:key];
        }
    }
    return objc;
}

#pragma mark - 转换为JSON
- (NSData *)xjk_JSONData {
    if ([self isKindOfClass:[NSString class]]) {
        return [((NSString *)self) dataUsingEncoding:NSUTF8StringEncoding];
    } else if ([self isKindOfClass:[NSData class]]) {
        return (NSData *)self;
    }
    return [NSJSONSerialization dataWithJSONObject:[self xjk_JSONObject] options:kNilOptions error:nil];
}

- (id)xjk_JSONObject {
    if ([self isKindOfClass:[NSString class]]) {
        return [NSJSONSerialization JSONObjectWithData:[((NSString *)self) dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    } else if ([self isKindOfClass:[NSData class]]) {
        return [NSJSONSerialization JSONObjectWithData:(NSData *)self options:kNilOptions error:nil];
    }
    return self;
}

- (NSString *)xjk_JSONString {
    if ([self isKindOfClass:[NSString class]]) {
        return (NSString *)self;
    } else if ([self isKindOfClass:[NSData class]]) {
        return [[NSString alloc] initWithData:(NSData *)self encoding:NSUTF8StringEncoding];
    }
    return [[NSString alloc] initWithData:[self xjk_JSONData] encoding:NSUTF8StringEncoding];
}
@end

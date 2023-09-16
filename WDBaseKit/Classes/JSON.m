//
//  JSON.m
//  BaseSDK
//
//  Created by summer on 16/8/29.
//  Copyright © 2016年 summer. All rights reserved.
//

#import "JSON.h"
#import "WDBaseKitHeader.h"

@implementation JSON
//字符串转json
+ (id)convretStringToJson:(NSString *)string
{
    if (kObjectIsNull(string)) {
        NSLog(@"[baseSDK-JSON-convretStringToJson]:json string is null.");
        return nil;
    }
    
    NSData *stringData;
    NSError *error;
    stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    id result = [NSJSONSerialization JSONObjectWithData:stringData options:kNilOptions error:&error];
    if (kObjectIsUNull(error)) {
        NSLog(@"[baseSDK-JSON-convretStringToJson]:parse error");
        return nil;
    }
    return result;
}

//json转字符串
+ (NSString *)convretJsonToString:(id)json
{
    if (kObjectIsNull(json)) {
        NSLog(@"[baseSDK-JSON-convretJsonToString]:json object is null.");
        return nil;
    }
    
    if (![NSJSONSerialization isValidJSONObject:json]) {
        NSLog(@"[baseSDK-JSON-convretJsonToString]:json object is invalid");
        return nil;
    }
    
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:json options:kNilOptions error:&error];
    if (kObjectIsUNull(error)) {
        NSLog(@"[baseSDK-JSON-convretJsonToString]:stringify error");
        return nil;
    }
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

//数组转换成jsox字符串
+(NSString *)convretJsonWithArray:(NSArray *)arry
{
    if (kObjectIsNull(arry)) {
        return nil;
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:arry options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}
@end

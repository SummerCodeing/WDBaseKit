//
//  NSObject+Property.m
//  BaseSDK
//
//  Created by summer on 2017/2/9.
//  Copyright © 2017年 summer. All rights reserved.
//

#import "NSObject+Property.h"
#import <objc/message.h>


@implementation NSObject (Property)

+ (void)createPropertyCodeWithDict:(NSDictionary *)dict
{
    NSMutableString * strM = [NSMutableString string];
    //遍历字典
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull propertyName, id  _Nonnull value, BOOL * _Nonnull stop) {
        NSString * code;
        if ([value isKindOfClass:NSClassFromString(@"__NSCFString")]) {//字符串
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSString *%@;",propertyName];
        }else if ([value isKindOfClass:NSClassFromString(@"__NSCFArray")]){//数组
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSArray *%@;",propertyName];
        }else if ([value isKindOfClass:NSClassFromString(@"__NSCFNumber")]){//NSNumber
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) NSInteger %@;",propertyName];
        }else if ([value isKindOfClass:NSClassFromString(@"__NSCFDictionary")]){//字典
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSDictionary *%@;",propertyName];
        }else if ([value isKindOfClass:NSClassFromString(@"__NSCFBoolean")]){//BOOL
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) BOOL %@;",propertyName];
        }
        [strM appendFormat:@"\n%@",code];
    }];
    NSLog(@"%@",strM);
}
@end

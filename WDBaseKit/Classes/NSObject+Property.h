//
//  NSObject+Property.h
//  BaseSDK
//
//  Created by summer on 2017/2/9.
//  Copyright © 2017年 summer. All rights reserved.
//  通过解析字典自动生成属性代码

#import <Foundation/Foundation.h>

@interface NSObject (Property)

///传入字典自动生成属性代码LOG输出
+ (void)createPropertyCodeWithDict:(NSDictionary *)dict;
@end

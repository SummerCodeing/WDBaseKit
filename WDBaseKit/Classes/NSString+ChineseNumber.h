//
//  NSString+ChineseNumber.h
//  XJKHealth
//
//  Created by wangkeshuai on 2018/1/3.
//  Copyright © 2018年 xiaweidong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(ChineseNumber)
///<获取输入数字的中文表示
+(NSString *)getChineseNumberFor:(NSInteger) number;
@end

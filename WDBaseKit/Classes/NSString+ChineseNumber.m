//
//  NSString+ChineseNumber.m
//  XJKHealth
//
//  Created by summer on 2018/1/3.
//  Copyright © 2018年 summer. All rights reserved.
//  获取数字的中文表示

#import "NSString+ChineseNumber.h"

@implementation NSString(ChineseNumber)
///获取输入数字的中文表示
+(NSString *)getChineseNumberFor:(NSInteger) number
{
	NSNumberFormatter *formatter =[[NSNumberFormatter alloc] init];
	formatter.numberStyle = kCFNumberFormatterRoundHalfDown;//原文的中文表示
	NSString *chineseNumberStr =[formatter stringFromNumber:[NSNumber numberWithInteger:number]];
	return chineseNumberStr;
}
@end

//
//  NSString+ID.m
//
//
//  Created by summer on 2018/1/9.
//  Copyright © 2018年 summer. All rights reserved.
//  获取字符串ID

#import "NSString+ID.h"

@implementation NSString(ID)
//32位全大写字符串
+(NSString *)get32BigString
{
	
	char data[32];
	
	for (int x=0;x<32;data[x++] = (char)('A'+ (arc4random_uniform(26))));
	
	return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
}
//32位全小写字符串
+(NSString *)get32LittleString
{
	
	return [[NSString get32BigString] lowercaseString];
}
//返回32位小写字母和数字
+(NSString *)get32LetterAndNumber
{
	//定义一个包含数字，大小写字母的字符串
	NSString * strAll = @"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
	//定义一个结果
	NSString * result = [[NSMutableString alloc]initWithCapacity:32];
	for (int i = 0; i < 32; i++)
	{
		//获取随机数
		NSInteger index = arc4random() % (strAll.length-1);
		char tempStr = [strAll characterAtIndex:index];
		result = (NSMutableString *)[result stringByAppendingString:[NSString stringWithFormat:@"%c",tempStr]];
	}
	
	return [result lowercaseString];
}
@end

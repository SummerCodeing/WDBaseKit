//
//  NSString+ID.h
//
//
//  Created by summer on 2018/1/9.
//  Copyright © 2018年 summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(ID)
///<32位全大写字符串
+(NSString *)get32BigString;
///<32位全小写字符串
+(NSString *)get32LittleString;
///<返回32位大小写字母和数字
+(NSString *)get32LetterAndNumber;
@end

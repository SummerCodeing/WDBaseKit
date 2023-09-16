//
//  NSString+Emoji.h
//  XJKHealth
//
//  Created by summer on 2017/6/29.
//  Copyright © 2017年 summer. All rights reserved.
//
// U+1F98x -->1F98
// EXCEL截取  =MID(A1,3,LEN(A1)-2-1)
//Unicode-->UTF-16
#define UNICODETOUTF16(x) (((((x - 0x10000) >>10) | 0xD800) << 16)  | (((x-0x10000)&3FF) | 0xDC00))
//UTF-16-->Unicode
#define MULITTHREEBYTEUTF16TOUNICODE(x,y) ((((((x ^ 0xD800) << 2) | ((y ^ 0xDC00) >> 8)) << 8) | ((y ^ 0xDC00) & 0xFF)) + 0x10000)
//UTF-16-->Unicode 取前4位
#define UTF16TOUNICODETOP4(x,y) ((((((x ^ 0xD800) << 2) | ((y ^ 0xDC00) >> 8)) << 8) | ((y ^ 0xDC00) & 0xFF)) + 0x10000)>>4
#import <Foundation/Foundation.h>

@interface NSString (Emoji)



- (BOOL)emojiInUnicode:(short)code;


/**
 * 一种非官方的, 采用私有Unicode 区域
 * e0 - e5  01 - 59
 */
- (BOOL)emojiInSoftBankUnicode:(short)code;

- (BOOL)containEmoji;
-(BOOL)stringContainsEmoji;
@end

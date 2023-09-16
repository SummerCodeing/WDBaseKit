//
//  NSString+FontSize.m
//  BaseKit
//
//  Created by summer on 2017/6/10.
//  Copyright © 2017年 summer. All rights reserved.
//

#import "NSString+FontSize.h"

@implementation NSString(FontSize)
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
	NSDictionary *dict=@{NSFontAttributeName:font};
	CGSize textSize=[self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dict context:nil].size;
	return textSize;
}
@end

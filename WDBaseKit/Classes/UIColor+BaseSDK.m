//
//  UIColor+BaseSDK.m
//  BaseSDK
//
//  Created by xiaweidong on 16/8/29.
//  Copyright © 2016年 xiaweidong. All rights reserved.
//

#import "UIColor+BaseSDK.h"

@implementation UIColor (BaseSDK)
//设置颜色
+ (UIColor*)colorWithRed:(NSInteger)red Green:(NSInteger)green Blue:(NSInteger)blue Alpha:(NSInteger)alpha
{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha/255.0];
}

//字符串转颜色
+ (UIColor*)parse:(NSString*)str
{
    NSString *cString = [[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) return [UIColor blackColor];
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if(cString.length==6) cString = [cString stringByAppendingString:@"FF"];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    range.location = 6;
    NSString *aString = [cString substringWithRange:range];
    
    unsigned int red, green, blue, alpha;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&red];
    [[NSScanner scannerWithString:gString] scanHexInt:&green];
    [[NSScanner scannerWithString:bString] scanHexInt:&blue];
    [[NSScanner scannerWithString:aString] scanHexInt:&alpha];
    
    return [UIColor colorWithRed:red
                           Green:green
                            Blue:blue
                           Alpha:alpha];
}

//颜色转换成图片
+ (UIImage *)createImageWithColor:(UIColor *)color imageSize:(CGSize)imageSize;
{
    CGRect rect = CGRectMake(0.0f,0.0f,imageSize.width,imageSize.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *myImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return myImage;
}

@end

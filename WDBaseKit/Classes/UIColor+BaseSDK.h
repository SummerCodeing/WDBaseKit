//
//  UIColor+BaseSDK.h
//  BaseSDK
//
//  Created by xiaweidong on 16/8/29.
//  Copyright © 2016年 xiaweidong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (BaseSDK)
/**
 *  设置颜色
 *  @return 返回颜色
 */
+ (UIColor*)colorWithRed:(NSInteger)red Green:(NSInteger)green Blue:(NSInteger)blue Alpha:(NSInteger)alpha;
/**
 *  字符串转颜色
 *
 *  @param str 字符串
 *
 *  @return 结果
 */
+ (UIColor*)parse:(NSString*)str;
/**
 *  颜色装换成图片
 *
 *  @param color 颜色
 *
 *  @return 图片
 */


/**
 颜色转换为图片

 @param color 颜色
 @param imageSize 图片大小
 @return 图片
 */
+ (UIImage *)createImageWithColor:(UIColor *)color imageSize:(CGSize)imageSize;
@end

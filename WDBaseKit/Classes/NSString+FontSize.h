//
//  NSString+FontSize.h
//  
//
//  Created by summer on 2017/6/10.
//  Copyright © 2017年 summer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString(FontSize)
/**
 获取文本的高宽

 @param font 字体大小
 @param maxSize 最大宽度
 @return size
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
@end

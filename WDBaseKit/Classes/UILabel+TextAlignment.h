//
//  UILabel+TextAlignment.h
//  
//
//  Created by summer on 2017/9/14.
//  Copyright © 2017年 summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel(TextAlignment)
/**
 自动左右对齐，并返回高度

 @param size 最大宽度
 @param callback 高度
 */
-(void)AutoTextAlignmentWith:(CGSize)size CallBack:(void (^)(CGFloat textHeight))callback;
@end

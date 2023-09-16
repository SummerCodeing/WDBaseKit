//
//  CaculateFrameTool.h
//  BaseSDK
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CaculateFrameTool : NSObject

/**
 根据参照控件frame获取当前控件的frame
 @param frame 参照控件的frame
 @return 返回当前空间的y坐标
 */
+(CGFloat)getOriginYWithReferenceFrame:(CGRect)frame;

/**
 利用CTFramesetterSuggestFrameSizeWithConstraints 计算文本高度->这个高度智能用在将文本绘制在View上使用，有区域像label这种空间默认与内边距所以这个高相对label显示高偏小************
 @param attriguteString 需要计算的富文本
 @param width 最大宽度
 @return 返回计算的高度
 */
+(CGFloat)getTextHeightWithAttributeString:(NSAttributedString*)attriguteString withWidth:(CGFloat)width;

/**
 获取字符串在label显示宽
 @param string 显示字符串
 @param font 字号
 @param height 显示限制最大高度
 @return label的宽
 */
+(CGFloat)getLabelWidthWithString:(NSString*)string font:(NSInteger)font labelMaxHeight:(CGFloat) height;

/**
 获取字符串在label显示的高
 @param string 显示字符串
 @param font 字号
 @param width 显示限制最大宽度
 @return label的高
 */
+(CGFloat)getLabelHeightWithString:(NSString*)string font:(NSInteger)font labelMaxWidth:(CGFloat) width;
+(CGFloat)getLabelHeightWithAttributeString:(NSMutableAttributedString*)atttributeString labelMaxWidth:(CGFloat) width;
+(CGFloat)getLabelWidthWithAttributeString:(NSMutableAttributedString*)atttributeString labelMaxHeight:(CGFloat) height;
@end

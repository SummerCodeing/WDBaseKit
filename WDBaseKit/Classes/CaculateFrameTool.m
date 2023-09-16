//
//  CaculateFrameTool.m
//  BaseSDK
//
//

#import "CaculateFrameTool.h"
#import <CoreText/CoreText.h>

@implementation CaculateFrameTool
+(CGFloat)getOriginYWithReferenceFrame:(CGRect)frame{
    return frame.origin.y + frame.size.height;
}
+(CGFloat)getTextHeightWithAttributeString:(NSAttributedString *)attriguteString withWidth:(CGFloat)width{
    //创建CTFramesetterRef实例
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attriguteString);
    CGSize restrictSize = CGSizeMake(width, CGFLOAT_MAX);
    //计算绘制的高度
    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(frameSetter, CFRangeMake(0, 0), nil, restrictSize, nil);
    CGFloat textHeight = coreTextSize.height;
    CFRelease(frameSetter);
    return textHeight;
}

+(CGFloat)getLabelHeightWithString:(NSString *)string font:(NSInteger)font labelMaxWidth:(CGFloat)width{
    CGSize restrictSize = CGSizeMake(width, CGFLOAT_MAX);
    NSDictionary *attributeDic = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    CGSize caculateSize = [string boundingRectWithSize:restrictSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributeDic context:nil].size;
    return caculateSize.height;
}
+(CGFloat)getLabelWidthWithString:(NSString *)string font:(NSInteger)font labelMaxHeight:(CGFloat)height{
    CGSize restrictSize = CGSizeMake(CGFLOAT_MAX, height);
    NSDictionary *attributeDic = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    CGSize caculateSize = [string boundingRectWithSize:restrictSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributeDic context:nil].size;
    return caculateSize.width;
}
+(CGFloat)getLabelWidthWithAttributeString:(NSMutableAttributedString *)atttributeString labelMaxHeight:(CGFloat)height{
    CGSize restrictSize = CGSizeMake(CGFLOAT_MAX,height);
    CGSize caculateSize = [atttributeString boundingRectWithSize:restrictSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    return caculateSize.width;
}
+(CGFloat)getLabelHeightWithAttributeString:(NSMutableAttributedString *)atttributeString labelMaxWidth:(CGFloat)width{
    CGSize restrictSize = CGSizeMake(width, CGFLOAT_MAX);
    CGSize caculateSize = [atttributeString boundingRectWithSize:restrictSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    return caculateSize.height;
}

@end

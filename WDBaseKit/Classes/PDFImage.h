//
//  PDFImage.h
//
//
//  Copyright © 2019 summer. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface PDFImage : NSObject


/// 根据Image绘制PDF
/// @param images 图片数组
/// @param imageID 生成路径需要唯一id
/// @param isLandscape YES:横向 NO:竖向
- (NSString *)createAnA4SizePDFWithImages:(NSArray *)images imageID:(NSString *)imageID isLandscape:(BOOL)isLandscape;


- (NSString *)createPDFPathWithName:(NSString *)pdfName;



@end

NS_ASSUME_NONNULL_END

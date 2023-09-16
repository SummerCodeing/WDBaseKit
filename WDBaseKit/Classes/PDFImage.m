//
//  PDFImage.m
//  
//
//  Created by summer on 2019/7/10.
//  Copyright © 2019 summer. All rights reserved.
//

#import "PDFImage.h"
#import <UIKit/UIKit.h>


@implementation PDFImage

#pragma mark - 创建PDF
- (NSString *)createAnA4SizePDFWithImages:(NSArray *)images imageID:(NSString *)imageID isLandscape:(BOOL)isLandscape
{
    NSString * pdfPath = [self createPDFPathWithName:[NSString stringWithFormat:@"%@.pdf",imageID]];
    // CGRectZero 表示默认尺寸,这里设置的A4纸张的尺寸
	
	CGFloat xjScale = 1.0;
	CGFloat marjin = 8.0;//预留边距
	CGFloat dert = 72.0 * (1.0/25.4);
	CGFloat width = (72.0*297.0/25.4-dert*marjin) * xjScale;
	CGFloat height = (72.0*210/25.4-dert*marjin) * xjScale;
	if (!isLandscape) {
		//竖
		width = (72.0*210/25.4-dert*marjin) * xjScale;
		height = (72.0*297.0/25.4-dert*marjin) * xjScale;
	}
	
//	CGFloat width = (72.0 * Inch_Pro(29.7));
//	CGFloat height = (72.0 * Inch_Pro(21.0));
    CGRect pdfRect = CGRectMake(0, 0, width, height);
    CGContextRef pdfContext;
    CFStringRef path;
    CFURLRef url;
    CFDataRef boxData = NULL;
    CFMutableDictionaryRef myDictionary = NULL;
    CFMutableDictionaryRef pageDictionary = NULL;
    path = CFStringCreateWithCString (NULL, [pdfPath UTF8String],
                                      kCFStringEncodingUTF8);
    url = CFURLCreateWithFileSystemPath (NULL, path,
                                         kCFURLPOSIXPathStyle, 0);
    CFRelease (path);
    myDictionary = CFDictionaryCreateMutable(NULL,
                                             0,
                                             &kCFTypeDictionaryKeyCallBacks,
                                             &kCFTypeDictionaryValueCallBacks);
    CFDictionarySetValue(myDictionary,
                         kCGPDFContextTitle,
                         CFSTR("Photo from iPrivate Album"));
    CFDictionarySetValue(myDictionary,
                         kCGPDFContextCreator,
                         CFSTR("iPrivate Album"));
    pdfContext = CGPDFContextCreateWithURL (url, &pdfRect, myDictionary);
    CFRelease(myDictionary);
    CFRelease(url);
    pageDictionary = CFDictionaryCreateMutable(NULL,
                                               0,
                                               &kCFTypeDictionaryKeyCallBacks,
                                               &kCFTypeDictionaryValueCallBacks);
    boxData = CFDataCreate(NULL,(const UInt8 *)&pdfRect, sizeof (CGRect));
    CFDictionarySetValue(pageDictionary, kCGPDFContextTrimBox, boxData);
    [images enumerateObjectsUsingBlock:^(UIImage  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		NSData *imageData = UIImageJPEGRepresentation(obj, 0.5);
        CFDataRef data = (__bridge CFDataRef)imageData;
        CGPDFContextBeginPage (pdfContext, pageDictionary);
        XJKDrawContent(pdfContext,data,pdfRect);
        CGPDFContextEndPage (pdfContext);
        data = nil;
    }];
    CGContextRelease (pdfContext);
    CFRelease(pageDictionary);
    CFRelease(boxData);
    images = nil;
    return pdfPath;
}

void MyCreatePDFFile (CFDataRef data,
                      CGRect pageRect,
                      const char *filepath,
                      CFStringRef password)
{
    CGContextRef pdfContext;
    CFStringRef path;
    CFURLRef url;
    CFDataRef boxData = NULL;
    CFMutableDictionaryRef myDictionary = NULL;
    CFMutableDictionaryRef pageDictionary = NULL;
    
    path = CFStringCreateWithCString (NULL, filepath,
                                      kCFStringEncodingUTF8);
    url = CFURLCreateWithFileSystemPath (NULL, path,
                                         kCFURLPOSIXPathStyle, 0);
    CFRelease (path);
    myDictionary = CFDictionaryCreateMutable(NULL,
                                             0,
                                             &kCFTypeDictionaryKeyCallBacks,
                                             &kCFTypeDictionaryValueCallBacks);
    CFDictionarySetValue(myDictionary,
                         kCGPDFContextTitle,
                         CFSTR("Photo from iPrivate Album"));
    CFDictionarySetValue(myDictionary,
                         kCGPDFContextCreator,
                         CFSTR("iPrivate Album"));
    if (password) {
        CFDictionarySetValue(myDictionary, kCGPDFContextUserPassword, password);
        CFDictionarySetValue(myDictionary, kCGPDFContextOwnerPassword, password);
    }
    
    pdfContext = CGPDFContextCreateWithURL (url, &pageRect, myDictionary);
    CFRelease(myDictionary);
    CFRelease(url);
    pageDictionary = CFDictionaryCreateMutable(NULL,
                                               0,
                                               &kCFTypeDictionaryKeyCallBacks,
                                               &kCFTypeDictionaryValueCallBacks);
    boxData = CFDataCreate(NULL,(const UInt8 *)&pageRect, sizeof (CGRect));
    CFDictionarySetValue(pageDictionary, kCGPDFContextMediaBox, boxData);
    CGPDFContextBeginPage (pdfContext, pageDictionary);
    XJKDrawContent(pdfContext,data,pageRect);
    CGPDFContextEndPage (pdfContext);
    
    CGContextRelease (pdfContext);
    CFRelease(pageDictionary);
    CFRelease(boxData);
}

void XJKDrawContent(CGContextRef myContext,
                   CFDataRef data,
                   CGRect rect)
{
    CGDataProviderRef dataProvider = CGDataProviderCreateWithCFData(data);
    CGImageRef image = CGImageCreateWithJPEGDataProvider(dataProvider,
                                                         NULL,
                                                         NO,
                                                         kCGRenderingIntentDefault);
    CGContextDrawImage(myContext, rect, image);
    CGDataProviderRelease(dataProvider);
    CGImageRelease(image);
    
}


#pragma mark - 创建PDF储存路径

- (NSString *)createPDFPathWithName:(NSString *)pdfName {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *tmpDirectory = NSTemporaryDirectory();
    NSString * finderPath = [tmpDirectory stringByAppendingPathComponent:@"PDF"];
//    NSString * finderPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
//                                                                  NSUserDomainMask, YES) lastObject]
//                             stringByAppendingPathComponent:@"PDF"];
    if (![fileManager fileExistsAtPath:finderPath]) {
        [fileManager createDirectoryAtPath:finderPath withIntermediateDirectories:YES
                                attributes:nil
                                     error:NULL];
    }
    return [finderPath stringByAppendingPathComponent:pdfName];
}

@end

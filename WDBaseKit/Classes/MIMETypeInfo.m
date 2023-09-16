//
//  MIMETypeInfo.m
//  
//
//  Created by summer on 2017/6/1.
//  Copyright © 2017年 summer. All rights reserved.
//

#import "MIMETypeInfo.h"
#import <MobileCoreServices/MobileCoreServices.h>
@implementation MIMETypeInfo
//获取本地文件的MIMEType
+(NSString *)getMIMETypeWithCAPIFilePath:(NSString *)path
{
  if (![[[NSFileManager alloc]init]fileExistsAtPath:path]) {
    return nil;
  }else
	{
		CFStringRef UTI =UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[path pathExtension], NULL);
  CFStringRef MIMEType=UTTypeCopyPreferredTagWithClass(UTI, kUTTagClassMIMEType);
  CFRelease(UTI);
  if (!MIMEType) {
		return @"application/octet-stream";
		
	}
  return (__bridge NSString *)(MIMEType);
	}

}
@end

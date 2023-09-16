//
//  NSString+MD5.m
//
//
//  Created by summer on 2017/5/7.
//  Copyright © 2017年 summer. All rights reserved.
//

#import "NSString+MD5.h"
#import <CommonCrypto/CommonCrypto.h>
#define FileHashDefalutChunkSizeForReadingData 512  //分块读取大小

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@implementation NSString (MD5)

#pragma mark - 32位 小写
+(NSString *)MD5ForLower32Bate:(NSString *)str{
    
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
}

#pragma mark - 32位 大写
+(NSString *)MD5ForUpper32Bate:(NSString *)str{
    
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }
    
    return digest;
}

#pragma mark - 16位 大写
+(NSString *)MD5ForUpper16Bate:(NSString *)str{
    
    NSString *md5Str = [self MD5ForUpper32Bate:str];
    
    NSString  *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}


#pragma mark - 16位 小写
+(NSString *)MD5ForLower16Bate:(NSString *)str{
    
    NSString *md5Str = [self MD5ForLower32Bate:str];
    
    NSString  *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}
#pragma mark 获取文件的MD5
+(NSString *)fileMD5forPath:(NSString *)filePath
{
  return (__bridge NSString *)fileMD5HashCreateWithPath((__bridge CFStringRef)filePath, FileHashDefalutChunkSizeForReadingData);
}
+(void)fileMD5forPath:(NSString *)filePath CallBack:(void(^)(NSString *MD5Str))callBack{
	///比较费时 放在子线程执行
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		callBack([self fileMD5forPath:filePath]);
	});
}
//流式读取文件并计算MD5
CFStringRef fileMD5HashCreateWithPath(CFStringRef filePath,size_t chunkSizeForReadingData)
{
	
	CFReadStreamRef readStream =NULL;
	//获取文件URL
	CFURLRef fileURL = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, (CFStringRef)filePath, kCFURLPOSIXPathStyle, (Boolean)false);
	if (!fileURL) {
		NSLog(@"文件MD5计算----获取文件路径失败");
		return NULL;
	}
	//创建并打开 读取流
	readStream = CFReadStreamCreateWithFile(kCFAllocatorDefault, (CFURLRef)fileURL);
	if (!readStream) {
		NSLog(@"文件MD5计算----创建读取流失败");
		return NULL;
	}
	bool disSucceed = (bool)CFReadStreamOpen(readStream);
	//如果打开失败
	if (!disSucceed) {
		NSLog(@"文件MD5计算----打开读取流失败");
		//清理
		CFReadStreamClose(readStream);
		CFRelease(readStream);
		return NULL;
	}
	//初始化哈希计算
	CC_MD5_CTX hashObject;
	CC_MD5_Init(&hashObject);
	//分块大小为空处理
	if (!chunkSizeForReadingData) {
		chunkSizeForReadingData =FileHashDefalutChunkSizeForReadingData;//默认256
	}
	//获取文件哈希值
	bool hasMoreData = true;
	while (hasMoreData) {
		uint8_t buffer[chunkSizeForReadingData];
		CFIndex readBytesCount = CFReadStreamRead(readStream,(uint8_t *)buffer, (CFIndex)sizeof(buffer));
		if (readBytesCount == -1) {
			break;
		}
		if (readBytesCount == 0) {
			hasMoreData = false;
			continue;
		}
		CC_MD5_Update(&hashObject, (const void*)buffer, (CC_LONG)readBytesCount);
	}
	//是否成功
	if (hasMoreData) {
		NSLog(@"文件MD5计算----获取MD5失败");
		//清理
		CFReadStreamClose(readStream);
		CFRelease(readStream);
		CFRelease(fileURL);
	}
	//计算哈希值
	unsigned char digest[CC_MD5_DIGEST_LENGTH];
	CC_MD5_Final(digest, &hashObject);
	//计算MD5字符串
	char hash[2*sizeof(digest)+1];
	for (size_t i=0; i<sizeof(digest); ++i) {
		snprintf(hash+(2*i), 3, "%02x",(int)(digest[i]));
	}
	return CFStringCreateWithCString(kCFAllocatorDefault, (const char *)hash, kCFStringEncodingUTF8);
}
+ (NSString *)uuidString{
    
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    
    NSString *uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(nil, uuidObj);
    
    CFRelease(uuidObj);
    
    return uuidString;
    
}

//获取data到MD5值
+ (NSString *)getMD5Data:(NSData *)data{
    //1: 创建一个MD5对象
    CC_MD5_CTX md5;
    //2: 初始化MD5
    CC_MD5_Init(&md5);
    //3: 准备MD5加密
    CC_MD5_Update(&md5, data.bytes, (CC_LONG)data.length);
    //4: 准备一个字符串数组, 存储MD5加密之后的数据
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    //5: 结束MD5加密
    CC_MD5_Final(result, &md5);
    NSMutableString *resultString = [NSMutableString string];
    //6:从result数组中获取最终结果
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [resultString appendFormat:@"%02x", result[i]];
    }
    return resultString;
}

+ (NSString *)sha256ForString:(NSString *)inputString
{
    if (inputString.length < 0) {
        return @"";
    }
    const char *cstr = [inputString cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:inputString.length];

    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
       [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

@end

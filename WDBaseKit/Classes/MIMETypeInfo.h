//
//  MIMETypeInfo.h
//  
//
//  Created by summer on 2017/6/1.
//  Copyright © 2017年 summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MIMETypeInfo : NSObject
//获取本地文件的MIMEType
+(NSString *)getMIMETypeWithCAPIFilePath:(NSString *)path;
@end

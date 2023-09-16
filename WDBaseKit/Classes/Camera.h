//
//  CAMERA.h
//  BaseSDK
//
//  Created by summer on 16/8/29.
//  Copyright © 2016年 summer. All rights reserved.
//相机

#import <UIKit/UIKit.h>

typedef void (^Callback) (UIImage* image);
typedef void (^VideoCallback) (NSURL *path);
typedef void (^ShowCompleted)(BOOL isShow);
@interface Camera: NSObject

/**
 *  打开相机
 *
 *  @param callback 返回图片
 */
+(void)openCamera:(Callback)callback allowEdit:(BOOL)edit isShow:(ShowCompleted)showCompleted;
/**
 *  打开相册
 *
 *  @param callback 返回图片
 */
+(void)openGallery:(Callback)callback isShow:(ShowCompleted )showCompleted;
/**
 *  打开录像
 *
 *  @param callback 返回录像url
 */
+(void)openRecord:(VideoCallback)callback isShow:(ShowCompleted )showCompleted;
@end

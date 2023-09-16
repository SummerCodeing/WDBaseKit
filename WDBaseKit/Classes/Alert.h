//
//  Alert.h
//  BaseSDK
//
//  Created by xiaweidong on 16/8/30.
//  Copyright © 2016年 xiaweidong. All rights reserved.
//系统警告提示框

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef void (^AlertDecideBlock)(NSInteger buttonIndex);

@interface Alert : NSObject

+ (Alert *_Nonnull)sharedInstance;

///自定义内容的提示框
+(void)alertShowTitle:(nullable NSString *)title
              message:(nullable NSString *)message
    cancelButtonTitle:(nullable NSString *)cancelButtonTitle
    otherButtonTitles:(nullable NSString *)otherButtonTitles
                block:(nullable AlertDecideBlock)alertBlock;

/**
 *  消息框
 *
 *  @param message 消息
 */
+ (void)alert:(NSString *_Nonnull)message;
/**
 *  消息框 回调
 *
 *  @param message  消息
 *  @param callback 回调函数
 */
+ (void)alert:(NSString *_Nonnull)message
     callback:(void (^_Nullable)(void))callback;



/**
 自动消失的提示框

 @param timer 延迟时间(默认2.0秒消失)
 @param message 提示内容
 @param callback 消失后回掉
 */
+ (void)alertDelayDisappear:(uint64_t)timer
					message:(NSString *_Nonnull)message
				   callback:(void (^_Nullable)(void))callback;



/// Sheet样式
/// @param title 标题
/// @param message 提示信息(可传nil)
/// @param cancelButtonTitle 取消按钮title
/// @param actionAry 显示l内容数组
/// @param cancelHandler 取消回调
/// @param handler 选中的回调
+ (void)alertActionSheetWithTitle:(nullable NSString *)title
						  message:(nullable NSString *)message
				cancelButtonTitle:(nullable NSString *)cancelButtonTitle
						addAction:(nullable NSArray <NSString *> *)actionAry
					cancelHandler:(void (^_Nullable)(void))cancelHandler
					actionHandler:(void (^_Nullable)(UIAlertAction * _Nullable action))handler;


@end

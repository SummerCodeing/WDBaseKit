//
//  Alert.m
//  BaseSDK
//
//  Created by xiaweidong on 16/8/30.
//  Copyright © 2016年 xiaweidong. All rights reserved.
//

#import "Alert.h"
#import <objc/runtime.h>
#import "WDBaseKitHeader.h"

#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@interface Alert ()
@property (nonatomic,strong)UIAlertController *alertConeroller;

@end

@implementation Alert
static Alert *alertInstance = nil;

#define EN_IOS8  [[[UIDevice currentDevice] systemVersion] floatValue]>=8.0f

+ (Alert *_Nonnull) sharedInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        alertInstance = [[Alert alloc] init];
    });
    return alertInstance;
}


///一般提示框
+ (void)alert:(NSString *)message
{
    [self alertShowTitle:@"温馨提示" message:message cancelButtonTitle:@"确定" otherButtonTitles:nil block:^(NSInteger buttonIndex) {
    }];
}
///无返回的提示框
+ (void)alert:(NSString *)message callback:(void (^)(void))callback
{
    [self alertShowTitle:@"温馨提示" message:message cancelButtonTitle:@"关闭" otherButtonTitles:nil block:^(NSInteger buttonIndex) {
        if (callback) {
            callback();
        }
    }];
	
}
+(void)alertShowTitle:(nullable NSString *)title
              message:(nullable NSString *)message
    cancelButtonTitle:(nullable NSString *)cancelButtonTitle
    otherButtonTitles:(nullable NSString *)otherButtonTitles
                block:(nullable AlertDecideBlock)alertBlock
{
    if (kStringIsEmpty(message)||kStringIsEmpty(title)) {
        return;
    }
	if ([Alert sharedInstance].alertConeroller) {
		//存在
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			[[UIViewController findCurrentController]dismissViewControllerAnimated:true completion:^{
				[Alert sharedInstance].alertConeroller = nil;
				alertInstance.alertConeroller = [UIAlertController alertControllerWithTitle:title
					   message:message preferredStyle:UIAlertControllerStyleAlert];
				if (cancelButtonTitle) {
					UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:cancelButtonTitle
																			style:UIAlertActionStyleCancel
																		  handler:^(UIAlertAction * action) {
																[Alert sharedInstance].alertConeroller = nil;
																			  if (alertBlock) {
																				  alertBlock(0);
																			  }
																		  }];
					[[Alert sharedInstance].alertConeroller addAction:defaultAction];
					
				}
				if (otherButtonTitles) {
					UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:otherButtonTitles
																			style:UIAlertActionStyleDestructive
																		  handler:^(UIAlertAction * action) {
																[Alert sharedInstance].alertConeroller = nil;
																			  if (alertBlock) {
																				  alertBlock(1);
																			  }
																		  }];
					[[Alert sharedInstance].alertConeroller addAction:confirmAction];
				}
				dispatch_async(dispatch_get_main_queue(), ^{
					[[UIViewController findCurrentController]presentViewController:alertInstance.alertConeroller animated:YES completion:nil];
				});
			}];
		});
	}else{
		[Alert sharedInstance].alertConeroller = [UIAlertController alertControllerWithTitle:title
			   message:message preferredStyle:UIAlertControllerStyleAlert];
		if (cancelButtonTitle) {
			UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:cancelButtonTitle
																	style:UIAlertActionStyleCancel
																  handler:^(UIAlertAction * action) {
															[Alert sharedInstance].alertConeroller = nil;
																		if (alertBlock) {
																			alertBlock(0);
																		}
																  }];
			[[Alert sharedInstance].alertConeroller addAction:defaultAction];
		}
		if (otherButtonTitles) {
			UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:otherButtonTitles
																	style:UIAlertActionStyleDestructive
																  handler:^(UIAlertAction * action) {
														[Alert sharedInstance].alertConeroller = nil;
																	if (alertBlock) {
																		alertBlock(1);
																	}
																  }];
			[[Alert sharedInstance].alertConeroller addAction:confirmAction];
		}
		dispatch_async(dispatch_get_main_queue(), ^{
			[[UIViewController findCurrentController]presentViewController:[Alert sharedInstance].alertConeroller animated:YES completion:nil];
		});
	 }

}


//自动消失的提示框
+ (void)alertDelayDisappear:( uint64_t)timer
                    message:(NSString *_Nonnull)message
                   callback:(nullable void (^)(void))callback
{
    if (message.length==0) {
		return;
    }
	if (timer==0) {
		timer = 2.0;
	}
	[self alertShowTitle:@"温馨提示" message:message cancelButtonTitle:nil otherButtonTitles:@"确定" block:^(NSInteger buttonIndex) {
		if (callback) {
			callback();
		}
	}];
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timer * NSEC_PER_SEC)),
				   dispatch_get_main_queue(), ^{
	   [[UIViewController findCurrentController] dismissViewControllerAnimated:YES completion:^{
		   [Alert sharedInstance].alertConeroller = nil;
		   if (callback) {
			   callback();
		   }
	   }];
	});
}


+ (void)alertActionSheetWithTitle:(nullable NSString *)title
						  message:(nullable NSString *)message
				cancelButtonTitle:(nullable NSString *)cancelButtonTitle
						addAction:(nullable NSArray <NSString *> *)actionAry
				    cancelHandler:(void (^_Nullable)(void))cancelHandler
					actionHandler:(void (^_Nullable)(UIAlertAction *action))handler;
{
	[Alert sharedInstance].alertConeroller = [UIAlertController alertControllerWithTitle:title
			  message:message preferredStyle:UIAlertControllerStyleActionSheet];
	__weak typeof(alertInstance) weakAlert = alertInstance;
	   if (cancelButtonTitle) {
		   UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
			   __strong typeof(weakAlert) strongAlert = weakAlert;
			   strongAlert.alertConeroller = nil;
				   if (cancelHandler) {
					   cancelHandler();
			}}];
		   [weakAlert.alertConeroller addAction:defaultAction];
	   }
	[actionAry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		__strong typeof(weakAlert) strongAlert = weakAlert;
		[strongAlert.alertConeroller addAction:[UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
			strongAlert.alertConeroller = nil;
			if (handler) {
				handler(action);
			}
		}]];
	}];
	dispatch_async(dispatch_get_main_queue(), ^{
		__strong typeof(weakAlert) strongAlert = weakAlert;
	   [[UIViewController findCurrentController]presentViewController:strongAlert.alertConeroller animated:YES completion:nil];
	});
}

- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    return result;
}  


@end

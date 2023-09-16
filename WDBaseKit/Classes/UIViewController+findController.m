//
//  UIViewController+findController.m
//
//
//  Created by summer on 2019/12/31.
//  Copyright © 2019 summer. All rights reserved.
//

#import "UIViewController+findController.h"



@implementation UIViewController (findController)

+ (UIViewController *)findCurrentController
{
	//获得当前活动窗口的根视图
	UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
	while (1){
		//根据不同的页面切换方式，逐步取得最上层的viewController
		if ([vc isKindOfClass:[UITabBarController class]]) {
			vc = ((UITabBarController*)vc).selectedViewController;
		}
		if ([vc isKindOfClass:[UINavigationController class]]) {
			vc = ((UINavigationController*)vc).visibleViewController;
		}
		if (vc.presentedViewController) {
			vc = vc.presentedViewController;
		}else{
			break;
		}
	}
	return vc;
}
@end

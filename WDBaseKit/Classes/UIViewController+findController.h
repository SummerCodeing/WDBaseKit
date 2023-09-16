//
//  UIViewController+findController.h
//
//
//  Created by summer on 2019/12/31.
//  Copyright © 2019 summer. All rights reserved.
// 查找根控制器/当前控制器


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (findController)

+ (UIViewController *)findCurrentController;

@end

NS_ASSUME_NONNULL_END

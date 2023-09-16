//
//  RuntimeTool.h
//  
//
//  Created by summer on 2017/9/21.
//  Copyright © 2017年 summer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
@interface RuntimeTool : NSObject
+ (void)exchangeClassMethod:(Class)anClass method1Sel:(SEL)method1Sel method2Sel:(SEL)method2Sel;
    
+ (void)exchangeInstanceMethod:(Class)anClass method1Sel:(SEL)method1Sel method2Sel:(SEL)method2Sel;
@end

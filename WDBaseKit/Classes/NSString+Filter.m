//
//  NSString+Filter.m
//  XJKHealth
//
//  Created by summer on 2020/9/14.
//  Copyright © 2020 summer. All rights reserved.
//

#import "NSString+Filter.h"

@implementation NSString (Filter)
- (NSString *)filterNumber {
    NSString *pureNumbers = [[self componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];
    NSLog(@"过滤后的数字---%@--",pureNumbers);
    return pureNumbers;
}
- (NSString *)filterTempNumber {
    NSString *pureNumbers = [[self componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"-0123456789"] invertedSet]] componentsJoinedByString:@""];
    NSLog(@"过滤后的数字---%@--",pureNumbers);
    return pureNumbers;
}
@end

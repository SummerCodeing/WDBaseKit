//
//  XJKSafeDictionary.h
//
//
//  Created by summer on 2020/5/14.
//  Copyright © 2020 summer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XJKSafeDictionary : NSObject
@property (readonly) NSUInteger count;
@property (readonly, copy) NSArray<id> *allValues;
@property (readonly, copy) NSDictionary *keyValues;
@property (readonly, copy) NSArray<id <NSCopying>> *allKeys;

+ (instancetype)safetyDictionary;
+ (instancetype)safetyDictionaryWithDictionary:(NSDictionary *)dict;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (id)objectForKey:(id<NSCopying>)aKey;
- (NSArray <id <NSCopying>> *)allKeysForObject:(id)anObject;
- (void)setObject:(id)object forKey:(id<NSCopying>)key;
- (void)setDictionary:(NSDictionary *)otherDictionary;
- (void)removeObjectForKey:(id<NSCopying>)key;
- (void)removeObjectsForKeys:(NSArray<id<NSCopying>> *)keyArray;
- (void)removeAllObjects;
- (void)enumerateKeysAndObjectsUsingBlock:(void (NS_NOESCAPE ^)(id<NSCopying> key, id obj, BOOL *stop))block NS_AVAILABLE(10_6, 4_0);
- (void)enumerateKeysAndObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (NS_NOESCAPE ^)(id<NSCopying> key, id obj, BOOL *stop))block NS_AVAILABLE(10_6, 4_0);
- (BOOL)isEqualToDictionary:(id)dictionary;
@end

NS_ASSUME_NONNULL_END

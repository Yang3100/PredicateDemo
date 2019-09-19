//
//  KJPredicateTool.h
//  KJPredicateDemo
//
//  Created by 杨科军 on 2019/9/19.
//  Copyright © 2019 杨科军. All rights reserved.
//  利用谓词写的一套工具

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KJPredicateTool : NSObject
/// NSPredicate 不影响原数组，返回数组即为过滤结果  bindings参数:替换变量字典。字典必须包含接收器中所有变量的键值对
+ (NSArray*)kj_filtrationDatasWithTemps:(NSArray*)temps predicateWithBlock:(BOOL (^)(id _Nullable evaluatedObject, NSDictionary<NSString *, id> * _Nullable bindings))block;

/// NSPredicate 除去数组temps中包含的数组targetTemps元素
+ (NSArray*)kj_delEqualDatasWithTemps:(NSArray*)temps TargetTemps:(NSArray*)targetTemps;

/// 利用 NSSortDescriptor 对对象数组，按照某一属性的升序降序排列
+ (NSArray*)kj_sortDescriptorWithTemps:(NSArray*)temps Key:(NSString*)key Ascending:(BOOL)ascending;

/// 利用 NSSortDescriptor 对对象数组，按照某些属性的升序降序排列
+ (NSArray*)kj_sortDescriptorWithTemps:(NSArray*)temps Keys:(NSArray*)keys Ascendings:(NSArray*)ascendings;

@end

NS_ASSUME_NONNULL_END

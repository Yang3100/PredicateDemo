//
//  KJPredicateTool.m
//  KJPredicateDemo
//
//  Created by 杨科军 on 2019/9/19.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "KJPredicateTool.h"

@implementation KJPredicateTool

/*------------------------ Predicate谓词的简单使用 ------------------------
 // self 表示数组元素/字符串本身
 // 比较运算符 =/==(等于)、>=/=>(大于等于)、<=/=<(小于等于)、>(大于)、<(小于)、!=/<>(不等于)
 //NSPredicate *pre = [NSPredicate predicateWithFormat:@"self = %@",[people_arr lastObject]];//比较数组元素相等
 //NSPredicate *pre = [NSPredicate predicateWithFormat:@"address = %@",[(People *)[people_arr lastObject] address]];//比较数组元素中某属性相等
 ////NSPredicate *pre = [NSPredicate predicateWithFormat:@"age in {18,21}"];//比较数组元素中某属性值在这些值中
 //NSPredicate *pre = [NSPredicate predicateWithFormat:@"age between {18,21}"];//比较数组元素中某属性值大于等于左边的值，小于等于右边的值
 
 // 逻辑运算符 and/&&(与)、or/||(或)、not/!(非)
 //NSPredicate *pre = [NSPredicate predicateWithFormat:@"address = %@ && age between {19,22}",[(People *)[people_arr lastObject] address]];
 
 // 字符串比较运算符 beginswith(以*开头)、endswith(以*结尾)、contains(包含)、like(匹配)、matches(正则)
 // [c]不区分大小写 [d]不区分发音符号即没有重音符号 [cd]既 又
 //NSPredicate *pre = [NSPredicate predicateWithFormat:@"name beginswith[cd] 'ja'"];
 //NSPredicate *pre = [NSPredicate predicateWithFormat:@"name matches '^[a-zA-Z]{4}$'"];
 
 //集合运算符 some/any:集合中任意一个元素满足条件、all:集合中所有元素都满足条件、none:集合中没有元素满足条件、in:集合中元素在另一个集合中
 //NSPredicate *pre = [NSPredicate predicateWithFormat:@"all employees.employeeId in {7,8,9}"];
 //NSPredicate *pre = [NSPredicate predicateWithFormat:@"self in %@",filter_arr];
 // $K：用于动态传入属性名、%@：用于动态设置属性值(字符串、数字、日期对象)、$(value)：可以动态改变
 //NSPredicate *pre = [NSPredicate predicateWithFormat:@"%K > $age",@"age"];
 //pre = [pre predicateWithSubstitutionVariables:@{@"age":@21}];
 // NSCompoundPredicate 相当于多个NSPredicate的组合
 //NSCompoundPredicate *compPre = [NSCompoundPredicate andPredicateWithSubpredicates:@[[NSPredicate predicateWithFormat:@"age > 19"],[NSPredicate predicateWithFormat:@"age < 21"]]];
 // 暂时没找到用法
 //NSComparisonPredicate *compPre = [NSComparisonPredicate predicateWithLeftExpression:[NSExpression expressionForKeyPath:@"name"] rightExpression:[NSExpression expressionForVariable:@"ja"] modifier:NSAnyPredicateModifier type:NSBeginsWithPredicateOperatorType options:NSNormalizedPredicateOption];
 //[people_arr filterUsingPredicate:compPre];
 */

/// NSPredicate 不影响原数组，返回数组即为过滤结果
+ (NSArray*)kj_filtrationDatasWithTemps:(NSArray*)temps predicateWithBlock:(BOOL (^)(id _Nullable evaluatedObject, NSDictionary<NSString *, id> * _Nullable bindings))block{
    NSPredicate *pre = [NSPredicate predicateWithBlock:block];
    return [temps filteredArrayUsingPredicate:pre];
}

/// NSPredicate 除去数组temps中包含的数组targetTemps元素
+ (NSArray*)kj_delEqualDatasWithTemps:(NSArray*)temps TargetTemps:(NSArray*)targetTemps{
    /// 谓词 从第二个数组(b)中去除第一个数组(a)中相同的元素
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)", targetTemps];
    return [temps filteredArrayUsingPredicate:predicate].mutableCopy;
}
/// 利用 NSSortDescriptor 对对象数组，按照某一属性的升序降序排列
+ (NSArray*)kj_sortDescriptorWithTemps:(NSArray*)temps Key:(NSString*)key Ascending:(BOOL)ascending{
    // 利用 NSSortDescriptor 对对象数组，按照某一属性或某些属性的升序降序排列
    NSSortDescriptor *des = [NSSortDescriptor sortDescriptorWithKey:key ascending:ascending];
    NSMutableArray *array = [NSMutableArray arrayWithArray:temps];
    [array sortUsingDescriptors:@[des]];
    return array;
}
/// 利用 NSSortDescriptor 对对象数组，按照某些属性的升序降序排列
+ (NSArray*)kj_sortDescriptorWithTemps:(NSArray*)temps Keys:(NSArray*)keys Ascendings:(NSArray*)ascendings{
    // 利用 NSSortDescriptor 对对象数组，按照某一属性或某些属性的升序降序排列
    NSMutableArray *desTemp = [NSMutableArray array];
    for (NSInteger i=0; i<keys.count; i++) {
        NSString *key = keys[i];
        BOOL boo = [ascendings[i] integerValue] ? YES : NO;
        NSSortDescriptor *des = [NSSortDescriptor sortDescriptorWithKey:key ascending:boo];
        [desTemp addObject:des];
    }
    NSMutableArray *array = temps.mutableCopy;
    [array sortUsingDescriptors:desTemp];
    return array;
}

@end

//
//  NSArray+HigherOrderFunction.m
//  meplus
//
//  Created by Gocy on 17/3/31.
//  Copyright © 2017年 YY. All rights reserved.
//

#import "NSArray+HigherOrderFunction.h"

@implementation NSArray(HigherOrderFunction)

-(NSArray *)map:(id(^)(id value))predicate{
    NSMutableArray *result = [NSMutableArray new];
    for (id object in self) {
        [result addObject:predicate(object)];
    }
    return [result copy];
}


-(NSArray *)filter:(BOOL(^)(id value))predicate{
    
    NSMutableArray *result = [NSMutableArray new];
    for (id object in self) {
        if (predicate(object)) {
            [result addObject:object];
        }
    }
    return [result copy];
}


-(id)reduce:(id)initialResult nextPartialResult:(id(^)(id nextPartialResult,id value))execution{
    id result = initialResult;
    for (id object in self) {
        result = execution(result,object);
    }
    return result;
}

@end

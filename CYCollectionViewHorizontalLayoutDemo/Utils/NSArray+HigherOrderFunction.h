//
//  NSArray+HigherOrderFunction.h
//  meplus
//
//  Created by Gocy on 17/3/31.
//  Copyright © 2017年 YY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray<ObjectType>(HigherOrderFunction)

-(NSArray *)map:(id(^)(ObjectType value))predicate;

-(NSArray <ObjectType> *)filter:(BOOL(^)(ObjectType value))predicate;

-(id)reduce:(id)initialResult nextPartialResult:(id(^)(id nextPartialResult,ObjectType value))execution;

@end

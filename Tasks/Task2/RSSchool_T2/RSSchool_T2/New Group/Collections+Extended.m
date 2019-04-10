//
//  Collections+Extended.m
//  RSSchool_T2
//
//  Created by Dimasno1 on 4/1/19.
//  Copyright © 2019 Alexander Shalamov. All rights reserved.
//

#import "Collections+Extended.h"

@implementation NSArray(Extended)

-(id)reduceWithInitial:(id)initialResult usingBlock:(id(^)(id result, id element))block {
    __block id initial = initialResult;
    
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        initial = block(initial, obj);
    }];
    
    return initial;
}

-(BOOL)reduceBoolWithInitial:(BOOL)initialResult usingBlock:(BOOL(^)(BOOL result, id element))block {
    __block BOOL initial = initialResult;
    
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        initial = block(initial, obj);
    }];
    
    return initial;
}

-(NSArray*)mapUsingBlock:(id(^)(id element1))block {
    NSMutableArray *result = [[NSMutableArray new] autorelease];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [result addObject:block(obj)];
    }];
    
    return result;
}

@end

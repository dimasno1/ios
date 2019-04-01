//
//  Collections+Extended.h
//  RSSchool_T2
//
//  Created by Dimasno1 on 4/1/19.
//  Copyright © 2019 Alexander Shalamov. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSArray(Extended)

-(id)reduceWithInitial:(id)initialResult usingBlock:(id(^)(id result, id element))block;
-(BOOL)reduceBoolWithInitial:(BOOL)initialResult usingBlock:(BOOL(^)(BOOL result, id element))block;
-(NSArray*)mapUsingBlock:(id(^)(id element1))block;

@end


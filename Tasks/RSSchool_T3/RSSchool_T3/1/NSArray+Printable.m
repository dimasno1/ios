//
//  NSArray+Printable.m
//  RSSchool_T3
//
//  Created by Dimasno1 on 4/10/19.
//  Copyright © 2019 Alexander Shalamov. All rights reserved.
//

#import "NSArray+Printable.h"

@implementation NSArray(StringRepresentable)

- (NSString *)stringRepresentation {
    
    @(5) stringValue
    return @"sda";
}

- (BOOL)isSupportedObject:(id)object {
    NSArray<Class> *supportedObjectClasses = @[NSNumber.class, NSNull.class, NSArray.class, NSString.class];
    
    for (Class class in supportedObjectClasses) {
        if ([object class] == class) {
            return true;
        }
    }
    
    return false;
}


@end

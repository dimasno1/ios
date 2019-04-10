//
//  NSArray+StringRepresentable.h"
//  RSSchool_T3
//
//  Created by Dimasno1 on 4/10/19.
//  Copyright © 2019 Alexander Shalamov. All rights reserved.
//

#import "NSArray+StringRepresentable.h"

#pragma mark NSNull category
@interface NSNull(StringRepresentable)
@property(readonly, assign)NSString *stringValue;
@end

@implementation NSNull(StringRepresentable)
- (NSString *)stringValue {
    return @"null";
}
@end

#pragma mark NSString category
@interface NSString(StringRepresentable)
@property(readonly, assign)NSString *stringValue;
@end

@implementation NSString(StringRepresentable)
- (NSString *)stringValue {
    NSString *string = [NSString stringWithFormat:@"\"%@\"",self];
    return string;
}
@end

#pragma mark NSArray category
@implementation NSArray(StringRepresentable)
- (NSString *)stringRepresentation {
    NSMutableArray *strings = [[NSMutableArray new]autorelease];
    
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([self isSupportedObject:obj]) {
            NSString *value = [obj isKindOfClass: NSArray.class] ? [obj stringRepresentation] : [obj stringValue];
            [strings addObject:value];
        } else {
            [strings addObject: @"unsupported"];
        }
    }];
    
    NSString *stringsJoined = [strings componentsJoinedByString:@","];
    NSMutableString *output = [[[NSMutableString alloc]initWithString:stringsJoined] autorelease];
    
    [output insertString:@"[" atIndex:0];
    [output insertString:@"]" atIndex:output.length];
    
    return output;
}

- (BOOL)isSupportedObject:(id)object {
    NSArray<Class> *supportedObjectClasses = @[NSNumber.class, NSNull.class, NSArray.class, NSString.class];
    
    for (Class class in supportedObjectClasses) {
        if ([object isKindOfClass:class]) {
            return true;
        }
    }
    
    return false;
}

@end

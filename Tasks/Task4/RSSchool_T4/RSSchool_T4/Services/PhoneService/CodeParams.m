//
//  CodeParams.m
//  RSSchool_T4
//
//  Created by Admin on 4/26/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import "CodeParams.h"

@implementation CodeParams

- (instancetype)initCodeName:(NSString *)name lenght:(NSInteger)lenght {
    self = [super init];
    if (self) {
        _codeName = name;
        _lenght = lenght;
    }
    return self;
}

+ (CodeParams *)withCodeName:(NSString *)name lenght:(NSInteger)lenght {
    CodeParams *params = [[CodeParams new]autorelease];
    [params setLenght:lenght];
    [params setCodeName:name];
    
    return params;
}

@end

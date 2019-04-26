//
//  CodeParams.h
//  RSSchool_T4
//
//  Created by Admin on 4/26/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CodeParams: NSObject

@property(retain, nonatomic)NSString *codeName;
@property(assign, nonatomic)NSInteger lenght;

- (instancetype)initCodeName:(NSString *)name lenght:(NSInteger)lenght;
+ (CodeParams *)withCodeName:(NSString *)name lenght:(NSInteger)lenght;

@end


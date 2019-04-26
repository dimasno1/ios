//
//  PhoneNumbersService.h
//  RSSchool_T4
//
//  Created by Dimasno1 on 4/22/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhoneComponents.h"
#import "CodeParams.h"

@interface PhoneNumbersService : NSObject

- (NSString *)codeIn:(NSString *)number;
- (NSInteger)phoneLenghtForPhone:(NSString *)phone;
- (NSString *)countryCodeInPhoneNumber:(NSString *)phone;
- (NSString *)formatPhoneNumber:(NSString *)phoneNumber;

@end

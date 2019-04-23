//
//  PhoneNumbersService.h
//  RSSchool_T4
//
//  Created by Dimasno1 on 4/22/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PhoneNumbersService : NSObject

- (NSInteger)phoneLenghtForPhone:(NSString *)phone;
- (NSString *)countryCodeForPhone:(NSString *)phone;
- (NSString *)formatPhoneNumber:(NSString *)phoneNumber;

@end

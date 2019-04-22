//
//  PhoneNumbersService.h
//  RSSchool_T4
//
//  Created by Dimasno1 on 4/22/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PhoneNumbersService : NSObject

- (NSString *)countryCodeForPhone:(NSString *)phone;

@end

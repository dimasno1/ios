//
//  PhoneNumbersService.m
//  RSSchool_T4
//
//  Created by Dimasno1 on 4/22/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import "PhoneNumbersService.h"

@interface PhoneNumbersService()

@property(retain, nonatomic)NSDictionary<NSNumber*, NSString*> *countryCodes;

@end

@implementation PhoneNumbersService

- (instancetype)init {
    self = [super init];
    if (self) {
        self.countryCodes = @{@"373": @"MD", @"374": @"AM", @"375": @"BY",
                              @"380": @"UA", @"992": @"TJ", @"993": @"TM",
                              @"994": @"AZ", @"996": @"KG", @"998": @"UZ"};
    }
    return self;
}

- (NSString *)countryCodeForPhone:(NSString *)phone {
    if (phone.length < 1) {
        return nil;
    }
    
    NSRange range = NSMakeRange(0, MIN(3, phone.length));
    NSString *codeNumbers = [phone substringWithRange:range];
    
    if ([_countryCodes valueForKey:codeNumbers] != nil){
        return [_countryCodes valueForKey:codeNumbers];
    } else if ([phone characterAtIndex:0] == '7'){
        return [self isKzNumber:phone] ? @"KZ" : @"RU";
    } else {
        return nil;
    }
}

- (BOOL)isKzNumber:(NSString *)number {
    if (number.length == 1) {
        return NO;
    }
    
    return [number characterAtIndex:1] == '7';
}

- (NSString *)formatNumber:(NSString *)number {
    return @"";
}

@end

//
//  PhoneNumbersService.m
//  RSSchool_T4
//
//  Created by Dimasno1 on 4/22/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import "PhoneNumbersService.h"

typedef void (^Tuple) (NSInteger, NSString *);

@interface PhoneNumbersService()

@property(retain, nonatomic)NSDictionary<NSNumber*, NSString*> *countryCodes;
@property(retain, nonatomic)NSNumberFormatter *formatter;

@end

@implementation PhoneNumbersService

- (instancetype)init {
    self = [super init];
    if (self) {
        self.formatter = [NSNumberFormatter new];
        self.countryCodes = @{@"373": @"MD", @"374": @"AM", @"375": @"BY",
                              @"380": @"UA", @"992": @"TJ", @"993": @"TM",
                              @"994": @"AZ", @"996": @"KG", @"998": @"UZ"};
    }
    return self;
}

- (NSInteger)phoneLenghtForPhone:(NSString *)phone {
    NSString *code = [self countryCodeForPhone:phone];
    NSArray<NSString *> *eightLenght = @[@"MD", @"AM", @"TM"];
    NSArray<NSString *> *nineLenght = @[@"BY", @"UA", @"TJ", @"AZ", @"KG", @"UZ"];
    NSArray<NSString *> *tenLenght = @[@"RU", @"KZ"];
    
    if ([eightLenght containsObject:code]) {
        return 8;
    } else if ([nineLenght containsObject:code]) {
        return 9;
    } else if ([tenLenght containsObject:code]) {
        return 10;
    } else {
        return 12;
    }
}

- (NSString *)countryCodeForPhone:(NSString *)phone {
    if (phone.length < 2) {
        return nil;
    }
    
    NSRange range = NSMakeRange(0, MIN(3, phone.length));
    NSString *codeNumbers = [phone substringWithRange:range];
    
    if ([_countryCodes valueForKey:codeNumbers] != nil){
        return [_countryCodes valueForKey:codeNumbers];
    }
    
    BOOL beginsWithSeven = [phone characterAtIndex:0] == '7';
    BOOL isKZNumber = [phone characterAtIndex:1] == '7';
    
    if (beginsWithSeven){
        return isKZNumber ? @"KZ" : @"RU";
    }
    
    return nil;
}

- (NSArray<Tuple>*)formatForPhone:(NSString *)phone {
    NSInteger lenght = [self phoneLenghtForPhone:phone];
    switch (lenght) {
        case 8:
            return @[^(NSInteger i, NSString *sep) { i = 3; sep = @"("; },
                      ^(NSInteger i, NSString *sep) { i = 3; sep = @")"; },
                      ^(NSInteger i, NSString *sep) { i = 3; sep = @"-"; },
                      ^(NSInteger i, NSString *sep) { i = 3; sep = @"-"; }];
            break;
        case 9:
            return @"+### (##) ###-##-##";
            break;
        case 10:
            return @"+### (###) ### ## ##";
            break;
        default:
            return @"+############";
    }
}

- (NSString *)formatPhoneNumber:(NSString *)phoneNumber {
    NSInteger number = phoneNumber.integerValue;
    
    _formatter.positiveFormat = [self formatForPhone:phoneNumber];
    _formatter.positiveFormat = [self formatForPhone:phoneNumber];
    NSLog(@"%@", [_formatter stringFromNumber:@(number)]);
    return [_formatter stringFromNumber:@(number)];
}

@end

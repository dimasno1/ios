//
//  PhoneNumbersService.m
//  RSSchool_T4
//
//  Created by Dimasno1 on 4/22/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import "PhoneNumbersService.h"

@interface PhoneNumbersService()

@property(retain, nonatomic)NSDictionary<NSString*, CodeParams*> *countryCodes;

@end

@implementation PhoneNumbersService


- (instancetype)init {
    self = [super init];
    if (self) {
        self.countryCodes =  @{@"373": [CodeParams withCodeName:@"MD" lenght:8],
                               @"374": [CodeParams withCodeName:@"AM" lenght:8],
                               @"375": [CodeParams withCodeName:@"BY" lenght:9],
                               @"380": [CodeParams withCodeName:@"UA" lenght:9],
                               @"992": [CodeParams withCodeName:@"TJ" lenght:9],
                               @"993": [CodeParams withCodeName:@"TM" lenght:8],
                               @"994": [CodeParams withCodeName:@"AZ" lenght:9],
                               @"996": [CodeParams withCodeName:@"KG" lenght:9],
                               @"998": [CodeParams withCodeName:@"UZ" lenght:9] ,
                               @"7" : [CodeParams withCodeName:@"RU" lenght:10],
                               @"77" : [CodeParams withCodeName:@"KZ" lenght:10]};
    }
    return self;
}

- (NSInteger)phoneLenghtForPhone:(NSString *)phone {
    NSString *code = [self codeIn:phone];
    CodeParams *parameters = [_countryCodes valueForKey:code];
    
    return parameters == nil ? 12 : parameters.lenght;
}

- (NSString *)codeIn:(NSString *)number {
    if (number.length < 1) {
        return nil;
    }

    NSRange range = NSMakeRange(0, MIN(number.length, 3));

    if ([number characterAtIndex:0] == '7') {
        NSInteger lenght = number.length > 1 ? ([number characterAtIndex:1] == '7' ? 2 : 1) : 1;
        range = NSMakeRange(0, lenght);
    }

    return [number substringWithRange:range];
}

- (NSString *)countryCodeInPhoneNumber:(NSString *)number {
    NSString *code = [self codeIn:number];
    NSString *value = [_countryCodes valueForKey:code].codeName;

    return value;
}

- (SeparatorType)separatorTypeforPhoneLenght:(NSInteger)lenght {
    switch (lenght) {
        case 10: return Space;
            break;

        case 8:
        case 9: return MinusSign;
            break;

        default: return None;
            break;
    }
}

- (PhoneFormat)formatForNumber:(NSString *)number {
    NSNumber *lenght = @([self phoneLenghtForPhone:number]);
    switch (lenght.intValue) {
        case 8:
            return [self phoneFormatForPhoneLenght:lenght plusLocation:@(0) openBracketLocation:@(3) closeBracketLocation:@(5) firstGapLocation:@(8) secondGapLocation:@(100)];
            break;
        case 9:
            return [self phoneFormatForPhoneLenght:lenght plusLocation:@(0) openBracketLocation:@(3) closeBracketLocation:@(5) firstGapLocation:@(8) secondGapLocation:@(10)];
            break;
        case 10:
            return [self phoneFormatForPhoneLenght:lenght plusLocation:@(0) openBracketLocation:@(1) closeBracketLocation:@(4) firstGapLocation:@(7) secondGapLocation:@(9)];
            break;
        default:
            return [self phoneFormatForPhoneLenght:lenght plusLocation:@(0) openBracketLocation:nil closeBracketLocation:nil firstGapLocation:nil secondGapLocation:nil];
    }
}

- (NSString *)formatPhoneNumber:(NSString *)phoneNumber {
    PhoneFormat phoneFormat = [self formatForNumber:phoneNumber];
    PhoneComponents components = [self componentsFromPhoneNumberString:phoneNumber forFormat:phoneFormat];
    NSMutableString *output = [[NSMutableString new] autorelease];

    [output appendString:[self separatorFor:phoneFormat.plus.separatorType]];
    if (components.countryCode) {
        [output appendString:components.countryCode];
    }

    if (components.prefix) {
        [output appendString:[self separatorFor:phoneFormat.openBracket.separatorType]];
        [output appendString:components.prefix];
        [output appendString:[self separatorFor:phoneFormat.closeBracket.separatorType]];
    }

    if (components.firstGroup) {
        [output appendString:components.firstGroup];
    }

    if (components.secondGroup) {
        [output appendString:[self separatorFor:phoneFormat.firstGap.separatorType]];
        [output appendString:components.secondGroup];
    }

    if (components.thirdGroup) {
        [output appendString:[self separatorFor:phoneFormat.secondGap.separatorType]];
        [output appendString:components.thirdGroup];
    }

    return output;
}

- (PhoneComponents)componentsFromPhoneNumberString:(NSString *)string forFormat:(PhoneFormat)format {
    PhoneComponents components;
    components.countryCode = nil;
    components.prefix = nil;
    components.firstGroup = nil;
    components.secondGroup = nil;
    components.thirdGroup = nil;
    
    BOOL hasGap = format.firstGap.separatorType != None && string.length > format.closeBracket.location.integerValue;
    BOOL hasSecondGap = format.secondGap.separatorType != None && string.length > format.firstGap.location.integerValue;

    if (string.length >= format.openBracket.location.integerValue) {
        NSRange range = [self rangeBetweenSeparator1:format.plus andSep2:format.openBracket inString:string];
        components.countryCode = [string substringWithRange:range];
    }

    if (string.length > format.openBracket.location.integerValue) {
        NSRange range = [self rangeBetweenSeparator1:format.openBracket andSep2:format.closeBracket inString:string];
        components.prefix = [string substringWithRange:range];
    }

    if (hasGap) {
        NSRange range = [self rangeBetweenSeparator1:format.closeBracket andSep2:format.firstGap inString:string];
        components.firstGroup = [string substringWithRange:range];
    }

    if (hasSecondGap) {
        NSRange range = [self rangeBetweenSeparator1:format.firstGap andSep2:format.secondGap inString:string];
        components.secondGroup = [string substringWithRange:range];
    }

    if (format.secondGap.location.integerValue - (NSInteger)string.length < 0) {
        components.thirdGroup = [string substringFromIndex:format.secondGap.location.integerValue];
    }

    return components;
}

- (NSRange)rangeBetweenSeparator1:(Separator)sep1 andSep2:(Separator)sep2 inString:(NSString *)string {
    NSInteger maxLenght = sep2.location.integerValue - sep1.location.integerValue;
    NSInteger currentLenght = string.length - sep1.location.integerValue;
    NSInteger lenght = MIN(maxLenght, currentLenght);

    return NSMakeRange(sep1.location.integerValue, lenght);
}

- (PhoneFormat)phoneFormatForPhoneLenght:(NSNumber *)lenght
                            plusLocation:(NSNumber *)p
                     openBracketLocation:(NSNumber *)o
                    closeBracketLocation:(NSNumber *)c
                        firstGapLocation:(NSNumber *)f
                       secondGapLocation:(NSNumber *)s {

    BOOL cantBeFormatted = lenght.intValue > 11;
    SeparatorType gapType = lenght.intValue == 10 ? Space : MinusSign;

    Separator plus;
    plus.separatorType = PlusSign;
    plus.location = @(0);

    Separator openBracket;
    openBracket.separatorType = cantBeFormatted ? None : OpenBracket;
    openBracket.location = o;

    Separator closeBracket;
    closeBracket.separatorType = cantBeFormatted ? None : CloseBracket;
    closeBracket.location = c;

    Separator firstGap;
    firstGap.separatorType = cantBeFormatted ? None : gapType;
    firstGap.location = f;

    Separator secondGap;
    secondGap.separatorType = cantBeFormatted ? None : gapType;
    secondGap.location = s;

    PhoneFormat phoneFormat;
    phoneFormat.plus = plus;
    phoneFormat.openBracket = openBracket;
    phoneFormat.closeBracket = closeBracket;
    phoneFormat.firstGap = firstGap;
    phoneFormat.secondGap = secondGap;

    return phoneFormat;
}

- (NSString *)separatorFor:(SeparatorType)separator {
    switch (separator) {
        case PlusSign: return @"+";
            break;
        case MinusSign: return @"-";
            break;
        case OpenBracket: return @"(";
            break;
        case CloseBracket: return @")";
            break;
        case Space: return @" ";
            break;
        case None: return @"";
            break;
    }
}

@end

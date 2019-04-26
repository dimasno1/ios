//
//  PhoneComponents.h
//  RSSchool_T4
//
//  Created by Admin on 4/26/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#ifndef PhoneComponents_h
#define PhoneComponents_h


typedef enum {
    PlusSign,
    OpenBracket,
    CloseBracket,
    MinusSign,
    Space,
    None
} SeparatorType;

typedef struct {
    SeparatorType separatorType;
    NSNumber *location;
} Separator;

typedef struct {
    Separator plus;
    Separator openBracket;
    Separator closeBracket;
    Separator firstGap;
    Separator secondGap;
} PhoneFormat;

typedef struct {
    NSString *countryCode;
    NSString *prefix;
    NSString *firstGroup;
    NSString *secondGroup;
    NSString *thirdGroup;
} PhoneComponents;

#endif /* PhoneComponents_h */

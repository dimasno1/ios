#import "RomanTranslator.h"
#import "Collections+Extended.h"

@interface RomanTranslator()
@property(retain, nonatomic)NSMutableArray<NSNumber*> *bases;
@property(retain, nonatomic)NSDictionary<NSNumber*, NSString*> *arabicConversionKeys;
@property(retain, nonatomic)NSDictionary<NSString*, NSNumber*> *romanConversionKeys;
@end

@implementation RomanTranslator

- (instancetype)init {
    self = [super init];
    if (self) {
        NSArray<NSNumber *> *arabic = @[@(1), @(4), @(5), @(9), @(10), @(40), @(50), @(90), @(100), @(400), @(500), @(900), @(1000)];
        NSArray<NSString *> *roman = @[@"I", @"IV", @"V", @"IX", @"X", @"XL", @"L", @"XC", @"C", @"CD", @"D", @"CM", @"M"];
        _bases = [NSMutableArray new];
        _romanConversionKeys = [NSDictionary dictionaryWithObjects:arabic forKeys:roman];
        _arabicConversionKeys = [NSDictionary dictionaryWithObjects:roman forKeys:arabic];
    }
    
    return self;
}

- (NSString *)arabicFromRoman:(NSString *)romanString {
    NSMutableArray<NSNumber *> *numbers = [[NSMutableArray new] autorelease];
    
    for (int i = 0; i < romanString.length; i++) {
        NSRange range = NSMakeRange((romanString.length - 1) - i, 1);
        NSNumber *currentArabic = [self arabicRepresentationOfRoman:[romanString substringWithRange:range]];
        if (numbers.count > 0) {
            NSNumber *number = [numbers lastObject].intValue > currentArabic.intValue ? @(-currentArabic.intValue) : currentArabic;
            [numbers addObject: number];
        } else {
            [numbers addObject:currentArabic];
        }
    }
   
    return [[numbers reduceWithInitial:0 usingBlock:^id(NSNumber* result, NSNumber* element) {
        return @(result.intValue + element.intValue);
    }] stringValue];
}

- (NSString *)romanFromArabic:(NSString *)arabicString {
    NSNumber *number = @([arabicString intValue]);
    [self collectBasesFromNumber:number];
    
    NSString *resultString = [[_bases mapUsingBlock:^id(id element1) {
        return [self romanReperesentationOfArabic:element1];
    }] componentsJoinedByString:@""];
    
    [_bases removeAllObjects];
    return resultString;
}

- (NSNumber *)arabicRepresentationOfRoman:(NSString *)roman {
    return _romanConversionKeys[roman];
}

- (NSString *)romanReperesentationOfArabic:(NSNumber *)arabic {
    if (_arabicConversionKeys[arabic]) {
        return _arabicConversionKeys[arabic];
    } else {
        NSNumber* key = [self nearestDividerFor:arabic];
        int count = arabic.intValue / key.intValue;
        NSMutableArray *array = [[NSMutableArray new] autorelease];
        
        for (int i = 0; i < count; i++) {
            [array addObject:_arabicConversionKeys[key]];
        }
        
        return [array componentsJoinedByString:@""];
    }
}

- (void)collectBasesFromNumber:(NSNumber *)number {
    if (number.intValue == 0) {
        return;
    }
    
    int divider = [self nearestDividerFor:number].intValue;
    if (divider <= 1) {
        [self.bases addObject:number];
    } else {
        int remainder = number.intValue % divider;
        
        [_bases addObject:@(number.intValue - remainder)];
        [self collectBasesFromNumber:@(remainder)];
    }
}

- (NSNumber *)nearestDividerFor:(NSNumber *)value {
    NSMutableArray *distances = [[NSMutableArray new] autorelease];
    [_arabicConversionKeys.allKeys enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.intValue - value.intValue <= 0 ) {
            [distances addObject:obj];
        }
    }];
    
    return @([[distances valueForKeyPath:@"@max.intValue"] intValue]);
}

- (void)dealloc {
    [_arabicConversionKeys release];
    [_romanConversionKeys release];
    [_bases release];
    [super dealloc];
}

@end

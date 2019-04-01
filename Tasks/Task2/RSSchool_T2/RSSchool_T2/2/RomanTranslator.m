#import "RomanTranslator.h"
#import "Collections+Extended.h"

@interface RomanTranslator()
@property(retain, nonatomic)NSMutableArray<NSNumber*> *bases;
@property(retain, nonatomic)NSDictionary<NSNumber*, NSString*> *keys;
@end

@implementation RomanTranslator

- (instancetype)init {
    self = [super init];
    if (self) {
        _bases = [NSMutableArray new];
        _keys = @{@(1): @"I", @(4): @"IV", @(5) : @"V", @(9): @"IX", @(10): @"X", @(40): @"XL", @(50): @"L", @(90): @"LC", @(100): @"C", @(400): @"CD", @(500): @"D", @(900): @"DM", @(1000): @"M"};
    }
    
    return self;
}

- (NSString *)romanFromArabic:(NSString *)arabicString {
    NSNumber *number = @([arabicString intValue]);
    [_bases removeAllObjects];
    [self collectBasesFromNumber:number];
    
    NSString *resultString = [[_bases mapUsingBlock:^id(id element1) {
        return [self romanReperesentationOfArabic:element1];
    }] componentsJoinedByString:@""];
    
    return resultString;
}


- (NSString *)romanReperesentationOfArabic:(NSNumber *)arabic {
    if (_keys[arabic]) {
        return _keys[arabic];
    } else {
        NSNumber* key = [self nearestDividerFor:arabic];
        int count = arabic.intValue / key.intValue;
        NSMutableArray *array = [NSMutableArray new];
        
        for (int i = 0; i < count; i++) {
            [array addObject:_keys[key]];
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
    [_keys.allKeys enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.intValue - value.intValue <= 0 ) {
            [distances addObject:obj];
        }
    }];
    
    return @([[distances valueForKeyPath:@"@max.intValue"] intValue]);
}

- (void)dealloc {
    [_bases release];
    [super dealloc];
}

@end

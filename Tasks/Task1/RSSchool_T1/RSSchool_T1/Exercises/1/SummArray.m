#import "SummArray.h"

@implementation SummArray

// Complete the summArray function below.
- (NSNumber *)summArray:(NSArray *)array {
    [array retain];
    
    int result = 0;
    for(int i = 0; i < array.count; i++) {
        NSNumber *value = array[i];
        result += [value integerValue];
    }
    
    [array release];
    return @(result);
}

@end

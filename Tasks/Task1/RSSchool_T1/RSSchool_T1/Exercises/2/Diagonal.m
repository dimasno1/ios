#import "Diagonal.h"

@implementation Diagonal

// Complete the diagonalDifference function below.
- (NSNumber *) diagonalDifference:(NSArray *)array {
    [array retain];
    int primarySumm = 0;
    int secondarySumm = 0;
    
    for(int i = 0; i < array.count; i++) {
        NSArray *numbersArray = [array[i] componentsSeparatedByString:@" "];;
        NSNumber *primary = numbersArray[i];
        NSNumber *secondary = numbersArray[(array.count - 1) - i];
        
        primarySumm += [primary integerValue];
        secondarySumm += [secondary integerValue];
    }
    
    [array release];
    return [NSNumber numberWithInt: abs(primarySumm - secondarySumm)];
}

@end

#import "Encryption.h"

@implementation Encryption

// Complete the encryption function below.
- (NSString *)encryption:(NSString *)string {
    [string retain];
    
    NSString *noWhitespacesMessage = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSUInteger lenght = [noWhitespacesMessage length];
    NSNumber *lenghtSquareRoot = @(sqrt(lenght));
    
    int rows = floorf(lenghtSquareRoot.doubleValue);
    int columns = ceilf(lenghtSquareRoot.doubleValue);
    int lastRowLettersCount = (lenght % columns) == 0 ? columns : lenght % columns;
    
    if (rows * columns < lenght) {
        rows < columns ? rows++ : columns++;
    }
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:rows];
    for (int i = 0; i < rows; i++) {
        BOOL lastRow = i == rows - 1;
        NSRange range =  NSMakeRange(i * columns, lastRow ? lastRowLettersCount : columns);
        NSString *cuttedMessage = [noWhitespacesMessage substringWithRange:range];
        [array addObject:cuttedMessage];
    }
    
    [string release];
    return [self encryptedStringWithContentsOfArray:array];
}

- (NSString *)encryptedStringWithContentsOfArray:(NSArray *)array {
    [array retain];
    NSInteger capacity = [[array firstObject] length];
    NSMutableArray *encrypted = [NSMutableArray arrayWithCapacity:capacity];
    
    for (int i = 0; i < capacity; i++) {
        [encrypted addObject:@""];
    }
    
    for (int rowIndex = 0; rowIndex < [array count]; rowIndex++) {
        NSString *cuttedString = [array objectAtIndex:rowIndex];
        for(int letterIndex = 0; letterIndex < [cuttedString length]; letterIndex ++) {
            NSString *character = [NSString stringWithFormat:@"%C", [cuttedString characterAtIndex:letterIndex]];
            NSMutableString *resultString = [[[encrypted objectAtIndex:letterIndex] mutableCopy] autorelease];
            
            [resultString appendString:character];
            [encrypted replaceObjectAtIndex:letterIndex withObject:resultString];
        }
    }
    
    [array release];
    return [encrypted componentsJoinedByString:@" "];
}

@end

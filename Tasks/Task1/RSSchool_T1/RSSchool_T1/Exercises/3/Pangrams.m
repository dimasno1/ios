#import "Pangrams.h"


// Pangrams+Extended

@interface NSCharacterSet(Extended)
+ (NSCharacterSet *) latinLettersLowercased;
@end

@implementation NSCharacterSet(Extended)
+ (NSCharacterSet *)latinLettersLowercased {
    return [NSCharacterSet characterSetWithCharactersInString: @"abcdefghijklmnopqrstuvwxyz"];
}
@end

// Pangrams

@implementation Pangrams

- (BOOL)pangrams:(NSString *)string {
    [string retain];
    
    NSString *noWhitespacesLowercasedString = [[string stringByReplacingOccurrencesOfString:@" " withString:@""] lowercaseString];
    NSCharacterSet *givenSet = [NSCharacterSet characterSetWithCharactersInString:noWhitespacesLowercasedString];

    [string release];
    return [givenSet isEqual:NSCharacterSet.latinLettersLowercased];
}

@end

#import "KidnapperNote.h"
#import "Collections+Extended.h"

@implementation KidnapperNote

- (BOOL)checkMagazine:(NSString *)magaine note:(NSString *)note {
    NSArray<NSString *> *words = [[note componentsSeparatedByString:@" "] valueForKey:@"lowercaseString"];
    NSMutableString *editableMagazine = [[[magaine lowercaseString] mutableCopy] autorelease];

    BOOL (^reduceBlock)(BOOL, id) = ^BOOL(BOOL result, id word) {
        BOOL newResult = result && [editableMagazine containsString:word];

        if (newResult) {
            NSRange range = [editableMagazine rangeOfString:word];
            [editableMagazine replaceCharactersInRange:range withString:@""];
        }

        return newResult;
    };

    return [words reduceBoolWithInitial:YES usingBlock: reduceBlock];
}

@end

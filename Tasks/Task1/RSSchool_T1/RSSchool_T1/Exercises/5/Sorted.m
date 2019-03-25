#import "Sorted.h"

typedef struct {
    NSInteger first;
    NSInteger second;
} SwapIndexes ;

@interface NSArray(Extended)

+ (NSArray*)numberedFromString: (NSString *)string;
- (NSArray*)sortedAscending:(BOOL)flag;
- (SwapIndexes)mismatchedValuesIndexesComparableWith:(NSArray *)array;
- (BOOL)canBeSortedBySwappingObjectsAtIndexes:(SwapIndexes)indexes equallyTo:(NSArray *)array;
- (BOOL)canBeSortedByReverseObjectsInRangeFromIndexes:(SwapIndexes)indexes equallyTo:(NSArray *)array;

@end

@implementation NSArray(Extended)

+ (NSArray*)numberedFromString: (NSString *)string {
    return [[string componentsSeparatedByString:@" "]valueForKey:@"integerValue"];
}

- (NSArray*)sortedAscending:(BOOL)flag {
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"" ascending:flag];
    NSArray *sortDescriptors = [NSArray arrayWithObject:descriptor];
    return [self sortedArrayUsingDescriptors:sortDescriptors];
}

- (SwapIndexes)mismatchedValuesIndexesComparableWith:(NSArray *)array {
    [array retain];

    SwapIndexes indexes;
    indexes.first = 0;
    indexes.second = 0;

    while ([[self objectAtIndex:indexes.first] isEqual:[array objectAtIndex:indexes.first]] || indexes.first == self.count - 1) {
        indexes.first += 1;
    }

    id properValue = [array objectAtIndex:indexes.first];
    indexes.second = [self indexOfObject:properValue];

    [array release];
    return indexes;
}

- (BOOL)canBeSortedBySwappingObjectsAtIndexes:(SwapIndexes)indexes equallyTo:(NSArray *)array {
    NSMutableArray *copy = [[self mutableCopy] autorelease];
    id properValue = [array objectAtIndex:indexes.first];
    id mismatchedValue = [array objectAtIndex:indexes.second];

    [copy replaceObjectAtIndex:indexes.first withObject:properValue];
    [copy replaceObjectAtIndex:indexes.second withObject:mismatchedValue];

    return [copy isEqual:array];
}

- (BOOL)canBeSortedByReverseObjectsInRangeFromIndexes:(SwapIndexes)indexes equallyTo:(NSArray *)array {
    NSMutableArray *copy = [[self mutableCopy] autorelease];
    NSRange range = NSMakeRange(indexes.first, (indexes.second + 1) - indexes.first);
    NSArray *reversedSub = [[[self subarrayWithRange:range]reverseObjectEnumerator]allObjects];
    [copy replaceObjectsInRange:range withObjectsFromArray:reversedSub];

    return [copy isEqual:array];;
}
@end

@implementation ResultObject

- (void)dealloc {
    [_detail release];
    [super dealloc];
}
@end

@implementation Sorted

- (ResultObject*)sorted:(NSString*)string {
    [string retain];
    ResultObject *value = [[ResultObject new] autorelease];

    NSArray *properlySortedArray = [[NSArray numberedFromString:string] sortedAscending:true];
    NSArray *givenArray = [NSArray numberedFromString:string];
    [value setStatus:YES];
    [string release];
    SwapIndexes indexes = [givenArray mismatchedValuesIndexesComparableWith:properlySortedArray];

    if ([givenArray isEqualToArray:properlySortedArray]) {
    } else if ([givenArray canBeSortedBySwappingObjectsAtIndexes:indexes equallyTo:properlySortedArray]) {
        NSString *output = [NSString stringWithFormat:@"swap %ld %ld", indexes.first + 1, indexes.second + 1];
        [value setDetail:output];
    } else if ([givenArray canBeSortedByReverseObjectsInRangeFromIndexes:indexes equallyTo:properlySortedArray]) {
        NSString *output = [NSString stringWithFormat:@"reverse %ld %ld", indexes.first + 1, indexes.second + 1];
        [value setDetail:output];
    } else {
        [value setStatus:NO];
    }

    return value;
}

@end

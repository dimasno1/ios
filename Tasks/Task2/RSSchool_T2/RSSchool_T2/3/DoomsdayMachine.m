#import "DoomsdayMachine.h"

@interface DoomsdayMachine()

@property(retain, nonatomic)NSDateFormatter *dateFormatter;

@end

@implementation DoomsdayMachine

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dateFormatter = [NSDateFormatter new];
        _dateFormatter.dateFormat = @"yyyy:MM:dd@ss\\mm/HH";
    }
    return self;
}

- (id<AssimilationInfo>)assimilationInfoForCurrentDateString:(NSString *)dateString {
    NSDate *date = [_dateFormatter dateFromString:dateString];
    
    
    return [DDAssimilationInfo new];
}

- (void)dealloc {
    [_dateFormatter release];
    [super dealloc];
}

@end

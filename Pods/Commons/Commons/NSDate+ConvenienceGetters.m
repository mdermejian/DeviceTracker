//
//  NSDate+ConvenienceGetters.m
//  Commons
//
//  Created by Marc Dermejian on 07/05/2015.
//

#import "NSDate+ConvenienceGetters.h"
#import "NSDateFormatter+Singleton.h"

@implementation NSDate (ConvenienceGetters)

- (NSInteger)year {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitYear fromDate:self];
    return [components year];
}


- (NSInteger)month {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitMonth fromDate:self];
    return [components month];
}

- (NSInteger)day {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitDay fromDate:self];
    return [components day];
}

- (NSInteger)hour {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitHour fromDate:self];
    return [components hour];
}

/* OLD IMPLEMENTATION
- (NSString *)weekString {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitWeekday fromDate:self];
    switch (dateComponents.weekday) {
        case 1: {
            return NSLocalizedString(@"sunday", @"");
        }
            break;
            
        case 2: {
            return NSLocalizedString(@"monday", @"");
        }
            break;
            
        case 3: {
            return NSLocalizedString(@"tuesday", @"");
        }
            break;
            
        case 4: {
            return NSLocalizedString(@"wednesday", @"");
        }
            break;
            
        case 5: {
            return NSLocalizedString(@"thursday", @"");
        }
            break;
            
        case 6: {
            return NSLocalizedString(@"friday", @"");
        }
            break;
            
        case 7: {
            return NSLocalizedString(@"saturday", @"");
        }
            break;
            
        default:
            break;
    }
    
    return @"";
}
*/

- (NSString *)weekdayString {
    NSDateFormatter *dateFormatter = [NSDateFormatter sharedDateFormatter];
    [dateFormatter setDateFormat:@"EEEE"];
    NSString *dayName = [dateFormatter stringFromDate:self];
    return dayName;
}

// OLD IMPLEMENTATION
//- (NSUInteger)weekday
//{
//    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekday forDate:self];
//}

- (NSInteger)weekday
{
    //using gregorian calendar which returns 1 for sunday, etc....
    return
    [[[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] components:NSCalendarUnitWeekday fromDate:self] weekday];
}

@end

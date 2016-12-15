//
//  NSDate+Additions.m
//  Commons
//
//  Created by Marc Dermejian on 04/02/2015.
//

#import "NSDate+Additions.h"
#import "NSDateFormatter+Singleton.h"
#import "NSDate+ConvenienceConstructor.h"

@implementation NSDate (Additions)

- (BOOL)isToday
{
    return [[NSDate dateStartOfDay:self] isEqualToDate:[NSDate dateStartOfDay:[NSDate date]]];
}

- (NSUInteger)cc_numberOfDaysInMonth
{
    return [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
}

- (BOOL) isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate {
    return (([self compare:beginDate] != NSOrderedAscending) && ([self compare:endDate] != NSOrderedDescending));
}

+ (NSInteger)daysBetweenStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned int unitFlags = NSCalendarUnitDay;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:startDate toDate:endDate options:0];
    //    int months = [comps month];
    NSInteger days = [comps day];
    return days;
}

+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format {
    if (!format)
        format = @"yyyy-MM-dd";
    NSDateFormatter *dateFormatter = [NSDateFormatter sharedDateFormatter];
    [dateFormatter setDateFormat:format];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

+ (NSDateComponents *)nowDateComponents {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:flags fromDate:[NSDate date]];
}

+ (NSDateComponents *)dateComponentsFromNow:(NSInteger)days {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:flags fromDate:[[NSDate date] dateByAddingTimeInterval:days * 24 * 60 * 60]];
}

- (NSDateComponents *)cc_componentsForMonthDayAndYear
{
    return [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
}

@end

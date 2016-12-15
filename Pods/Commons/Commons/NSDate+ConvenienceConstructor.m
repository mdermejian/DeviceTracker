//
//  NSDate+ConvenienceConstructor.m
//  Commons
//
//  Created by Marc Dermejian on 07/05/2015.
//

#import "NSDate+ConvenienceConstructor.h"
#import "NSDateFormatter+Singleton.h"

@implementation NSDate (ConvenienceConstructor)

+ (NSDate *)dateForDay:(NSInteger)day month:(NSInteger)month year:(NSInteger)year
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = day;
    components.month = month;
    components.year = year;
    return [gregorian dateFromComponents:components];
}

+ (NSDate *)dateFromString:(NSString *)dateString format:(NSString *)format {
    if (!format)
        format = @"yyyy-MM-dd";
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDateFormatter *dateFormatter = [NSDateFormatter sharedDateFormatter];
    [dateFormatter setDateFormat:format];
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}

+ (NSDate *)dateFromString:(NSString *)dateString {
    return [self dateFromStringBySpecifyTime:dateString hour:0 minute:0 second:0];
}

+ (NSDate *)dateFromStringBySpecifyTime:(NSString *)dateString hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second {
    NSArray *arrayDayTime = [dateString componentsSeparatedByString:@" "];
    NSArray *arrayDay = [arrayDayTime[0] componentsSeparatedByString:@"-"];
    
    NSInteger flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *tmpDateComponents = [calendar components:flags fromDate:[NSDate date]];
    tmpDateComponents.year = [arrayDay[0] intValue];
    tmpDateComponents.month = [arrayDay[1] intValue];
    tmpDateComponents.day = [arrayDay[2] intValue];
    if ([arrayDayTime count] > 1) {
        NSArray *arrayTime = [arrayDayTime[1] componentsSeparatedByString:@":"];
        tmpDateComponents.hour = [arrayTime[0] intValue];
        tmpDateComponents.minute = [arrayTime[1] intValue];
        tmpDateComponents.second = [arrayTime[2] intValue];
    }
    else {
        tmpDateComponents.hour = hour;
        tmpDateComponents.minute = minute;
        tmpDateComponents.second = second;
    }
    return [calendar dateFromComponents:tmpDateComponents];
}

- (NSDate *)dateByMovingToBeginningOfDay
{
    unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents* parts = [[NSCalendar currentCalendar] components:flags fromDate:self];
    [parts setHour:0];
    [parts setMinute:0];
    [parts setSecond:0];
    return [[NSCalendar currentCalendar] dateFromComponents:parts];
}

- (NSDate *)dateByMovingToEndOfDay
{
    unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents* parts = [[NSCalendar currentCalendar] components:flags fromDate:self];
    [parts setHour:23];
    [parts setMinute:59];
    [parts setSecond:59];
    return [[NSCalendar currentCalendar] dateFromComponents:parts];
}

- (NSDate *)dateByMovingToFirstDayOfTheMonth
{
    NSDate *d = nil;
    [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitMonth startDate:&d interval:NULL forDate:self];
    return d;
}

- (NSDate *)dateByMovingToFirstDayOfThePreviousMonth
{
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.month = -1;
    return [[[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0] dateByMovingToFirstDayOfTheMonth];
}

- (NSDate *)dateByMovingToFirstDayOfTheFollowingMonth
{
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.month = 1;
    return [[[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0] dateByMovingToFirstDayOfTheMonth];
}

+ (NSDate*) dateFromWeekday:(NSInteger)weekday hours:(NSInteger)hours andMinutes:(NSInteger)minutes
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    
    NSDateComponents *components = [gregorian components:NSCalendarUnitYear | NSCalendarUnitWeekOfMonth | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:[NSDate date]];
    
    [components setWeekday:weekday];
    [components setHour:hours];
    [components setMinute:minutes];
    NSDate *date = [gregorian dateFromComponents:components];
    
    return date;
}

+ (NSDate *)dateStartOfDay:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *components =
    [gregorian               components:(NSCalendarUnitYear | NSCalendarUnitMonth |
                                         NSCalendarUnitDay) fromDate:date];
    return [gregorian dateFromComponents:components];
}

- (NSDate *)offsetDay:(NSInteger)numDays {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //    [gregorian setFirstWeekday:2]; //monday is first day
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:numDays];
    //[offsetComponents setHour:1];
    //[offsetComponents setMinute:30];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:self options:0];
}

@end

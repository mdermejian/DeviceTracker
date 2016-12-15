//
//  NSDate+ConvenienceConstructor.h
//  Commons
//
//  Created by Marc Dermejian on 07/05/2015.
//

#import <Foundation/Foundation.h>

@interface NSDate (ConvenienceConstructor)

/*!
 @abstract
 returns an NSDate instance from the passed in day, month & year values using the Gregorian calendar
 
 @param day the day component of the return value
 @param month the month component of the return value
 @param year the year component of the return value
 */
+ (NSDate *)dateForDay:(NSInteger)day month:(NSInteger)month year:(NSInteger)year;


/*!
 @abstract
 returns an NSDate value from a passed in date NSString and format
 
 @param dateString the date NSString value to transform to NSDate
 @param format the format to use converting the date NSString to an NSDate instance. Could be nil, in which case "yyyy-MM-dd" is used
 */
+ (NSDate *)dateFromString:(NSString *)dateString format:(NSString *)format;


/*!
 @abstract
 returns an NSDate value from a passed in date NSString. Uses dateFromStringBySpecifyTime: hour: minute: second: 
 
 @see + (NSDate *)dateFromStringBySpecifyTime:(NSString *)dateString hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;
 
 @param dateString the date NSString value to attempt to convert to NSDate
 */
+ (NSDate *)dateFromString:(NSString *)dateString;


/*!
 @abstract
 Constructs an NSDate obtained by decomposing a dateString and (optionally) using hour, minute and second parameter values
 
 @param dateString the string date to decompose for constructing the NSDate
 @param hour optional hour value for the return NSDate
 @param minute optional minute value for the return NSDate
 @param second optional second value for the return NSDate
 */
+ (NSDate *)dateFromStringBySpecifyTime:(NSString *)dateString hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;



/*!
 @abstract
 returns an NSDate instance obtained by moving the time back from the receiver's NSDate to 0:0:0
 */
- (NSDate *)dateByMovingToBeginningOfDay;


/*!
 @abstract
 returns an NSDate instance obtained by moving the time ahead from the receiver's NSDate to 23:59:59
 */
- (NSDate *)dateByMovingToEndOfDay;


/*!
 @abstract
 returns an NSDate instance obtained by moving back to the first day of the current month from the receiver NSDate
 */
- (NSDate *)dateByMovingToFirstDayOfTheMonth;


/*!
 @abstract
 returns an NSDate instance obtained by moving back to the first day of the previous month from the receiver NSDate
 */
- (NSDate *)dateByMovingToFirstDayOfThePreviousMonth;


/*!
 @abstract
 returns an NSDate instance obtained by moving forward to the first day of the following month from the receiver NSDate
 */
- (NSDate *)dateByMovingToFirstDayOfTheFollowingMonth;



/*!
 @abstract
 returns the NSDate instance obtained by setting the weekday, hours and minutes from the parameters and the day attributes from the current day
 
 @param weekday the day of week to use in constructing the return NSDate value
 @param hours the hour value to use in constructing the return NSDate value
 @param minutes the minutes value to use in constructing the return NSDate value
 */
+ (NSDate*) dateFromWeekday:(NSInteger)weekday hours:(NSInteger)hours andMinutes:(NSInteger)minutes;



/*!
 @abstract
 returns an NSDate instance obtained by moving the NSDate instance passed as parameter to 0:0:0
 
 @param date the NSDate instance to move back to start of day
 */
+ (NSDate *)dateStartOfDay:(NSDate *)date;


/*!
 @abstract
 returns an NSDate instance obtained by moving the receiver NSDate forward of backwards a number of days (parameter)
 
 @param numDays the number of days to move the receiver. Negative number for moving back
 */
- (NSDate *)offsetDay:(NSInteger)numDays;

@end

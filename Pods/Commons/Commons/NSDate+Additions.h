//
//  NSDate+Additions.h
//  Commons
//
//  Created by Marc Dermejian on 04/02/2015.
//

#import <Foundation/Foundation.h>

@interface NSDate (Additions)

/*!
 @abstract
 returns YES if receiver NSDate instance is today, NO otherwise
 */
- (BOOL)isToday;


/*!
 @abstract
 returns an NSUInteger value representing the number of days in the month from the receiver NSDate instance
 */
- (NSUInteger)cc_numberOfDaysInMonth;


/*!
 @abstract
 compares the receiver NSDate instance and returns YES in case it is after beginDate and before endDate
 
 @param beginDate the NSDate value to compare to self
 @param endDate the NSDate value to compare to self
 */
- (BOOL) isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate;


/*!
 @abstract
 returns an NSInteger value representing the number of days between startDate and endDate
 
 @param startDate the NSDate instance to use as starting date
 @param endDate the NSDate instance  to use as ending date
 */
+ (NSInteger)daysBetweenStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;


/*!
 @abstract
 returns an NSString instance representing the NSDate passed as parameter, formatted using the formatting passed as parameter or a default formatting "yyyy-MM-dd"
 
 @param date the NSDate instance to transform to NSString
 @param format the formatting to use to represent the NSDate
 */
+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format;


/*!
 @abstract
 Returns the NSDateComponents from the current date and time NSDate instance
 
 The date components returned are: NSCalendarUnitYear, NSCalendarUnitMonth, NSCalendarUnitDay, NSCalendarUnitHour, NSCalendarUnitMinute & NSCalendarUnitSecond
 */
+ (NSDateComponents *)nowDateComponents;


/*!
 @abstract
 Returns the NSDateComponents from the NSDate instance obtained by adding a number of days to the current date. The number of days is indicated by the passed in parameter "days"
 
 The date components returned are: NSCalendarUnitYear, NSCalendarUnitMonth, NSCalendarUnitDay, NSCalendarUnitHour, NSCalendarUnitMinute & NSCalendarUnitSecond

 @param days the number of days to add to the current date
 */
+ (NSDateComponents *)dateComponentsFromNow:(NSInteger)days;


/*!
 @abstract
 Returns the NSDateComponents from self NSDate instance
 
 The date components returned are: NSCalendarUnitYear, NSCalendarUnitMonth & NSCalendarUnitDay
 */
- (NSDateComponents *)cc_componentsForMonthDayAndYear;

@end

//
//  NSDate+ConvenienceGetters.h
//  Commons
//
//  Created by Marc Dermejian on 07/05/2015.
//

#import <Foundation/Foundation.h>

@interface NSDate (ConvenienceGetters)



/*!
 @abstract
 returns an NSInteger value representing the NSCalendarUnitYear component of self 
 */
- (NSInteger)year;


/*!
 @abstract
 returns an NSInteger value representing the NSCalendarUnitMonth component of self
 */
- (NSInteger)month;


/*!
 @abstract
 returns an NSInteger value representing the NSCalendarUnitDay component of self
 */
- (NSInteger)day;


/*!
 @abstract
 returns an NSInteger value representing the NSCalendarUnitHour component of self
 */
- (NSInteger)hour;


/*!
 @abstract
 returns an NSString value representing the name of the weekday (ie. Sunday, Monday,...) from self
 */
- (NSString *)weekdayString;


/*!
 @abstract
 returns an NSInteger value representing the number of days between startDate and endDate
 */
- (NSInteger)weekday;

@end

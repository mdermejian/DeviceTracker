//
//  NSDateFormatter+Singleton.h
//  Commons
//
//  Created by Marc Dermejian on 13/02/2015.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (Singleton)

/*!
 @abstract
 creates or returns an NSDateFormatter singleton instance
 
 @discussion
 Creating a date formatter is not a cheap operation. If you are likely to use a formatter frequently, it is typically more efficient to cache a single instance than to create and dispose of multiple instances.

 Thus the use of a singleton instance for performance/reusability reasons
 */
+ (instancetype)sharedDateFormatter;



/*!
 @abstract
 returns the singleton NSDateFormatter instance formatted using the en_US_POSIX locale and UTC timezone
 
 Good info on internet dates here:
 http://developer.apple.com/iphone/library/qa/qa2010/qa1480.html
 */
+ (instancetype)internetDateTimeFormatter;



/*!
 @abstract
 returns the singleton NSDateFormatter instance formatted using the en_US locale, GMT timezone and EEE',' dd MMM yyyy HH':'mm':'ss z date format
 */
+ (instancetype)RFC1123DateFormatter;



/*!
 @abstract
 returns the singleton NSDateFormatter instance formatted using the en_US locale, GMT timezone and EEE',' dd MMM yyyy HH':'mm':'ss 'GMT' date format
 */
+ (instancetype)RFC1123FullDateOutputFormatter;




/*!
 @abstract
 returns the singleton NSDateFormatter instance formatted using the en_US locale, GMT timezone and HH':'mm':'ss date format
 */
+ (instancetype)RFC1123TimeOutputFormatter;




/*!
 @abstract
 returns the singleton NSDateFormatter instance formatted using the en_US locale, GMT timezone and EEEE',' dd'-'MMM'-'yy HH':'mm':'ss z date format
 */
+ (instancetype)RFC850DateFormatter;



/*!
 @abstract
 returns the singleton NSDateFormatter instance formatted using the en_US locale, GMT timezone and EEE MMM d HH':'mm':'ss yyyy date format
 */
+ (instancetype)ASCDateFormatter;


@end

//
//  NSDate+RFC3339.m
//  Commons
//
//  Created by Marc Dermejian on 01/04/2015.
//

#import "NSDate+RFC3339.h"
#import "NSDateFormatter+Singleton.h"

// Always keep the formatter around as they're expensive to instantiate
//static NSDateFormatter *_internetDateTimeFormatter = nil;

@implementation NSDate (RFC3339)

/*
// MOVED TO NSDateFormatter+Singleton.h
// Instantiate single date formatter
+ (NSDateFormatter *)internetDateTimeFormatter {
    @synchronized(self) {
        if (!_internetDateTimeFormatter) {
            NSLocale *en_US_POSIX = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
            _internetDateTimeFormatter = [[NSDateFormatter alloc] init];
            [_internetDateTimeFormatter setLocale:en_US_POSIX];
            [_internetDateTimeFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        }
    }
    return _internetDateTimeFormatter;
}
*/

// See http://www.faqs.org/rfcs/rfc3339.html
+ (NSDate *)dateFromRFC3339String:(NSString *)RFC3339String {
    // Keep dateString around a while (for thread-safety)
    NSDate *date = nil;
    if (RFC3339String) {
        NSDateFormatter *dateFormatter = [NSDateFormatter internetDateTimeFormatter];
        if (!date) { // 2015-04-01T11:41:58.989Z
            [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.S'Z'"];
            date = [dateFormatter dateFromString:RFC3339String];
        }
        if (!date) { // 1996-12-19T16:39:57-0800
            [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"];
            date = [dateFormatter dateFromString:RFC3339String];
        }
        if (!date) { // 1937-01-01T12:00:27.87+0020
            [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSZZZ"];
            date = [dateFormatter dateFromString:RFC3339String];
        }
        if (!date) { // 1937-01-01T12:00:27
            [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss"];
            date = [dateFormatter dateFromString:RFC3339String];
        }
        if (!date) NSLog(@"Could not parse RFC3339 date: \"%@\" Possible invalid format.", RFC3339String);
        
    }
    // Finished with date string
    return date;
}

@end

//
//  NSDateFormatter+Singleton.m
//  Commons
//
//  Created by Marc Dermejian on 13/02/2015.
//

#import "NSDateFormatter+Singleton.h"

@implementation NSDateFormatter (Singleton)

+ (instancetype)sharedDateFormatter
{
    static NSDateFormatter *_dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setLocale:[NSLocale currentLocale]];
        _dateFormatter.dateStyle = NSDateFormatterLongStyle;
        _dateFormatter.timeStyle = NSDateFormatterShortStyle;
    });
    
    return _dateFormatter;
}

+ (instancetype)internetDateTimeFormatter {

    NSDateFormatter *dateFormatter = [NSDateFormatter sharedDateFormatter];
    NSLocale *en_US_POSIX = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:en_US_POSIX];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];

    return dateFormatter;
}

+ (instancetype)RFC1123DateFormatter
{
    NSDateFormatter *dateFormatter = [NSDateFormatter sharedDateFormatter];

    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    dateFormatter.dateFormat = @"EEE',' dd MMM yyyy HH':'mm':'ss z";
    
    return dateFormatter;
}

+ (instancetype)RFC1123FullDateOutputFormatter
{
    NSDateFormatter *dateFormatter = [NSDateFormatter sharedDateFormatter];
    
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    dateFormatter.dateFormat = @"EEE',' dd MMM yyyy HH':'mm':'ss 'GMT'";
    
    return dateFormatter;
}

+ (instancetype)RFC1123TimeOutputFormatter
{
    NSDateFormatter *dateFormatter = [NSDateFormatter sharedDateFormatter];
    
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    dateFormatter.dateFormat = @"HH':'mm':'ss";
    
    return dateFormatter;
}

+ (instancetype)RFC850DateFormatter
{
    NSDateFormatter *dateFormatter = [NSDateFormatter sharedDateFormatter];
    
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    dateFormatter.dateFormat = @"EEEE',' dd'-'MMM'-'yy HH':'mm':'ss z";
    
    return dateFormatter;
}

+ (instancetype)ASCDateFormatter
{
    NSDateFormatter *dateFormatter = [NSDateFormatter sharedDateFormatter];
    
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    dateFormatter.dateFormat = @"EEE MMM d HH':'mm':'ss yyyy";
    
    return dateFormatter;
}

@end

//
//  NSDecimalNumber+NullCheck.m
//  Commons
//
//  Created by Marc Dermejian on 13/04/2015.
//

#import "NSDecimalNumber+NullReplacement.h"

@implementation NSDecimalNumber (NullReplacement)

+ (NSDecimalNumber *)decimalNumberWithStringCheckingForNullValue:(NSString *)numberValue
{
    if ([numberValue isKindOfClass:[NSNull class]]) {
        return [NSDecimalNumber zero];
    }
    if ([numberValue rangeOfString:@"null" options:NSCaseInsensitiveSearch].location != NSNotFound) {
        return [NSDecimalNumber zero];
    }
    /* FOLLOWING ONLY WORKS ON iOS8+
    if ([numberValue containsString:@"null"]) {
        return [NSDecimalNumber zero];
    }
    */
    return [NSDecimalNumber decimalNumberWithString:numberValue];
}

@end

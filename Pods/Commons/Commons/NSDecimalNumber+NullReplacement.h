//
//  NSDecimalNumber+NullCheck.h
//  Commons
//
//  Created by Marc Dermejian on 13/04/2015.
//

#import <Foundation/Foundation.h>

@interface NSDecimalNumber (NullReplacement)


/*!
 @abstract
 returns an NSDecimalNumber instance from the NSString numeric value
 
 @param numberValue the NSString value to convert to NSDecimalNumber

 @discussion
 This uses NSDecimalNumber's decimalNumberWithString: to convert an NSString to NSDecimalNumber, but it first checks for null values returning [NSDecimalNumber zero]
 */
+ (NSDecimalNumber *)decimalNumberWithStringCheckingForNullValue:(NSString *)numberValue;

@end

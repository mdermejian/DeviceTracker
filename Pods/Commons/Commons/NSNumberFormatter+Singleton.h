//
//  NSNumberFormatter+Singleton.h
//  Commons
//
//  Created by Marc Dermejian on 10/11/2014.
//

#import <Foundation/Foundation.h>

@interface NSNumberFormatter (Singleton)


/*!
 @abstract
 creates or returns an NSNumberFormatter singleton instance
 
 @discussion
 The most critical detail to keep in mind when using formatters is that they are extremely expensive to create. Even just an alloc init of an NSNumberFormatter in a tight loop is enough to bring an app to its knees.
 
 Thus the use of a singleton instance for performance/reusability reasons
 */
+ (instancetype)sharedNumberFormatter;

/*!
 @abstract
 returns an NSNumberFormatter using the sharedNumberFormatter customized using the currencyCode
 @see currencyFormatterUsingCurrencyCode:inLocale:
 */
+ (instancetype)currencyFormatterUsingCurrencyCode:(NSString *)currencyCode;

/*!
 @abstract
 returns an NSNumberFormatter using the sharedNumberFormatter customized using the currencyCode and the locale identifier
 */
+ (instancetype)currencyFormatterUsingCurrencyCode:(NSString *)iso4217currencyCode inLocale:(NSString *)localeIdentifier;

@end

//
//  NSNumberFormatter+Singleton.m
//  Commons
//
//  Created by Marc Dermejian on 10/11/2014.
//

#import "NSNumberFormatter+Singleton.h"

@implementation NSNumberFormatter (Singleton)

+ (instancetype)sharedNumberFormatter
{
    static NSNumberFormatter *_numberFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _numberFormatter = [[NSNumberFormatter alloc] init];
        [_numberFormatter setLocale:[NSLocale currentLocale]];
        [_numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [_numberFormatter setMaximumFractionDigits:2];
        [_numberFormatter setMinimumFractionDigits:2];
        //TODO: check rounding
        //[_numberFormatter setRoundingMode:NSNumberFormatterRoundDown];
    });
    
    return _numberFormatter;
}

+ (instancetype)currencyFormatterUsingCurrencyCode:(NSString *)currencyCode
{
    return [NSNumberFormatter currencyFormatterUsingCurrencyCode:currencyCode inLocale:[[NSLocale currentLocale] localeIdentifier]];
}

+ (instancetype)currencyFormatterUsingCurrencyCode:(NSString *)iso4217currencyCode inLocale:(NSString *)localeIdentifier
{
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:localeIdentifier];
    if (!locale) {
        locale = [NSLocale currentLocale];
    }
    
    NSNumberFormatter *currencyFormatter = [NSNumberFormatter sharedNumberFormatter];
    currencyFormatter.locale = locale;
    currencyFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    
    //TODO: untested! using line 3 below instead!
//    NSString *currencySymbol = [NSString stringWithFormat:@"%@",[locale displayNameForKey:NSLocaleCurrencySymbol value:iso4217currencyCode]];
//    currencyFormatter.currencySymbol = currencySymbol;
    //line 3:
    currencyFormatter.currencyCode = iso4217currencyCode;
    
    return currencyFormatter;
}

@end

//
//  NSString+CurrencySymbol.m
//  Commons
//
//  Created by Marc Dermejian on 24/11/2014.
//

#import "NSString+CurrencySymbol.h"

@implementation NSString (CurrencySymbol)

+ (NSString*)currencySymbolForCode:(NSString*)currencyCode
{
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:currencyCode];
    if (locale) {
        NSString *currencySymbol = [NSString stringWithFormat:@"%@",[locale displayNameForKey:NSLocaleCurrencySymbol value:currencyCode]];
        return currencySymbol;
    }
    return nil;
}

+ (NSString*)currencyLocalizedNameForCode:(NSString*)currencyCode
{
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:currencyCode];
    if (locale) {
        NSString *currencyName = [NSString stringWithFormat:@"%@",[locale displayNameForKey:NSLocaleCurrencyCode value:currencyCode]];
        return currencyName;
    }
    return nil;
}

@end

//
//  NSDictionary+NullReplacement.m
//  Commons
//
//  Created by Marc Dermejian on 04/02/2015.
//

#import "NSDictionary+NullReplacement.h"
#import "NSArray+NullReplacement.h"

@implementation NSDictionary (NullReplacement)

- (NSDictionary *)dictionaryByRemovingNulls {
    const NSMutableDictionary *replaced = [self mutableCopy];
    const id nul = [NSNull null];
    
    for (NSString *key in self) {
        id object = [self objectForKey:key];
        if (object == nul) [replaced removeObjectForKey:key];
        else if ([object isKindOfClass:[NSDictionary class]]) [replaced setObject:[object dictionaryByRemovingNulls] forKey:key];
        else if ([object isKindOfClass:[NSArray class]]) [replaced setObject:[object arrayByRemovingNulls] forKey:key];
        else if (([object isKindOfClass:[NSString class]]) && ([(NSString*)object isEqualToString:@""])) [replaced removeObjectForKey:key];
    }
    return [NSDictionary dictionaryWithDictionary:[replaced copy]];
}

@end

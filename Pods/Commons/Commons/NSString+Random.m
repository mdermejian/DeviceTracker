//
//  NSString+Random.m
//  Commons
//
//  Created by Marc Dermejian on 30/09/2015.
//  Copyright (c) 2015 Fexco Software Group. All rights reserved.
//

#import "NSString+Random.h"

@implementation NSString (Random)

+ (NSString *)randomCharacterFromString:(in NSString *)string
{
    return [string substringWithRange:NSMakeRange(arc4random_uniform((uint32_t)[string length]), 1)];
}

+ (NSString *)randomCharacter
{
    return [NSString stringWithFormat:@"%c", arc4random_uniform(26) + 'a'];
}

@end
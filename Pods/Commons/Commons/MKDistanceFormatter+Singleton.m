//
//  MKDistanceFormatter+Singleton.m
//  Commons
//
//  Created by Marc Dermejian on 21/01/2016.
//  Copyright (c) 2016 Fexco Software Group. All rights reserved.
//

#import "MKDistanceFormatter+Singleton.h"

@implementation MKDistanceFormatter (Singleton)

+ (instancetype)sharedDistanceFormatter
{
    static MKDistanceFormatter *_distanceFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _distanceFormatter = [[MKDistanceFormatter alloc] init];
        [_distanceFormatter setLocale:[NSLocale currentLocale]];
        [_distanceFormatter setUnits:MKDistanceFormatterUnitsDefault];
        [_distanceFormatter setUnitStyle:MKDistanceFormatterUnitStyleAbbreviated];
    });
    
    return _distanceFormatter;
}


@end

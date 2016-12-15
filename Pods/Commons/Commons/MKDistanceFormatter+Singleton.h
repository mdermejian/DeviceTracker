//
//  MKDistanceFormatter+Singleton.h
//  Commons
//
//  Created by Marc Dermejian on 21/01/2016.
//  Copyright (c) 2016 Fexco Software Group. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKDistanceFormatter (Singleton)

+ (instancetype)sharedDistanceFormatter;

@end

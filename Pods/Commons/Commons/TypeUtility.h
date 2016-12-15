//
//  TypeUtility.h
//  Commons
//
//  Created by Marc Dermejian on 01/12/2015.
//  Copyright (c) 2015 Fexco Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TypeUtility : NSObject

+ (NSArray *)arrayValue:(id)object;
+ (BOOL)boolValue:(id)object;
+ (NSDictionary *)dictionaryValue:(id)object;
+ (NSInteger)integerValue:(id)object;
+ (id)objectValue:(id)object;
+ (NSString *)stringValue:(id)object;
+ (NSUInteger)unsignedIntegerValue:(id)object;
+ (NSURL *)URLValue:(id)object;

@end

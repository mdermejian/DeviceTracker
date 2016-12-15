//
//  NSDictionary+NullReplacement.h
//  Commons
//
//  Created by Marc Dermejian on 04/02/2015.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NullReplacement)

/*!
 @abstract
 Recursively replaces or removes null or nil values from an NSDictionary
 
 This is particularly useful when parsing backend responses
 */
- (NSDictionary *)dictionaryByRemovingNulls;

@end

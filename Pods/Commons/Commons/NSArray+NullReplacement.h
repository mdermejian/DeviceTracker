//
//  NSArray+NullReplacement.h
//  Commons
//
//  Created by Marc Dermejian on 04/02/2015.
//

#import <Foundation/Foundation.h>

@interface NSArray (NullReplacement)

/*!
 @abstract
 Recursively replaces or removes null or nil values from an NSArray
 
 This is particularly useful when parsing backend responses
 */
- (NSArray *)arrayByRemovingNulls;

@end

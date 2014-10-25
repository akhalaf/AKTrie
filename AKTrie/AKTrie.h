//
//  AKTrie.h
//  AKTrie
//
//  Created by Ahmed Khalaf on 10/24/14.
//  Copyright (c) 2014 A.Khalaf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKTrie : NSObject

/**
 *  Number of all strings in this `AKTrie` object.
 */
@property (nonatomic, readonly) int numberOfStrings;
/**
 *  This variable will be YES if this `AKTrie` object represent a leaf, or an end node.
 */
@property (nonatomic, readonly) BOOL isCompleteString;
/**
 *  Array of all strings in this `AKTrie` object.
 */
@property (nonatomic, readonly) NSArray* strings;

/**
 *  Adds the given string to this `AKTrie` object, and creates all the sub `AKTrie` objects according to the given string.
 *
 *  @param string The given string to be added to the `AKTrie` object.
 */
-(void)addString:(NSString*)string;
/**
 *  Adds the given argument list strings to this `AKTrie` object, and creates all the sub `AKTrie` objects according to the given the argument list strings.
 *
 *  @param firstString A comma-separated list of strings ending with nil.
 */
-(void)addStrings:(NSString*)firstString, ...NS_REQUIRES_NIL_TERMINATION;
/**
 *  Adds all strings in the given `stringsArray` to this `AKTrie` object, and creates all the sub `AKTrie` objects.
 *
 *  @param stringsArray An array of strings.
 */
-(void)addStringsArray:(NSArray*)stringsArray;
/**
 *  Returns a Boolean value that indicates whether a given `string` is present in this `AKTrie` object.
 *
 *  @param string The given string.
 *
 *  @return `YES` if `string` is present in the `AKTrie` object, otherwise NO.
 */
-(BOOL)containsString:(NSString*)string;

-(NSArray*)stringsStartWithPrefixString:(NSString*)prefixString;
-(NSArray*)stringsStartWithPrefixString:(NSString*)prefixString
                                  limit:(int)limit;
-(int)numberOfStringsStartWithPrefixString:(NSString*)prefixString;

/**
 *  Creates and returns an empty `AKTrie` object.
 *
 *  @return An empty `AKTrie` object.
 */
+(instancetype)trie;
/**
 *  Creates and returns an `AKTrie` object containing the strings in the argument list.
 *
 *  @param firstString A comma-separated list of strings ending with nil.
 *
 *  @return An `AKTrie` object containing the strings in the argument list.
 */
+(instancetype)trieWithStrings:(NSString*)firstString, ...NS_REQUIRES_NIL_TERMINATION;
/**
 *  Creates and returns an `AKTrie` object containing the strings in the given array.
 *
 *  @param stringsArray An array of strings to be added in the `AKTrie` object.
 *
 *  @return An `AKTrie` object containing the strings in `stringsArray`.
 */
+(instancetype)trieWithStringsArray:(NSArray*)stringsArray;

@end

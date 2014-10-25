//
//  AKTrie.m
//  AKTrie
//
//  Created by Ahmed Khalaf on 10/24/14.
//  Copyright (c) 2014 A.Khalaf. All rights reserved.
//

#import "AKTrie.h"

@implementation AKTrie
{
    NSMutableDictionary* subTries;
}

@synthesize numberOfStrings;
@synthesize isCompleteString;

-(instancetype)init
{
    self = [super init];
    if (self) {
        subTries = [NSMutableDictionary dictionary];
        numberOfStrings = 0;
        isCompleteString = NO;
    }
    return self;
}

-(void)addString:(NSString *)string
{
    if (string.length == 0) {
        isCompleteString = YES;
        numberOfStrings++;
        return;
    }
    
    NSString* firstLetter = [[string substringToIndex:1]lowercaseString];
    NSString* restOfString = [string substringFromIndex:1];
    
    AKTrie* trie = [subTries objectForKey:firstLetter];
    if (!trie) {
        trie = [AKTrie trie];
        [subTries setObject:trie
                     forKey:firstLetter];
    }
    
    if ([trie containsString:restOfString]) {
        return;
    }
    
    [trie addString:restOfString];
    numberOfStrings++;
}

-(void)addStrings:(NSString *)firstString, ...
{
    va_list args;
    va_start(args, firstString);
    for (NSString *string = firstString; string != nil; string = va_arg(args, NSString*))
    {
        [self addString:string];
    }
    va_end(args);
}

-(void)addStringsArray:(NSArray *)stringsArray
{
    for (NSString* string in stringsArray) {
        [self addString:string];
    }
}

-(BOOL)containsString:(NSString *)string
{
    if (string.length == 0) {
        if (isCompleteString) {
            return YES;
        }
        return NO;
    }
    
    NSString* firstLetter = [[string substringToIndex:1]lowercaseString];
    NSString* restOfString = [string substringFromIndex:1];
    
    AKTrie* trie = [subTries objectForKey:firstLetter];
    if (!trie) {
        return NO;
    }
    
    return [trie containsString:restOfString];
}

-(NSArray *)stringsStartWithPrefixString:(NSString*)prefixString
                                   limit:(int)limit
                        appendedToString:(NSString*)startString
{
    if (prefixString.length == 0) {
        NSMutableArray* result = [NSMutableArray array];
        if (isCompleteString) {
            [result addObject:startString];
        }
        
        for (NSString* letter in [subTries allKeys]) {
            if (result.count >= limit) {
                break;
            }
            AKTrie* trie = [subTries objectForKey:letter];
            [result addObjectsFromArray:[trie stringsStartWithPrefixString:@""
                                                                     limit:limit - (int)result.count
                                                          appendedToString:[startString stringByAppendingString:letter]]];
        }
        
        if (result.count > limit) {
            return [result subarrayWithRange:NSMakeRange(0, limit)];
        }
        return result;
    }
    
    NSString* firstLetter = [[prefixString substringToIndex:1]lowercaseString];
    NSString* restOfString = [prefixString substringFromIndex:1];
    
    AKTrie* trie = [subTries objectForKey:firstLetter];
    if (!trie) {
        return nil;
    }
    
    return [trie stringsStartWithPrefixString:restOfString
                                        limit:limit
                             appendedToString:[startString stringByAppendingString:firstLetter]];
}

-(NSArray *)stringsStartWithPrefixString:(NSString *)prefixString
{
    return [self stringsStartWithPrefixString:prefixString
                                        limit:numberOfStrings
                             appendedToString:@""];
}

-(NSArray *)stringsStartWithPrefixString:(NSString *)prefixString
                                   limit:(int)limit
{
    return [self stringsStartWithPrefixString:prefixString
                                        limit:limit
                             appendedToString:@""];
}

-(NSArray *)strings
{
    return [self stringsStartWithPrefixString:@""
                                        limit:numberOfStrings
                             appendedToString:@""];
}

-(int)numberOfStringsStartWithPrefixString:(NSString *)prefixString
{
    if (prefixString.length == 0) {
        return numberOfStrings;
    }
    
    NSString* firstLetter = [[prefixString substringToIndex:1]lowercaseString];
    NSString* restOfString = [prefixString substringFromIndex:1];
    
    AKTrie* trie = [subTries objectForKey:firstLetter];
    if (!trie) {
        return 0;
    }
    
    return [trie numberOfStringsStartWithPrefixString:restOfString];
}

+(instancetype)trie
{
    return [[AKTrie alloc]init];
}

+(instancetype)trieWithStrings:(NSString *)firstString, ...
{
    AKTrie* trie = [[AKTrie alloc]init];

    va_list args;
    va_start(args, firstString);
    for (NSString *string = firstString; string != nil; string = va_arg(args, NSString*))
    {
        [trie addString:string];
    }
    va_end(args);
    
    return trie;
}

+(instancetype)trieWithStringsArray:(NSArray *)stringsArray
{
    AKTrie* trie = [[AKTrie alloc]init];
    
    [trie addStringsArray:stringsArray];
    
    return trie;
}

@end

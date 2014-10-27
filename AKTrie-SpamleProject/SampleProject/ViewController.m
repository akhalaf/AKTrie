//
//  ViewController.m
//  SampleProject
//
//  Created by Ahmed Khalaf on 10/27/14.
//
//

#import "ViewController.h"
#import "AKTrie.h"

@interface ViewController ()

@end

@implementation ViewController
{
    AKTrie* trie;
    NSMutableArray* array;
    NSMutableDictionary* dictionary;
    NSTimeInterval timeBeforeProcess, timeAfterProcess;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self createTheContainersFromTextFile];
    [self addString];
}

-(void)createTheContainersFromTextFile
{
    // Load all the file content from the text file into array
    timeBeforeProcess = [[NSDate date] timeIntervalSince1970];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"english_words"
                                                     ofType:@"txt"];
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    
    NSCharacterSet* nonAlphabitSet = [[NSCharacterSet letterCharacterSet]invertedSet];
    NSArray* wordsArray = [content componentsSeparatedByCharactersInSet:nonAlphabitSet];
    timeAfterProcess = [[NSDate date] timeIntervalSince1970];
    NSLog(@"time of loading the text file into an array is: %f", timeAfterProcess - timeBeforeProcess);
    
    // creating AKTrie with about 20K english string
    timeBeforeProcess = [[NSDate date] timeIntervalSince1970];
    trie = [AKTrie trieWithStringsArray:wordsArray];
    timeAfterProcess = [[NSDate date] timeIntervalSince1970];
    NSLog(@"time of creating a trie with the strings array is: %f", timeAfterProcess - timeBeforeProcess);
    
    // creating dictionary from the words array
    timeBeforeProcess = [[NSDate date] timeIntervalSince1970];
    dictionary = [NSMutableDictionary dictionaryWithObjects:wordsArray
                                                    forKeys:wordsArray];
    timeAfterProcess = [[NSDate date] timeIntervalSince1970];
    NSLog(@"time of creating a dictionary with the strings array is: %f", timeAfterProcess - timeBeforeProcess);
    
    // creating array from the words array
    timeBeforeProcess = [[NSDate date] timeIntervalSince1970];
    array = [NSMutableArray arrayWithArray:wordsArray];
    timeAfterProcess = [[NSDate date] timeIntervalSince1970];
    NSLog(@"time of creating an array with the strings array is: %f", timeAfterProcess - timeBeforeProcess);
}

-(void)addString
{
    NSString* stringToAdd = @"Khalaf";
    
    // adding new string to the trie
    timeBeforeProcess = [[NSDate date] timeIntervalSince1970];
    [trie addString:stringToAdd];
    timeAfterProcess = [[NSDate date] timeIntervalSince1970];
    NSLog(@"time of adding new string to the trie is: %f", timeAfterProcess - timeBeforeProcess);
    
    // adding new string to the trie
    timeBeforeProcess = [[NSDate date] timeIntervalSince1970];
    [array addObject:stringToAdd];
    timeAfterProcess = [[NSDate date] timeIntervalSince1970];
    NSLog(@"time of adding new string to the array is: %f", timeAfterProcess - timeBeforeProcess);
    
    // adding new string to the trie
    timeBeforeProcess = [[NSDate date] timeIntervalSince1970];
    [dictionary setObject:stringToAdd
                   forKey:stringToAdd];
    timeAfterProcess = [[NSDate date] timeIntervalSince1970];
    NSLog(@"time of adding new string to the dictionary is: %f", timeAfterProcess - timeBeforeProcess);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

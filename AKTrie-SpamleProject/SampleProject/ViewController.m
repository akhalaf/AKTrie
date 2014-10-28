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
    float trieTime, arrayTime, dictionaryTime;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@" _____________________________________________________________");
    NSLog(@"|          |     NSArray    |   NSDictionary |     AKTrie     |");
    NSLog(@"|__________|________________|________________|________________|");
    [self createTheContainersFromTextFile];
    [self addString];
    [self checkIfStringExistWithSuccess];
    [self checkIfStringExistWithFailure];
    NSLog(@"|__________|________________|________________|________________|");
}

-(void)createTheContainersFromTextFile
{
    // Load all the file content from the text file into array
    NSString* path = [[NSBundle mainBundle] pathForResource:@"english_words"
                                                     ofType:@"txt"];
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    
    NSCharacterSet* nonAlphabitSet = [[NSCharacterSet letterCharacterSet]invertedSet];
    NSArray* wordsArray = [content componentsSeparatedByCharactersInSet:nonAlphabitSet];
    
    
    
    // creating AKTrie with about 20K english string
    timeBeforeProcess = [[NSDate date] timeIntervalSince1970];
    trie = [AKTrie trieWithStringsArray:wordsArray];
    timeAfterProcess = [[NSDate date] timeIntervalSince1970];
    trieTime = timeAfterProcess - timeBeforeProcess;
    
    // creating dictionary from the words array
    timeBeforeProcess = [[NSDate date] timeIntervalSince1970];
    dictionary = [NSMutableDictionary dictionaryWithObjects:wordsArray
                                                    forKeys:wordsArray];
    timeAfterProcess = [[NSDate date] timeIntervalSince1970];
    dictionaryTime = timeAfterProcess - timeBeforeProcess;
    
    // creating array from the words array
    timeBeforeProcess = [[NSDate date] timeIntervalSince1970];
    array = [NSMutableArray arrayWithArray:wordsArray];
    timeAfterProcess = [[NSDate date] timeIntervalSince1970];
    arrayTime = timeAfterProcess - timeBeforeProcess;

    NSLog(@"|  create  |  %.6f sec  |  %.6f sec  |  %.6f sec  |", arrayTime, dictionaryTime, trieTime);
}

-(void)addString
{
    NSString* stringToAdd = @"Khalaf";
    
    // adding new string to the trie
    timeBeforeProcess = [[NSDate date] timeIntervalSince1970];
    [trie addString:stringToAdd];
    timeAfterProcess = [[NSDate date] timeIntervalSince1970];
    trieTime = timeAfterProcess - timeBeforeProcess;
    
    // adding new string to the array
    timeBeforeProcess = [[NSDate date] timeIntervalSince1970];
    [array addObject:stringToAdd];
    timeAfterProcess = [[NSDate date] timeIntervalSince1970];
    arrayTime = timeAfterProcess - timeBeforeProcess;
    
    // adding new string to the dictionary
    timeBeforeProcess = [[NSDate date] timeIntervalSince1970];
    [dictionary setObject:stringToAdd
                   forKey:stringToAdd];
    timeAfterProcess = [[NSDate date] timeIntervalSince1970];
    float dictionaryTime = timeAfterProcess - timeBeforeProcess;
    
    NSLog(@"|   add    |  %.6f sec  |  %.6f sec  |  %.6f sec  |", arrayTime, dictionaryTime, trieTime);
}

-(void)checkIfStringExistWithSuccess
{
    NSString* stringToCheck = @"Khalaf";
    
    // checking if string exist in the trie
    timeBeforeProcess = [[NSDate date] timeIntervalSince1970];
    if ([trie containsString:stringToCheck]) {
        timeAfterProcess = [[NSDate date] timeIntervalSince1970];
        trieTime = timeAfterProcess - timeBeforeProcess;
    }
    
    // checking if string exist in the array
    timeBeforeProcess = [[NSDate date] timeIntervalSince1970];
    if ([array containsObject:stringToCheck]) {
        timeAfterProcess = [[NSDate date] timeIntervalSince1970];
        arrayTime = timeAfterProcess - timeBeforeProcess;
    }
    
    // checking if string exist in the dictionary
    timeBeforeProcess = [[NSDate date] timeIntervalSince1970];
    if ([dictionary objectForKey:stringToCheck]) {
        timeAfterProcess = [[NSDate date] timeIntervalSince1970];
        dictionaryTime = timeAfterProcess - timeBeforeProcess;
    }
    
    NSLog(@"|  check ✓ |  %.6f sec  |  %.6f sec  |  %.6f sec  |", arrayTime, dictionaryTime, trieTime);
}

-(void)checkIfStringExistWithFailure
{
    NSString* stringToCheck = @"StringNotExist";
    
    // checking if string exist in the trie
    timeBeforeProcess = [[NSDate date] timeIntervalSince1970];
    if (![trie containsString:stringToCheck]) {
        timeAfterProcess = [[NSDate date] timeIntervalSince1970];
        trieTime = timeAfterProcess - timeBeforeProcess;
    }
    
    // checking if string exist in the array
    timeBeforeProcess = [[NSDate date] timeIntervalSince1970];
    if (![array containsObject:stringToCheck]) {
        timeAfterProcess = [[NSDate date] timeIntervalSince1970];
        arrayTime = timeAfterProcess - timeBeforeProcess;
    }
    
    // checking if string exist in the dictionary
    timeBeforeProcess = [[NSDate date] timeIntervalSince1970];
    if (![dictionary objectForKey:stringToCheck]) {
        timeAfterProcess = [[NSDate date] timeIntervalSince1970];
        dictionaryTime = timeAfterProcess - timeBeforeProcess;
    }
    
    NSLog(@"|  check ✗ |  %.6f sec  |  %.6f sec  |  %.6f sec  |", arrayTime, dictionaryTime, trieTime);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

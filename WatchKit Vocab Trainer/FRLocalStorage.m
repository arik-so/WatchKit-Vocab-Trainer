//
//  FRLocalStorage.m
//  Server
//
//  Created by Frederik Riedel on 05.12.14.
//  Copyright (c) 2014 Frederik Riedel. All rights reserved.
//

#import "FRLocalStorage.h"

@implementation FRLocalStorage
static NSMutableDictionary *dictionary;
static NSString *filePath;
static NSString *splitter = @"[==^==^==]";
static bool initialized = false;

#pragma mark public methods
+(void) initializeStorage {
    initialized=true;
    dictionary = [[NSMutableDictionary alloc] init];
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    filePath = [documentsPath stringByAppendingPathComponent:@"localStorage.txt"];

    NSLog(@"Check this file in Finder: %@",filePath);
    [FRLocalStorage loadDictionaryFromDisc];
}


+(NSString *) objectForKey:(NSString *) key {
    if(!initialized) {
        [FRLocalStorage initializeStorage];
    }
    NSLog(@"stored locally: %@" ,[dictionary objectForKey:key]);
    return [dictionary objectForKey:key];
}


+(void) storeObject:(NSString *) object forKey:(NSString *) key {
    if(!initialized) {
        [FRLocalStorage initializeStorage];
    }
    [dictionary setObject:object forKey:key];
    [FRLocalStorage saveDictionaryToDisc];
}

+(BOOL) keyExists:(NSString *)key {
    if(!initialized) {
        [FRLocalStorage initializeStorage];
    }
    return [FRLocalStorage objectForKey:key];
}

#pragma mark
#pragma mark private methods
+(void) saveDictionaryToDisc {
    NSString *saveDataString = @"";
    for(NSString *key in dictionary) {
        
        NSString *object = [dictionary objectForKey:key];
        NSString *base64Object = [self stringToBase64String:object];
        
        NSString *base64Key = [self stringToBase64String:key];
        
        
        saveDataString = [NSString stringWithFormat:@"%@%@%@%@\n",saveDataString,base64Key,splitter,base64Object];
    
    }
    [saveDataString writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

+(void) loadDictionaryFromDisc {
    [dictionary removeAllObjects];
    NSString *loadDataString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];

    for(NSString *keyValuePair in [loadDataString componentsSeparatedByString:@"\n"]) {
        
        if([[keyValuePair componentsSeparatedByString:splitter] count]>1) {
            NSString *base64Key = [[keyValuePair componentsSeparatedByString:splitter] objectAtIndex:0];
            
            NSString *key = [self base64StringToString:base64Key];
            
            NSString *base64Object = [[keyValuePair componentsSeparatedByString:splitter] objectAtIndex:1];

            NSString *object = [self base64StringToString:base64Object];
            
            [dictionary setObject:object forKey:key];
        }
    }
}

+(NSString *) stringToBase64String:(NSString *) string {
    NSData *nsdata = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [nsdata base64EncodedStringWithOptions:0];
    return base64String;
}

+(NSString *) base64StringToString:(NSString *) base64String {
    NSData *nsdataFromBase64String = [[NSData alloc] initWithBase64EncodedString:base64String options:0];
    NSString *string = [[NSString alloc] initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
    return string;
}




@end

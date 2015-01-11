//
//  FRLocalStorage.h
//  Server
//
//  Created by Frederik Riedel on 05.12.14.
//  Copyright (c) 2014 Frederik Riedel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FRLocalStorage : NSObject

+(void) initializeStorage;
+(NSString *) objectForKey:(NSString *) key;
+(BOOL) keyExists:(NSString *) key;
+(void) storeObject:(NSString *) object forKey:(NSString *) key;



@end

//
//  Server.h
//  Server
//
//  Created by Frederik Riedel on 03.12.14.
//  Copyright (c) 2015 Frederik Riedel. All rights reserved.
// https://github.com/quappi/FRServer

#import <Foundation/Foundation.h>
#import "FRServerRequest.h"
@import UIKit;
@interface FRServer : NSObject


+(void) dataFromURL:(NSString *) url HTTPMethod:(NSString *) HTTPMethod attributes:(NSDictionary *) attributes HTTPHeaderFieldDictionary:(NSDictionary *) HTTPHeaderFields andCallbackBlock: (void (^) (NSData *data)) block;

+(void) imageFromURL:(NSString *) url HTTPMethod:(NSString *) HTTPMethod attributes:(NSDictionary *) attributes HTTPHeaderFieldDictionary:(NSDictionary *) HTTPHeaderFields andCallbackBlock: (void (^) (UIImage *image)) block;

+(void) jsonFromURL:(NSString *) url HTTPMethod:(NSString *) HTTPMethod attributes:(NSDictionary *) attributes HTTPHeaderFieldDictionary:(NSDictionary *) HTTPHeaderFields andCallbackBlock: (void (^) (NSDictionary *JSON)) block;

+(void) stringFromURL:(NSString *)url HTTPMethod:(NSString *)HTTPMethod attributes:(NSDictionary *)attributes HTTPHeaderFieldDictionary:(NSDictionary *)HTTPHeaderFields andCallbackBlock:(void (^)(NSString *))block;


+(void) dataFromServerRequest:(FRServerRequest *) serverRequest;
+(void) imageFromServerRequest:(FRServerRequest *) serverRequest;
+(void) jsonFromServerRequest:(FRServerRequest *) serverRequest;
+(void) stringFromServerRequest:(FRServerRequest *) serverRequest;


@end
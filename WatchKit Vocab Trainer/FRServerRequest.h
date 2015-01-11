//
//  FRServerRequest.h
//  Server
//
//  Created by Frederik Riedel on 04.12.14.
//  Copyright (c) 2014 Frederik Riedel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FRServerRequest : NSObject

@property(readwrite,strong) NSString *url;
@property(readwrite,strong) NSString *HTTPMethod;
@property(readwrite,strong) NSDictionary *attributes;
@property(readwrite,strong) NSDictionary *HTTPHeaderFields;
@property(readwrite,strong) void (^block) (NSObject *data);



@end
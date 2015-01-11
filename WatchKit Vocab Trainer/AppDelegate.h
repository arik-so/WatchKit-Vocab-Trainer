//
//  AppDelegate.h
//  WatchKit Vocab Trainer
//
//  Created by Arik Sosman on 1/10/15.
//  Copyright (c) 2015 WKH. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "FRServer.h"
#import "FRLocalStorage.h"

#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
+(void) setPackageID:(int) packageID;
+(int) getPackageID;


@end


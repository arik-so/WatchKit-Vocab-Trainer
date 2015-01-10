//
//  AppDelegate.m
//  WatchKit Vocab Trainer
//
//  Created by Arik Sosman on 1/10/15.
//  Copyright (c) 2015 WKH. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
        NSLog([UIDevice currentDevice].identifierForVendor.UUIDString);
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void (^)(NSDictionary *replyInfo))reply {
    
    NSLog(@"watchkit extension called");
    
    void (^finishedDownloading)(NSDictionary *dic) = ^void(NSDictionary *dic) {
        
        NSString *question = dic[@"question"][@"text"];
        
        
        int r = arc4random() % 3;
        
        NSString *answer1;
        NSString *identifier1;
        NSString *answer2;
        NSString *identifier2;
        NSString *answer3;
        NSString *identifier3;
        
        
        
        NSMutableArray *answerOptions = @[].mutableCopy;

        
        [answerOptions addObject:@{@"answer": dic[@"correct_answers"][0][@"value"], @"identifier": @"true"}];
        
        
        for(int i = 0; i < MIN(2, [dic[@"wrong_answers"] count]); i++){
            
            NSDictionary *currentAddition = @{@"answer": dic[@"wrong_answers"][i][@"value"], @"identifier": @"false"};
            
            if(arc4random() % 2 == 1){
                
                [answerOptions insertObject:currentAddition atIndex:0];
                
            }else{
                
                [answerOptions addObject:currentAddition];
                
            }
            
        }
        
        answer1 = answerOptions[0][@"answer"];
        identifier1 = answerOptions[0][@"identifier"];
        
        answer2 = answerOptions[1][@"answer"];
        identifier2 = answerOptions[1][@"identifier"];
        
        answer3 = answerOptions[2][@"answer"];
        identifier3 = answerOptions[2][@"identifier"];
        
        
        
        
        
        
        
        
        
        /*
        
        if(r == 0) {
            answer1 = dic[@"correct_answers"][0][@"value"];
            identifier1 = @"true";
        } else if(r == 1) {
            answer2 = dic[@"correct_answers"][0][@"value"];
            identifier2 = @"true";
        } else if(r == 2) {
            answer3 = dic[@"correct_answers"][0][@"value"];
            identifier3 = @"true";
        }
        
        int wrongAnswerIndex = 0;
        
        NSArray *wrongAnswers = dic[@"wrong_answers"];
        
        if(r != 0) {
            answer1 = wrongAnswers[wrongAnswerIndex][@"value"];
            identifier1 = @"false";
            wrongAnswerIndex++;
        } else if(r != 1) {
            answer2 = wrongAnswers[wrongAnswerIndex][@"value"];
            identifier2 = @"false";
            wrongAnswerIndex++;
        } else if(r != 2) {
            answer3 = wrongAnswers[wrongAnswerIndex][@"value"];
            identifier3 = @"false";
            wrongAnswerIndex++;
        }*/
        
        
        
        NSString *questionString = [NSString stringWithFormat:@"{    \"aps\": {        \"alert\": \"%@\",        \"title\": \"Optional title\",        \"category\": \"myCategory\"    },        \"WatchKit Simulator Actions\": [                                   {                                        \"title\": \"%@\",                                        \"identifier\": \"%@\"                                   } , {                                        \"title\": \"%@\",                                        \"identifier\": \"%@\"                                   } , {                                        \"title\": \"%@\",                                        \"identifier\": \"%@\"                                   }                                   ]}",question,answer1,identifier1,answer2,identifier2,answer3,identifier3];
        
        
        
        reply([NSJSONSerialization JSONObjectWithData:[questionString  dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil]);
        
    };
    
    
    [FRServer jsonFromURL:@"http://xampp.localhost/watchkit-vocab-trainer/web/category/3/random-question" HTTPMethod:@"GET" attributes:nil HTTPHeaderFieldDictionary:nil andCallbackBlock:finishedDownloading];
    
    
}





+(NSDictionary *) factoryJSONQuestion {
    
    NSString *question = @"Banane";
    NSString *answer1 = @"Cola";
    NSString *identifier1 = @"false";
    
    NSString *answer2 = @"Apfel";
    NSString *identifier2 = @"false";
    
    NSString *answer3 = @"Banana";
    NSString *identifier3 = @"true";
    
    
    NSString *questionString = [NSString stringWithFormat:@"{    \"aps\": {        \"alert\": \"%@\",        \"title\": \"Optional title\",        \"category\": \"myCategory\"    },        \"WatchKit Simulator Actions\": [                                   {                                        \"title\": \"%@\",                                        \"identifier\": \"%@\"                                   } , {                                        \"title\": \"%@\",                                        \"identifier\": \"%@\"                                   } , {                                        \"title\": \"%@\",                                        \"identifier\": \"%@\"                                   }                                   ]}",question,answer1,identifier1,answer2,identifier2,answer3,identifier3];
    
    
    return [NSJSONSerialization JSONObjectWithData:[questionString  dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
}

@end

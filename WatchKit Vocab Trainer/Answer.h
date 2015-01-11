//
//  Answer.h
//  WatchKit Vocab Trainer
//
//  Created by Frederik Riedel on 11.01.15.
//  Copyright (c) 2015 WKH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Answer : NSObject

@property(nonatomic) int answered;
@property(nonatomic) int correctlyAnswered;
@property(strong,nonatomic) NSString *text;


-(id) initWithJSON:(NSDictionary *) dic;
@end

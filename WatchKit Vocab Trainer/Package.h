//
//  Package.h
//  WatchKit Vocab Trainer
//
//  Created by Frederik Riedel on 11.01.15.
//  Copyright (c) 2015 WKH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Answer.h"

@interface Package : NSObject
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *imageURL;
@property(strong,nonatomic) NSString *uuid;
@property(nonatomic) double percentageDone;
@property(atomic) int correctAnswers;
@property(atomic) int askedQuestions;
@property(nonatomic) NSMutableArray *answers;


-(float) percentageOfCorrectAnswers;
-(id) initWithJSON:(NSDictionary *) dic;
-(void) addAnswer:(Answer *) answer;

@end

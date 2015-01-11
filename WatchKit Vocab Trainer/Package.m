//
//  Package.m
//  WatchKit Vocab Trainer
//
//  Created by Frederik Riedel on 11.01.15.
//  Copyright (c) 2015 WKH. All rights reserved.
//

#import "Package.h"

@implementation Package

-(id) initWithJSON:(NSDictionary *) dic {
    self = [super init];
    
    if(self) {
        self.answers = [[NSMutableArray alloc] init];
        self.name = dic[@"name"];
        self.imageURL = dic[@"image_url"];
        self.uuid = dic[@"id"];
    }
    
    
    return self;
    
}

-(void) addAnswer:(Answer *) answer {
    self.askedQuestions+=answer.answered;
    self.correctAnswers+=answer.correctlyAnswered;
    
    [self.answers addObject:answer];
}


-(float) percentageOfCorrectAnswers {
    
    
    if(self.askedQuestions == 0) {
        return 0.0;
    }
    
    return ((double)self.correctAnswers) / ((double)self.askedQuestions);
}

@end

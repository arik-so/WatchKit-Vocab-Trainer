//
//  Answer.m
//  WatchKit Vocab Trainer
//
//  Created by Frederik Riedel on 11.01.15.
//  Copyright (c) 2015 WKH. All rights reserved.
//

#import "Answer.h"

@implementation Answer

-(id) initWithJSON:(NSDictionary *) dic {
    self = [super init];
    
    if(self) {
        self.answered = [dic[@"attempts"] intValue];
        
        self.correctlyAnswered = [dic[@"correct_answers"] intValue];
        
        self.text = dic[@"text"];
    }
    
    return self;
}

@end

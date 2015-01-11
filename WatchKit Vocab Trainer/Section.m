//
//  Section.m
//  WatchKit Vocab Trainer
//
//  Created by Frederik Riedel on 11.01.15.
//  Copyright (c) 2015 WKH. All rights reserved.
//

#import "Section.h"

@implementation Section

-(id) init {
    self = [super init];
    
    if(self) {
        self.packages=[[NSMutableArray alloc] init];
    }
    return self;
}

@end

//
//  MultipleSelectionQuestionInterfaceController.m
//  WatchKit Vocab Trainer
//
//  Created by Frederik Riedel on 10.01.15.
//  Copyright (c) 2015 WKH. All rights reserved.
//

#import "MultipleSelectionQuestionInterfaceController.h"


@interface MultipleSelectionQuestionInterfaceController()
@property (weak, nonatomic) IBOutlet WKInterfaceTable *answerTable;
@property(weak,nonatomic) WKInterfaceTable *table;
@end


@implementation MultipleSelectionQuestionInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    
    [self.answerTable setNumberOfRows:10 withRowType:@"MultipleSelectionQuestionInterfaceController"];
    
    for(int i=0; i<10; i++) {
        
    }
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}


-(void) loadTableData {
    
}

@end




//
//  QuestionInterfaceController.m
//  WatchKit Vocab Trainer
//
//  Created by Frederik Riedel on 10.01.15.
//  Copyright (c) 2015 WKH. All rights reserved.
//

#import "QuestionInterfaceController.h"


@interface QuestionInterfaceController()
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *questionLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *answer1Button;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *answer2Button;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *answer3Button;
@property (strong, nonatomic) NSArray *answers;
@property(strong,nonatomic) NSMutableDictionary *context;
@end


@implementation QuestionInterfaceController


- (void)awakeWithContext:(id)context {
    
    self.context = [context mutableCopy];
    
    [super awakeWithContext:self.context];
    
    
    [self.questionLabel setText:self.context[@"aps"][@"alert"]];
    
    self.answers = self.context[@"WatchKit Simulator Actions"];
    
    [self.answer1Button setTitle:self.answers[0][@"title"]];
    [self.answer2Button setTitle:self.answers[1][@"title"]];
    [self.answer3Button setTitle:self.answers[2][@"title"]];
    
    
    
    
    
    
    
    
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

-(IBAction)pressButton1:(id)sender {
    [self handleButtonWithIndex:0];
}

-(IBAction)pressButton2:(id)sender {
    [self handleButtonWithIndex:1];
}

-(IBAction)pressButton3:(id)sender {
    [self handleButtonWithIndex:2];
}

-(void) handleButtonWithIndex:(int) index {
    
    //    NSLog(@"Button with index: %u",index);
    
    [self.context setObject:self.answers[index][@"identifier"] forKey:@"identifier"];
    
    //[self popToRootController];
    
    
    [self pushControllerWithName:@"InterfaceController" context:self.context];
    
    
    
}

//-(id)contextForSegueWithIdentifier:(NSString *)segueIdentifier {

//}

@end




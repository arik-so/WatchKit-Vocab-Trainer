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
@property(nonatomic) int numberOfGuesses;
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

- (void)didPressButton:(int)buttonIndex{
    
    WKInterfaceButton *pressedButton = nil;
    if(buttonIndex == 0){
        pressedButton = self.answer1Button;
    }else if(buttonIndex == 1){
        pressedButton = self.answer2Button;
    }else if(buttonIndex == 2){
        pressedButton = self.answer3Button;
    }
    
    if([self.answers[buttonIndex][@"identifier"] isEqualToString:@"true"]) {
        self.numberOfGuesses++;
        // [sender setBackgroundColor:[UIColor greenColor] for];
        [pressedButton setColor:[UIColor colorWithHue:120/360.0 saturation:1 brightness:0.4 alpha:1.0]];
        [self handleButtonWithIndex:buttonIndex];
        
    }else {
        self.numberOfGuesses++;
        [pressedButton setColor:[UIColor colorWithHue:0/360.0 saturation:1 brightness:0.4 alpha:1.0]];
    }
}

-(IBAction)pressButton1:(WKInterfaceButton *)sender {
    [self didPressButton:0];
}

-(IBAction)pressButton2:(WKInterfaceButton *)sender {
        [self didPressButton:1];
}

-(IBAction)pressButton3:(WKInterfaceButton *)sender {
        [self didPressButton:2];
}

-(void) handleButtonWithIndex:(int) index {
    
    //    NSLog(@"Button with index: %u",index);
    
    //[self.context setObject:self.answers[index][@"identifier"] forKey:@"identifier"];
    
    //[self popToRootController];
    
    
    NSString *question_id = [NSString stringWithFormat:@"%@",self.context[@"questionid"]];
    NSString *numberofAnswers = [NSString stringWithFormat:@"%u",self.numberOfGuesses];
    
    [InterfaceController openParentApplication:@{@"key": @"sendAnswerToServer", @"numberOfAnswers": numberofAnswers,@"questionid":question_id} reply:^(NSDictionary *replyInfo, NSError *error) {
        
        NSLog(@"Server send answer: %@",replyInfo);
        
    }];
    
    
    [InterfaceController openParentApplication:@{@"key": @"getNewQuestionFromServer"} reply:^(NSDictionary *replyInfo, NSError *error) {
        
        NSLog(@"%@",replyInfo);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self pushControllerWithName:@"QuestionInterfaceController" context:replyInfo];
        });
        
        
        //[self.quitAppButton setHidden:false];
        //[self.nextQuestionButton setHidden:false];
    }];
    
    //[self pushControllerWithName:@"InterfaceController" context:self.context];
    
    
    
}

//-(id)contextForSegueWithIdentifier:(NSString *)segueIdentifier {

//}

@end




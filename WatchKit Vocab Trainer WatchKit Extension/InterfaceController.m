//
//  InterfaceController.m
//  WatchKit Vocab Trainer WatchKit Extension
//
//  Created by Arik Sosman on 1/10/15.
//  Copyright (c) 2015 WKH. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *answerLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *nextQuestionButton;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *quitAppButton;
@property (strong, nonatomic) NSDictionary *nextQuestion;

@end


@implementation InterfaceController




- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    //[self handleActionWithIdentifier:context[@"identifier"] forRemoteNotification:context];
    
    

    
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



-(void) handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)remoteNotification {
  
    
    NSLog(@"Push Notification");
    
    NSString *question = remoteNotification[@"aps"][@"alert"];
    
    
    NSArray *answers = remoteNotification[@"WatchKit Simulator Actions"];
    
    NSString *rightAnswer = @"No answer was correct.";
    for(NSDictionary *dic in answers) {
        if ([dic[@"identifier"] boolValue] == true) {
            rightAnswer=dic[@"title"];
            break;
        }
    }
    
    
    
    if([identifier isEqualToString:@"true"]) {
        [self.answerLabel setText:[NSString stringWithFormat:@"Right 😄\nRight answer: %@: %@",question,rightAnswer]];
        
        
        
        [InterfaceController openParentApplication:@{@"key": @"sendAnswerToServer", @"numberOfAnswers": [NSString stringWithFormat:@"%u",1],@"question_id":[NSString stringWithFormat:@"%u",[remoteNotification[@"customKey"] intValue]]} reply:^(NSDictionary *replyInfo, NSError *error) {
            NSLog(@"%@",replyInfo);
            
        }];
         
        
        
    } else {
        [self.answerLabel setText:[NSString stringWithFormat:@"Wrong 😖\nRight answer: %@: %@",question,rightAnswer]];
    }
    
    [InterfaceController openParentApplication:@{@"key": @"getNewQuestionFromServer"} reply:^(NSDictionary *replyInfo, NSError *error) {
        NSLog(@"AppDelegate Reply: %@",replyInfo);
        self.nextQuestion = replyInfo;
        [self.quitAppButton setHidden:false];
        [self.nextQuestionButton setHidden:false];
    }];
    
    


}

-(id)contextForSegueWithIdentifier:(NSString *)segueIdentifier {
    
    return self.nextQuestion;
}

@end




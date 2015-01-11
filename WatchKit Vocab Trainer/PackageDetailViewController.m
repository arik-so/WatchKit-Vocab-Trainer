//
//  PackageDetailViewController.m
//  WatchKit Vocab Trainer
//
//  Created by Frederik Riedel on 11.01.15.
//  Copyright (c) 2015 WKH. All rights reserved.
//

#import "PackageDetailViewController.h"

@interface PackageDetailViewController ()
@property (strong, nonatomic) IBOutlet UILabel *alreadyAnsweredLabel;

@end

@implementation PackageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setPackage:(Package *) package {
    
    
    self.currentpackage=package;
    NSLog(@"%lu",(unsigned long)package.answers.count);
    
    
    self.answers = package.answers;
    
    for(Answer *answer in self.answers) {
        NSLog(@"%@",answer.text);
    }
    
    
    
    
    
    
    if(self.answers.count == 0) {
        UILabel *noAnswersYet = [[UILabel alloc] initWithFrame:CGRectMake(20, 64, self.view.frame.size.width-40, self.view.frame.size.height-180-44)];
        noAnswersYet.textAlignment = NSTextAlignmentCenter;
        noAnswersYet.text = @"You haven't answered any questions from this package, yet!";
        noAnswersYet.numberOfLines=-1;
        noAnswersYet.textColor = [UIColor darkGrayColor];
        [self.view addSubview:noAnswersYet];
    } else {
        
        
        UILabel *correct = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 50)];
        [correct setText:@"Correctly answered in this category:"];
        correct.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:correct];
        
        //UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 130, self.view.frame.size.width, 50)];
        //progressView.progress = [package percentageOfCorrectQestions];
        //[self.view addSubview:progressView];
        
        UILabel *percentage = [[UILabel alloc] initWithFrame:CGRectMake(0, 130, self.self.view.frame.size.width, 50)];
        percentage.font=[UIFont fontWithName:@"Helveticaneue-light" size:30];
        percentage.textAlignment = NSTextAlignmentCenter;
        percentage.text=[NSString stringWithFormat:@"%.0f%% correct answers",100*[package percentageOfCorrectAnswers]];
        [self.view addSubview:percentage];
        
        
        UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 180, self.view.frame.size.width, self.view.frame.size.height-180-44-50) style:UITableViewStyleGrouped];
        
        table.dataSource=self;
        
        [self.view addSubview:table];
    }
    
    
    UIButton *activateThisPackage = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    activateThisPackage.frame=CGRectMake(0, self.view.frame.size.height - 44 - 50, self.view.frame.size.width, 44);
    
    if([AppDelegate getPackageID] == [self.currentpackage.uuid intValue]) {
        [activateThisPackage setBackgroundColor:[UIColor greenColor]];
        [activateThisPackage setTitle:@"Package activated" forState:UIControlStateNormal];
    } else {
        [activateThisPackage setTitle:@"Activate this Package" forState:UIControlStateNormal];
        [activateThisPackage setBackgroundColor:[UIColor lightGrayColor]];
    }
    [self.view addSubview:activateThisPackage];
    [activateThisPackage addTarget:self action:@selector(activate:) forControlEvents:UIControlEventTouchUpInside];
}

-(void) activate:(UIButton *) sender {
    [sender setBackgroundColor:[UIColor greenColor]];
    [sender setTitle:@"Package activated" forState:UIControlStateNormal];
    [AppDelegate setPackageID:[self.currentpackage.uuid intValue]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.answers.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    Answer *answer = self.answers[indexPath.row];
    cell.textLabel.text = answer.text;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%u out of %u correct",answer.correctlyAnswered,answer.answered];
    
    
    return cell;
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

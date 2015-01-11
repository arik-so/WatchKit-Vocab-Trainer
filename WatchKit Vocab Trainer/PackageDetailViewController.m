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

-(void) setPackage {
    
    UILabel *correct = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 50)];
    [correct setText:@"Correctly answered in this category:"];
    correct.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:correct];
    
    UIProgressView *progressVIew = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 130, self.view.frame.size.width, 50)];
    [self.view addSubview:progressVIew];
    
    
    
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

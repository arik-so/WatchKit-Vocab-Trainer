//
//  PackageDetailViewController.h
//  WatchKit Vocab Trainer
//
//  Created by Frederik Riedel on 11.01.15.
//  Copyright (c) 2015 WKH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Package.h"

@interface PackageDetailViewController : UIViewController<UITableViewDataSource>
-(void) setPackage:(Package *) package;
@property(nonatomic,strong) NSArray *answers;

@end

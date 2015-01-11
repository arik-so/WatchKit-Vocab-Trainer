//
//  Package.h
//  WatchKit Vocab Trainer
//
//  Created by Frederik Riedel on 11.01.15.
//  Copyright (c) 2015 WKH. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
@interface Package : NSObject
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) UIImage *image;
@property(nonatomic) double percentageDone;
@property(nonatomic) int correctAnswers;
@property(nonatomic) int askedQuestions;


@end

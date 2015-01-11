//
//  Section.h
//  WatchKit Vocab Trainer
//
//  Created by Frederik Riedel on 11.01.15.
//  Copyright (c) 2015 WKH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Section : NSObject

@property(nonatomic,strong) NSMutableArray *packages;
@property(nonatomic, strong) NSString *sectionID;

@end

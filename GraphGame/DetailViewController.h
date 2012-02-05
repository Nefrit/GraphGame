//
//  DetailViewController.h
//  GraphGame
//
//  Created by admin on 31.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreMotion/CoreMotion.h>

@interface DetailViewController : UIViewController <UIAlertViewDelegate>

@property(retain, nonatomic) NSMutableArray *vertexes;
@property(retain, nonatomic) NSMutableArray *edges;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil levelFileName:(NSString *)levelFileName;

@end
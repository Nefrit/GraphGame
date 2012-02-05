//
//  LevelsViewController.h
//  GraphGame
//
//  Created by admin on 31.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface LevelsViewController : UITableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil levelFileNames:(NSArray *)levelFileNames records:(NSDictionary *)records;

@end

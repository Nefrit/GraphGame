//
//  RecordsDetailViewController.h
//  GraphGame
//
//  Created by admin on 31.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordsDetailViewController : UITableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil levelFileName:(NSString *)levelFileName levelRecords:(NSDictionary *)levelRecords;

@end
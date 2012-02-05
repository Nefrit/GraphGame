//
//  RecordsViewController.m
//  GraphGame
//
//  Created by admin on 31.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RecordsViewController.h"
#import "RecordsDetailViewController.h"

@interface RecordsViewController()

@property(retain, nonatomic) RecordsDetailViewController *recordsDetailViewController;

@property(retain, nonatomic) NSArray *levelFileNames;
@property(retain, nonatomic) NSDictionary *records;

@end

@implementation RecordsViewController

@synthesize recordsDetailViewController = _recordsDetailViewController;
@synthesize levelFileNames = _levelFileNames, records = _records;

- (void)dealloc
{
    self.recordsDetailViewController = nil;
    
    self.levelFileNames = nil;
    self.records = nil;
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil levelFileNames:(NSArray *)levelFileNames records:(NSDictionary *)records
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.levelFileNames = levelFileNames;
        self.records = records;
        
        self.title = NSLocalizedString(@"Records", @"Records");
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.levelFileNames.count;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSString *fullFileName = [self.levelFileNames objectAtIndex:indexPath.row];
    NSString *levelName = [fullFileName substringToIndex:fullFileName.length-4];
    cell.textLabel.text = NSLocalizedString(levelName, levelName);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *levelFileName = [self.levelFileNames objectAtIndex:indexPath.row];
    self.recordsDetailViewController = [[[RecordsDetailViewController alloc] initWithNibName:@"recordsDetailViewController" bundle:nil levelFileName:levelFileName levelRecords:[self.records objectForKey:levelFileName]] autorelease];
    
    [self.navigationController pushViewController:self.recordsDetailViewController animated:YES];
}

@end

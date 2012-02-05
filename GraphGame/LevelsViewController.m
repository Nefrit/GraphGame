//
//  LevelsViewController.m
//  GraphGame
//
//  Created by admin on 31.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LevelsViewController.h"
#import "DetailViewController.h"

@interface LevelsViewController()

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (retain, nonatomic) NSArray *levelFileNames;
@property(retain, nonatomic) NSDictionary *records;

@property (retain, nonatomic) NSCache *levelsCache;

@end

@implementation LevelsViewController

@synthesize detailViewController = _detailViewController;
@synthesize levelFileNames = _levelFileNames, records = _records;
@synthesize levelsCache = _levelsCache;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil levelFileNames:(NSArray *)levelFileNames records:(NSDictionary *)records
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Levels", @"Levels");
        
        self.levelsCache = [[[NSCache alloc] init] autorelease];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *levelsFolderPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingString:@"/Levels"];
        self.levelFileNames = [fileManager contentsOfDirectoryAtPath:levelsFolderPath error:nil];
        
        self.levelFileNames = levelFileNames;
        self.records = records;
    }
    return self;
}

- (void)dealloc
{
    self.detailViewController = nil;
    self.levelFileNames = nil;
    self.records = nil;
    self.levelsCache = nil;
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.levelFileNames.count;
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
    self.detailViewController = [self.levelsCache objectForKey:levelFileName];
    if (!self.detailViewController)
    {
        self.detailViewController = [[[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil levelFileName:levelFileName] autorelease];
        [self.levelsCache setObject:self.detailViewController forKey:levelFileName];
    }
    
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}

@end

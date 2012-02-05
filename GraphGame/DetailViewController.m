//
//  DetailViewController.m
//  GraphGame
//
//  Created by admin on 31.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MasterViewController.h" // для FREE_FALL_ACCELERATION ??
#import "DetailViewController.h"
#import "Vertex.h"
#import "Edge.h"
#import "Math.h"

@interface DetailViewController ()

@property (retain, nonatomic) NSString *levelFileName;

@property(retain, nonatomic) NSTimer *timer;
@property(nonatomic) CGFloat playTime;
@property (retain, nonatomic) IBOutlet UITextField *timerTextField;

- (void) loadLevel;

- (Vertex *) vertexWithNumber:(NSInteger)number XCoordinate:(NSInteger)XCoordinate YCoordinate:(NSInteger)YCoordinate;
- (Edge *) edgeWithNumber:(NSInteger)number XCoordinate:(NSInteger)XCoordinate YCoordinate:(NSInteger)YCoordinate;

- (void) updateTimerTextField;

- (void)addToRecordsNotificationForPlayTime:(CGFloat)playTime;

@end

@implementation DetailViewController

static CGFloat const MAX_PLAY_TIME = 99.99;
static CGFloat const TIMER_UPDATE_INTERVAL = 0.2;

@synthesize levelFileName = _levelFileName;
@synthesize timer = _timer;
@synthesize playTime = _playTime;
@synthesize timerTextField = _timerTextField;
@synthesize vertexes = _vertexes;
@synthesize edges = _edges;

- (void)dealloc
{
    self.levelFileName = nil;
    self.timer = nil;
    self.timerTextField = nil;
    self.vertexes = nil;
    self.edges = nil;
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil levelFileName:(NSString *)levelFileName
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.layer.contents = (id)[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Background" ofType:@"png" inDirectory:@"Images"]].CGImage;
        self.levelFileName = levelFileName;
        
        NSString *levelName = [self.levelFileName substringToIndex:self.levelFileName.length - 4];
        self.title = NSLocalizedString(levelName, levelName);
        
        [self loadLevel];
        
        self.playTime = 0.0;
    }
    
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentPosition = [touch locationInView:self.view];
    CGFloat mindifference = distanceBetweenPoints(CGPointMake([[[self.vertexes objectAtIndex:0] objectAtIndex:0] intValue], [[[self.vertexes objectAtIndex:0] objectAtIndex:1] intValue]), currentPosition);
    for (NSInteger i = 0; self.vertexes.count; i++) 
    {
        CGFloat difference = distanceBetweenPoints(CGPointMake([[[self.vertexes objectAtIndex:i] objectAtIndex:0] intValue], [[[self.vertexes objectAtIndex:i] objectAtIndex:1] intValue]), currentPosition);
        if (absOfNumber(difference) < absOfNumber(mindifference)) 
        {
            mindifference = difference;
        }
    }
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    /*Vector vector = VectorMake(([touch locationInView:self.view].x - self.view.center.x)/PIXELS_IN_METER, ([touch locationInView:self.view].y - self.view.center.y)/PIXELS_IN_METER);
    
    for (Ball *ball in self.balls) {
        ball.force = VectorMake(ball.mass * vector.x, ball.mass * vector.y);
    }*/
}

- (void) loadLevel
{
    NSString *levelContentString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:self.levelFileName ofType:nil inDirectory:@"Levels"] encoding:NSUTF8StringEncoding error:nil];
    NSArray *levelContentArray = [levelContentString componentsSeparatedByString:@"\n"];
    NSInteger stringNumber = [[levelContentArray objectAtIndex:0] intValue] + 1;
    NSInteger vertexesCount = [[levelContentArray objectAtIndex:stringNumber++] intValue];
    self.vertexes = [[[NSMutableArray alloc] initWithCapacity:vertexesCount] autorelease];
    for (NSInteger i = stringNumber; i < stringNumber + vertexesCount; i++) {
        NSArray *vertexData = [[levelContentArray objectAtIndex:i] componentsSeparatedByString:@" "];
        Vertex *vertex = [self vertexWithNumber:(i - stringNumber + 1) XCoordinate:[[vertexData objectAtIndex:0] intValue] YCoordinate:[[vertexData objectAtIndex:1] intValue]];
        [self.vertexes addObject:vertex];
        [self.view.layer addSublayer:vertex];
    }
    stringNumber += vertexesCount;
    
    NSInteger edgesCount = [[levelContentArray objectAtIndex:stringNumber++] intValue];
    self.edges = [[[NSMutableArray alloc] initWithCapacity:edgesCount] autorelease];
    for (NSInteger i = stringNumber; stringNumber + edgesCount; i++) 
    {
        NSArray *edgeData = [[levelContentArray objectAtIndex:i] componentsSeparatedByString:@" "];
        Edge *edge = [self edgeWithNumber:(i - stringNumber + 1) XCoordinate:[[edgeData objectAtIndex:0] intValue] YCoordinate:[[edgeData objectAtIndex:1] intValue]];
    }
}

- (Vertex *) vertexWithNumber:(NSInteger)number XCoordinate:(NSInteger)XCoordinate YCoordinate:(NSInteger)YCoordinate
{
    Vertex *vertex = [[[Vertex alloc] initWithNumber:number initialPosition:CGPointMake(XCoordinate, YCoordinate)] autorelease];
    vertex.contents = (id)[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Vertex" ofType:@"png" inDirectory:@"Images"]] CGImage];
    vertex.frame = CGRectMake(0, 0, 100, 100);
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
    self.timer = [NSTimer scheduledTimerWithTimeInterval:TIMER_UPDATE_INTERVAL target:self selector:@selector(updateTimerTextField) userInfo:nil repeats:YES];
    [super viewDidAppear:animated];
}

- (void) updateTimerTextField
{
    self.playTime += TIMER_UPDATE_INTERVAL;
    
    if (self.playTime > MAX_PLAY_TIME)
    {
        [self.timer invalidate];
        UIAlertView *alertOfBallInTheHole = [[[UIAlertView alloc] initWithTitle:@"You are losеr" message:@"It's too long..." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] autorelease];
        [alertOfBallInTheHole show];
    }
    
    self.timerTextField.text = [NSString stringWithFormat:@"%0.2f", self.playTime];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    self.playTime = 0.0;
    
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) handleBallInTheHoleNotification:(NSNotification *)notification
{
    [self.timer invalidate];
}

- (void) handleBallInTheFinishHoleNotification:(NSNotification *)notification
{
    [self.timer invalidate];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.title == @"You are losеr")
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    if (alertView.title == @"You are winner!")
    {
        if (buttonIndex == 0) {
            [self addToRecordsNotificationForPlayTime:self.playTime];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)addToRecordsNotificationForPlayTime:(CGFloat)playTime
{
    NSMutableDictionary *notificationDictionary = [NSMutableDictionary dictionaryWithObject:self.levelFileName forKey:@"levelFileName"];
    [notificationDictionary setValue:[NSNumber numberWithFloat:playTime] forKey:@"playTime"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addToRecords" object:self userInfo:notificationDictionary];
}

@end

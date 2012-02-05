//
//  OptionsViewController.m
//  GraphGame
//
//  Created by admin on 03.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MasterViewController.h"
#import "OptionsViewController.h"

CGFloat const ANIMATE_DURATION = 0.4;

@interface OptionsViewController()
{
    NSInteger _distanceToMoveView;
}

@property(retain, nonatomic) MasterViewController *masterViewConrtroller;

@property (retain, nonatomic) IBOutlet UITextField *playerNameTextField;

- (void) returnViewToInitialState;

@end

@implementation OptionsViewController

@synthesize masterViewConrtroller = _masterViewConrtroller;
@synthesize playerNameTextField = _playerNameTextField;

- (void)dealloc
{
    self.masterViewConrtroller = nil;
    
    self.playerNameTextField = nil;
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil masterViewControlle:(MasterViewController *)masterViewController
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        _distanceToMoveView = 0;
        self.masterViewConrtroller = masterViewController;
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.playerNameTextField.text = self.masterViewConrtroller.playerName;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.playerNameTextField resignFirstResponder];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.playerNameTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self returnViewToInitialState];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _distanceToMoveView = textField.center.y - self.view.center.y + textField.bounds.size.height;
    
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        self.view.center = CGPointMake(self.view.center.x, self.view.center.y - _distanceToMoveView);
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self returnViewToInitialState];
}

- (IBAction)playerNameEditingDidEnd:(id)sender {
    self.masterViewConrtroller.playerName = self.playerNameTextField.text;
}

- (void) returnViewToInitialState
{
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        self.view.center = CGPointMake(self.view.center.x, self.view.center.y + _distanceToMoveView);
    }];
}

@end

//
//  Vertex.m
//  GraphGame
//
//  Created by admin on 01.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Vertex.h"

@interface Vertex()

@property (strong, nonatomic) DetailViewController *viewController;
@property (nonatomic) CGPoint initialPosition;
@property (retain, nonatomic) NSTimer *redrawTimer;
@property (nonatomic) NSInteger number;

- (void) stopWithEdgesCrossed;
- (void) stopWithEdgesReleased;

@end

@implementation Vertex

@synthesize viewController = _viewController;
@synthesize initialPosition = _initialPosition;
@synthesize redrawTimer = _redrawTimer;
@synthesize number = _number;

- (id) initwithNumber:(NSInteger)number initialPosition:(CGPoint)initialPosition
{
    self = [super unit];
    _number = number;
    self.initialPosition = initialPosition;
    self.zPosition = 0;
    return self;
}

- (void) toInitialState
{
    [self.redrawTimer invalidate];
    self.position = self.initialPosition;
    self.zPosition = 0;
}

/*- (vid)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 10; 
    self.layer.shadowOffset = CGSizeMake(0, 12); 
    CGPathRef path = CGPathCreateWithRect(self.layer.bounds, NULL); 
    self.layer.shadowPath = path; 
    CGPathRelease(path); 
    [UIView animateWithDuration:0.1 animations:^{
        self.transform = CGAffineTransformMakeScale(1.25, 1.25);
    }];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPos = [touch locationInView:self.superview];
    CGPoint prevPos = [touch previousLocationInView:self.superview];
    self.center = CGPointMake(self.center.x - prevPos.x + currentPos.x, self.center.y - prevPos.y + currentPos.y);
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    self.layer.shadowOpacity = 0.0;
    [UIView animateWithDuration:0.1 animations:^{
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}*/

@end

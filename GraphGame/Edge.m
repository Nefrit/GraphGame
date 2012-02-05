//
//  Edge.m
//  GraphGame
//
//  Created by admin on 04.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Edge.h"

@interface Edge()

@property (strong, nonatomic) DetailViewController *viewController;
@property (nonatomic) CGPoint initialPosition1;
@property (nonatomic) CGPoint initialPosition2;

@end

@implementation Edge

@synthesize viewController = _viewController;
@synthesize initialPosition1 = _initialPosition1;
@synthesize initialPosition2 = _initialPosition2;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

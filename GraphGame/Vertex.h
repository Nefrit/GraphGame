//
//  Vertex.h
//  GraphGame
//
//  Created by admin on 01.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "DetailViewController.h"

@interface Vertex : CALayer

- (id) initWithNumber:(NSInteger)number initialPosition:(CGPoint)initialPosition;
- (void) toInitialState;

@end

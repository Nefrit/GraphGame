//
//  Math.h
//  GraphGame
//
//  Created by Приходько Александр on 04.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef GraphGame_Math_h
#define GraphGame_Math_h

static inline NSInteger
signOfNumber(CGFloat number)
{
    if (number != 0) {
        number = (number < 0) ? -1 : +1;
    }
    
    return number;
};

static inline CGFloat
absOfNumber(CGFloat number)
{
    return number < 0 ? -number : number;
};


static inline CGFloat
distanceBetweenPoints(CGPoint point1, CGPoint point2)
{
    CGFloat dx = point1.x - point2.x;
    CGFloat dy = point1.y - point2.y;
    
    return sqrtf(dx*dx + dy*dy);
};

#endif

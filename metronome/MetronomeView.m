//
//  MetronomeView.m
//  metronome
//
//  Created by Evan Sheehan on 11/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MetronomeView.h"
#import <QuartzCore/QuartzCore.h>

#define   DEGREES_TO_RADIANS(degrees)  ((M_PI * degrees)/ 180)

@implementation MetronomeView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.opaque = NO;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGFloat w = rect.size.width;
    CGFloat h = rect.size.height;
    CGFloat r = MIN(w, h) / 2.0;
            
    UIBezierPath *circle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(w / 2, h / 2) radius:r startAngle:0 endAngle:DEGREES_TO_RADIANS(360) clockwise:YES];
    [[UIColor redColor] setFill];

    [circle fill];
}


@end

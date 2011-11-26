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

CALayer* makeLayer(CGRect frame);

@implementation MetronomeView

@synthesize beats=_beats;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.opaque = NO;
        count = 0;
    }
    
    return self;
}

- (void)setBeats:(NSNumber *)beats {
    float gutter = self.frame.size.width / (3 * [beats floatValue] + 1);
    float y = self.frame.size.height / 2 - gutter;

    CALayer *tickArray[[beats intValue]];
    
    for (int i = 0; i < [ticks count]; i++) {
        [[ticks objectAtIndex:i] removeFromSuperlayer];
    }

    for (int i = 0; i < [beats intValue]; i++) {
        CGRect bounds = CGRectMake(i * 3 * gutter + gutter, y, 2 * gutter, 2 * gutter);

        CALayer *layer = makeLayer(bounds);
        [self.layer addSublayer:layer];
        tickArray[i] = layer;
    }
    
    ticks = [NSArray arrayWithObjects:tickArray count:[beats unsignedIntValue]];    
    _beats = beats;
}

- (void)tick:(NSTimer *)timer {
    CALayer *layer = [ticks objectAtIndex:count];
    layer.opacity = 1.0;
    
    CABasicAnimation *hide = [CABasicAnimation animationWithKeyPath:@"opacity"];
    hide.duration = [timer.userInfo doubleValue];
    hide.fromValue = [NSNumber numberWithFloat:1.0];
    hide.toValue = [NSNumber numberWithFloat:0.0];
    [layer addAnimation:hide forKey:@"animateOpacity"];
    
    count++;
    if (count >= [_beats intValue]) {
        count = 0;
    }
}

- (void)reset {
    count = 0;
    
    for (int i = 0; i < [ticks count]; i++) {
        CALayer *l = [ticks objectAtIndex:i];
        [l removeAllAnimations];
        l.opacity = 0.0;
    }
}
@end

CALayer* makeLayer(CGRect frame) {
    CGFloat comps[] = {0.5, 1.0};
    
    CALayer *layer = [[CALayer alloc] init];
    layer.frame = frame;
    layer.opaque = YES;
    layer.cornerRadius = frame.size.height / 2;
    layer.backgroundColor = CGColorCreate(CGColorSpaceCreateDeviceGray(), comps);
    layer.opacity = 0.0;
    return layer;
    
}

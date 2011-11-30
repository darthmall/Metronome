//
//  MetronomeView.m
//  metronome
//
//  Created by Evan Sheehan on 11/24/11.
//  Copyright (c) 2011 Evan Sheehan. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "MetronomeBeatView.h"

#define   DEGREES_TO_RADIANS(degrees)  ((M_PI * degrees)/ 180)

CALayer* makeLayer(CGRect frame);

@implementation MetronomeBeatView

@synthesize beats=_beats;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        count = 0;
    }
    
    return self;
}

- (void)setBeats:(NSNumber *)beats {
    // The width of the space between circles should be 1/3 the circle diameter, which should be calculated from the width of our frame.
    float gutter = self.frame.size.width / (3 * [beats floatValue] + 1);
    
    // Center the circles vertically within the frame.
    float y = self.frame.size.height / 2 - gutter;

    // Circles are (cleverly) just rectangular CoreAnimation layers whose corner radius is half their height. Thanks to Christian Fernando Strømmen for this one.
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

- (void)tick:(NSNumber *)duration {
    
    CALayer *layer = [ticks objectAtIndex:count];

    [layer removeAllAnimations];

    // Fade the dots out after they appear.
    CABasicAnimation *hide = [CABasicAnimation animationWithKeyPath:@"opacity"];
    hide.duration = duration.doubleValue;
    hide.fromValue = [NSNumber numberWithFloat:1.0];
    hide.toValue = [NSNumber numberWithFloat:0.0];
    hide.removedOnCompletion = YES;
    hide.autoreverses = NO;
    hide.repeatCount = 0;
    [layer addAnimation:hide forKey:@"animateOpacity"];
    
    // Counter management.
    count++;
    if (count >= [_beats intValue]) {
        count = 0;
    }
}

- (void)reset {
    count = 0;
    
    // Clear all the CoreAnimation layers from the view
    for (int i = 0; i < [ticks count]; i++) {
        CALayer *l = [ticks objectAtIndex:i];
        [l removeAllAnimations];
        l.opacity = 0.0;
    }
}
@end

# pragma mark - Helper functions

// Factory for CoreAnimation layers.
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

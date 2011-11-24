//
//  MetronomeView.m
//  metronome
//
//  Created by Evan Sheehan on 11/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MetronomeView.h"
#import <QuartzCore/QuartzCore.h>

@implementation MetronomeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
//        self.layer.bounds = frame;
//        self.layer.opaque = YES;
    }

    return self;
}

- (void)drawRect:(CGRect)rect {
    [[UIColor blackColor] set];
    UIRectFill(rect);
}


@end

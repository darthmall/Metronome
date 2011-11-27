//
//  MetronomeView.h
//  metronome
//
//  Created by Evan Sheehan on 11/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MetronomeBeatView : UIView {
    NSArray *ticks;
    NSInteger count;
}

@property (assign, nonatomic) NSNumber *beats;

- (void)tick:(NSTimer *)timer;
- (void)reset;

@end

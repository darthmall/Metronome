//
//  MetronomeView.h
//  
// Custom UIView for visualizing the beats counted by the metronome.
//
//  Created by Evan Sheehan on 11/24/11.
//  Copyright (c) 2011 Evan Sheehan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MetronomeBeatView : UIView {
    NSArray *ticks;
    NSInteger count;
}

@property (assign, nonatomic) NSNumber *beats;

- (void)tick:(NSNumber *)duration;
- (void)reset;

@end

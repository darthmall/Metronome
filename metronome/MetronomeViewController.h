//
//  ViewController.h
//  metronome
//
//  Created by Evan Sheehan on 11/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SettingsViewController.h"
#import "Settings.h"
#import "MetronomeBeatView.h"

@interface MetronomeViewController : UIViewController <UIScrollViewDelegate> {
    UILongPressGestureRecognizer *longPressGesture;
    MetronomeBeatView *display;
}

@property (assign) NSTimer *timer;
@property (strong, nonatomic) Settings *current;

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *meterLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempoLabel;

- (IBAction)start:(id)sender;
- (void)stop:(id)senderOrNil;

@end

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
#import "MetronomeView.h"

@interface MetronomeController : UIViewController <SettingsViewControllerDelegate> {
    NSTimer *timer;
    UILongPressGestureRecognizer *longPressGesture;
    MetronomeView *display;
}

@property (assign) NSTimer *timer;
@property (strong, nonatomic) Settings *current;

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *meterLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempoLabel;

- (IBAction)playPause:(id)sender;
- (void)tick:(NSTimer *)timer;

@end

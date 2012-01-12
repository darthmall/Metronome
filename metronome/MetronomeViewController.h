//
//  ViewController.h
//  
//  View controller that manages the metronome. Handles starting and stopping as well as updating the visual display and playing the audio.
//
//  Created by Evan Sheehan on 11/21/11.
//  Copyright (c) 2011 Evan Sheehan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

#import "SettingsViewController.h"
#import "MetronomeBeatView.h"

@interface MetronomeViewController : UIViewController <UIScrollViewDelegate, SettingsViewControllerDelegate> {
    UILongPressGestureRecognizer *longPressGesture;
    MetronomeBeatView *display;
    CFURLRef soundFileURLRef;
    SystemSoundID soundFileObject;
}

@property (assign) NSTimer *timer;
@property (strong, nonatomic) NSNumber *meter;
@property (strong, nonatomic) NSNumber *tempo;

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *meterLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempoLabel;

- (IBAction)start:(id)sender;
- (void)stop:(id)senderOrNil;
- (void)tick:(NSTimer *)timer;

@end

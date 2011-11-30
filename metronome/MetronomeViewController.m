//
//  ViewController.m
//  metronome
//
//  Created by Evan Sheehan on 11/21/11.
//  Copyright (c) 2011 Evan Sheehan. All rights reserved.
//

#import "MetronomeViewController.h"
#import "SettingsViewController.h"

@implementation MetronomeViewController

@synthesize timer=_timer;
@synthesize meter=_meter;
@synthesize tempo=_tempo;

@synthesize button;
@synthesize meterLabel;
@synthesize tempoLabel;

- (void)setMeter:(NSNumber *)meter {
    _meter = meter;
    meterLabel.text = meter.stringValue;
    display.beats = meter;
}

- (void)setTempo:(NSNumber *)tempo {
    _tempo = tempo;
    tempoLabel.text = tempo.stringValue;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tick" withExtension: @"aif"];
    
    // Store the URL as a CFURLRef instance
    soundFileURLRef = (__bridge CFURLRef) tapSound;
    
    // Create a system sound object representing the sound file.
    AudioServicesCreateSystemSoundID (soundFileURLRef, &soundFileObject);
    
    // Initialize the display
    tempoLabel.text = [_tempo stringValue];
    meterLabel.text = [_meter stringValue];

    // Hook up the long press to stop the metronome
    longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(stop:)];
    [self.view addGestureRecognizer:longPressGesture];

    // Set up the beat display hidden in the same frame as the button
    display = [[MetronomeBeatView alloc] initWithFrame:button.frame];
    display.hidden = YES;
    display.beats = _meter;

    // Bam, said the lady!
    [self.view addSubview:display];
}

- (void)viewDidUnload {
    // Clean up, aisle one!
    self.meter = nil;
    self.tempo = nil;

    [self setTempoLabel:nil];
    [self setMeterLabel:nil];
    [self setTimer:nil];
    [self setButton:nil];
    [self setView:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Event handlers

- (void)stop:(id)senderOrNil {
    if (_timer) {
        // Replace the metronome with the start button.
        display.hidden = YES;
        button.hidden = NO;
        
        // Rest and clean up
        [display reset];
        [_timer invalidate];
        _timer = nil;
    }
}

- (IBAction)start:(id)sender {
    if (!self.timer) {
        // Calculate the timer interval based on the tempo in beats per minute
        double interval = 60.0 / [_tempo doubleValue];
        button.hidden = YES;
        display.hidden = NO;
                
        // Start the repeating timer that counts the beats.
        _timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(tick:) userInfo:[NSNumber numberWithDouble:interval * ([_meter doubleValue] / 2)] repeats:YES];
    }
}

#pragma mark - NSTimer actions

- (void)tick:(NSTimer *)timer {
    // Update the display. Oh yeah, and tick!
    [display tick:(NSNumber *)timer.userInfo];
    AudioServicesPlaySystemSound(soundFileObject);
}

#pragma mark - SettingsViewControllerDelegate

- (void)meterDidChange:(NSNumber *)meter {
    self.meter = meter;
}

- (void)tempoDidChange:(NSNumber *)tempo {
    self.tempo = tempo;
}

@end

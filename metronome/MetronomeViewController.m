//
//  ViewController.m
//  metronome
//
//  Created by Evan Sheehan on 11/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MetronomeViewController.h"
#import "SettingsViewController.h"

@implementation MetronomeViewController

@synthesize timer;
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
    if (timer) {
        display.hidden = YES;
        button.hidden = NO;
        [display reset];
        [timer invalidate];
        timer = nil;
    }
}

- (IBAction)start:(id)sender {
    if (!self.timer) {
        double interval = 60.0 / [_tempo doubleValue];
        // Initialize the timer and the visual bell.

        button.hidden = YES;
        display.hidden = NO;
                
        // Start the repeating timer that counts the beats.
        timer = [NSTimer scheduledTimerWithTimeInterval:interval target:display selector:@selector(tick:) userInfo:[NSNumber numberWithDouble:interval * ([_meter doubleValue] / 2)] repeats:YES];
    }
}

#pragma mark - SettingsViewControllerDelegate

- (void)meterDidChange:(NSNumber *)meter {
    self.meter = meter;
}

- (void)tempoDidChange:(NSNumber *)tempo {
    self.tempo = tempo;
}

@end

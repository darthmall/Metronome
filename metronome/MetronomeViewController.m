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

@synthesize timer, current=_current;

@synthesize button;
@synthesize meterLabel;
@synthesize tempoLabel;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // Default settings
        _current = [[Settings alloc] init];
        _current.tempo = [NSNumber numberWithInt:60];
        _current.meter = [NSNumber numberWithInt:4];
    }
    
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];


    // Initialize the display
    tempoLabel.text = [_current.tempo stringValue];
    meterLabel.text = [_current.meter stringValue];

    // Hook up the long press to stop the metronome
    longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(stop:)];
    [self.view addGestureRecognizer:longPressGesture];

    // Set up the beat display hidden in the same frame as the button
    display = [[MetronomeBeatView alloc] initWithFrame:button.frame];
    display.hidden = YES;
    display.beats = self.current.meter;

    // Bam, said the lady!
    [self.view addSubview:display];
}

- (void)viewDidUnload {
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
        double interval = 60.0 / [self.current.tempo doubleValue];
        // Initialize the timer and the visual bell.

        button.hidden = YES;
        display.hidden = NO;
                
        // Start the repeating timer that counts the beats.
        timer = [NSTimer scheduledTimerWithTimeInterval:interval target:display selector:@selector(tick:) userInfo:[NSNumber numberWithDouble:interval * ([self.current.meter doubleValue] - 1.0)] repeats:YES];
    }
}

#pragma mark - SettingsViewControllerDelegate

- (void)settingsViewController:(SettingsViewController *)controller didChangeSettings:(Settings *)settings {
    _current = settings;
    tempoLabel.text = [self.current.tempo stringValue];
    meterLabel.text = [self.current.meter stringValue];
    display.beats = settings.meter;
}

@end

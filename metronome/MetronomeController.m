//
//  ViewController.m
//  metronome
//
//  Created by Evan Sheehan on 11/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MetronomeController.h"
#import "SettingsViewController.h"

@implementation MetronomeController

@synthesize timer=_timer;
@synthesize current=_current;

@synthesize button;
@synthesize meterLabel;
@synthesize tempoLabel;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Settings *settings = [[Settings alloc] init];
    settings.tempo = [NSNumber numberWithInt:60];
    settings.meter = [NSNumber numberWithInt:4];
    
    self.current = settings;
    
    self.tempoLabel.text = [self.current.tempo stringValue];
    self.meterLabel.text = [self.current.meter stringValue];
    
    longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(stop:)];
    [self.view addGestureRecognizer:longPressGesture];
    
    display = [[MetronomeView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 160)];
    display.hidden = YES;
    display.beats = self.current.meter;

    [self.view addSubview:display];
}

- (void)viewDidUnload
{
    [self setTempoLabel:nil];
    [self setMeterLabel:nil];
    [self setTimer:nil];
    [self setButton:nil];
    [self setView:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowSettings"]) {
        SettingsViewController *controller = segue.destinationViewController;
        controller.current = self.current;
        controller.delegate = self;
        
        // Stop the metronome if it's running.
        if (self.timer) {            
            display.hidden = YES;
            self.button.hidden = NO;
            [display reset];
            [self.timer invalidate];
            [self setTimer:nil];
        }
    }
}

- (IBAction)handlePanGesture:(UIGestureRecognizer *)sender {
    [self performSegueWithIdentifier:@"ShowConfig" sender:self];
}

- (IBAction)stop:(UIGestureRecognizer *)sender {
    if (self.timer) {
        display.hidden = YES;
        self.button.hidden = NO;
        [display reset];
        [self.timer invalidate];
        [self setTimer:nil];
    }
}

- (void)tick:(NSTimer *)timer {
    // Increment the beat counter and wrap if necessary.
    [display tick:[NSNumber numberWithDouble:60.0 / [self.current.tempo doubleValue] * ([self.current.meter doubleValue] - 1.0)]];
}

- (IBAction)playPause:(id)sender
{
    if (!self.timer) {
        double interval = 60.0 / [self.current.tempo doubleValue];
        // Initialize the timer and the visual bell.

        self.button.hidden = YES;
        display.hidden = NO;
                
        // Start the repeating timer that counts the beats.
        self.timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(tick:) userInfo:nil repeats:YES];
        [display tick:[NSNumber numberWithDouble:interval * ([self.current.meter doubleValue] - 1.0)]];
    }
}

- (void)settingsViewController:(SettingsViewController *)controller didChangeSettings:(Settings *)settings {
    self.current = settings;
    self.tempoLabel.text = [self.current.tempo stringValue];
    self.meterLabel.text = [self.current.meter stringValue];
    display.beats = settings.meter;

    [[self navigationController] popViewControllerAnimated:YES];
}

@end

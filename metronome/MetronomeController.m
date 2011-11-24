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

@synthesize theView;
@synthesize bell;
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
}

- (void)viewDidUnload
{
    [self setTempoLabel:nil];
    [self setMeterLabel:nil];
    [self setTimer:nil];
    [self setButton:nil];
    [self setBell:nil];
    [self setTheView:nil];
    [self setView:nil];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    }
}

- (IBAction)handlePanGesture:(UIGestureRecognizer *)sender {
    [self performSegueWithIdentifier:@"ShowConfig" sender:self];
}

- (void)tick:(NSTimer *)timer {
    // Increment the beat counter and wrap if necessary.
    count++;
    if (count > [self.current.meter integerValue]) {
        count = 1;
    }
    
    // Update the visual bell and show it.
    self.bell.text = [NSString stringWithFormat:@"%d", count];
    self.bell.hidden = NO;
    
    // Schedule a timer to hide the bell.
    [NSTimer scheduledTimerWithTimeInterval:30.0/[self.current.tempo doubleValue] target:self selector:@selector(tock:) userInfo:nil repeats:NO];
}

- (void)tock:(NSTimer *)timer {
    self.bell.hidden = YES;
}

- (IBAction)playPause:(id)sender
{
    if (!self.timer) {
        count = 1;

        [self.button setTitle:@"Stop"forState:UIControlStateNormal];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:60.0/[self.current.tempo doubleValue] target:self selector:@selector(tick:) userInfo:nil repeats:YES];
    } else {
        [self.button setTitle:@"Start" forState:UIControlStateNormal];
        self.bell.hidden = YES;
        [self.timer invalidate];
        [self setTimer:nil];
    }
}

- (void)settingsViewController:(SettingsViewController *)controller didChangeSettings:(Settings *)settings {
    self.current = settings;
    self.tempoLabel.text = [self.current.tempo stringValue];
    self.meterLabel.text = [self.current.meter stringValue];
    
    [[self navigationController] popViewControllerAnimated:YES];
}

@end

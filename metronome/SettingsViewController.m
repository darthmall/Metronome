//
//  SettingsViewController.m
//  metronome
//
//  Created by Evan Sheehan on 11/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"
#import "MetronomeController.h"


@implementation SettingsViewController
@synthesize tempoInput, meterInput, delegate, current;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initialize the input fields with the current settings.
    self.tempoInput.text = [current.tempo stringValue];
    self.meterInput.text = [current.meter stringValue];
}

- (void)viewDidUnload
{
    [self setMeterInput:nil];
    [self setTempoInput:nil];
    [super viewDidUnload];
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)done:(id)sender {
    // Notify the delegate of the changed settings.
    self.current.tempo = [NSNumber numberWithInt:[self.tempoInput.text intValue]];
    self.current.meter = [NSNumber numberWithInt:[self.meterInput.text intValue]];
    
    [self.delegate settingsViewController:self didChangeSettings:self.current];
}

@end

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
@synthesize tempoLabel, meterLabel, delegate, current;

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
    self.tempoLabel.text = [current.tempo stringValue];
    self.meterLabel.text = [current.meter stringValue];
}

- (void)viewDidUnload
{
    self.meterLabel = nil;
    self.tempoLabel = nil;
    self.delegate = nil;
    self.current = nil;
    
    [super viewDidUnload];
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
    self.current.tempo = [NSNumber numberWithInt:[self.tempoLabel.text intValue]];
    self.current.meter = [NSNumber numberWithInt:[self.meterLabel.text intValue]];
    
    [self.delegate settingsViewController:self didChangeSettings:self.current];
}

# pragma mark - Storyboard methods

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SetMeter"]) {
        MeterViewController *meterViewController = segue.destinationViewController;
        
        meterViewController.delegate = self;
        meterViewController.meter = self.current.meter;
    }
}

# pragma mark - MeterViewControllerDelegate

- (void) meterViewController:(MeterViewController *)controller didSelectMeter:(NSInteger)meter {
    self.current.meter = [NSNumber numberWithInteger:meter];
    self.meterLabel.text = [self.current.meter stringValue];

    [self.navigationController popViewControllerAnimated:YES];
}

@end

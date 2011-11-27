//
//  SettingsViewController.m
//  metronome
//
//  Created by Evan Sheehan on 11/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"
#import "MetronomeViewController.h"
#import "BpmController.h"


@implementation SettingsViewController

@synthesize tempoLabel, meterLabel, current, delegate;

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
    self.current = nil;
    
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Properties

- (void)setCurrent:(Settings *)cur {
    current = cur;
    
    self.tempoLabel.text = [cur.tempo stringValue];
    self.meterLabel.text = [cur.meter stringValue];
}
# pragma mark - Storyboard methods

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SetMeter"]) {
        MeterViewController *meterViewController = segue.destinationViewController;
        
        meterViewController.delegate = self;
        meterViewController.meter = self.current.meter;
    } else if ([segue.identifier isEqualToString:@"SetBpm"]) {
        BpmController *bpmViewController = segue.destinationViewController;
        
        bpmViewController.delegate = self;
        bpmViewController.tempo = self.current.tempo;
    }
}

# pragma mark - MeterViewControllerDelegate

- (void) meterViewController:(MeterViewController *)controller didSelectMeter:(NSInteger)meter {
    self.current.meter = [NSNumber numberWithInteger:meter];
    self.meterLabel.text = [self.current.meter stringValue];

    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate settingsViewController:self didChangeSettings:current];
}

# pragma mark - BpmViewControllerDelegate

- (void) bpmController:(BpmController *)controller didChangeTempo:(NSNumber *)tempo {
    self.current.tempo = tempo;
    self.tempoLabel.text = [tempo stringValue];
    [self.delegate settingsViewController:self didChangeSettings:current];
}

@end

//
//  SettingsViewController.m
//  metronome
//
//  Created by Evan Sheehan on 11/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"
#import "MetronomeViewController.h"

@implementation SettingsViewController

@synthesize settingsDelegate;
@synthesize meterLabel;
@synthesize tempoLabel;
@synthesize meterSlider;
@synthesize tempoSlider;
@synthesize meter = _meter;
@synthesize tempo = _tempo;

- (void)setMeter:(NSNumber *)meter {
    _meter = meter;
    meterLabel.text = meter.stringValue;
    meterSlider.value = meter.floatValue;
}

- (void)setTempo:(NSNumber *)tempo {
    _tempo = tempo;
    tempoLabel.text = tempo.stringValue;
    tempoSlider.value = tempo.floatValue;
}

#pragma mark - View lifecycle

- (void)viewDidUnload
{
    settingsDelegate = nil;

    [self setMeterLabel:nil];
    [self setTempoLabel:nil];
    [self setMeterSlider:nil];
    [self setTempoSlider:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UISlider actions

- (IBAction)onMeterSliderChange:(id)sender {
    meterLabel.text = [NSString stringWithFormat:@"%d", (int) meterSlider.value];
    [self.settingsDelegate meterDidChange:[NSNumber numberWithInt:(int) meterSlider.value]];
}

- (IBAction)onTempoSliderChange:(id)sender {
    tempoLabel.text = [NSString stringWithFormat:@"%d", (int) tempoSlider.value];
    [self.settingsDelegate tempoDidChange:[NSNumber numberWithInt:(int) tempoSlider.value]];
}

- (IBAction)onSliderTouchDown:(id)sender {
    UILabel *label;
    
    if ([sender isEqual:meterSlider]) {
        label = meterLabel;
    } else if ([sender isEqual:tempoSlider]) {
        label = tempoLabel;
    }
    
    label.textColor = [UIColor darkGrayColor];
}

- (IBAction)onSliderTouchUp:(id)sender {
    UILabel *label;
    
    if ([sender isEqual:meterSlider]) {
        label = meterLabel;
    } else if ([sender isEqual:tempoSlider]) {
        label = tempoLabel;
    }
                                
    label.textColor = [UIColor lightGrayColor];
}

@end

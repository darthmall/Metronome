//
//  BpmController.m
//  metronome
//
//  Created by Evan Sheehan on 11/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BpmController.h"

@implementation BpmController
@synthesize bpmPicker;

@synthesize delegate, tempo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

    // Initialize the selection on the picker.
    int t = [self.tempo intValue];
    [self.bpmPicker selectRow:t / 100 inComponent:0 animated:NO];
    
    t = t % 100;
    [self.bpmPicker selectRow:t / 10 inComponent:1 animated:NO];
    
    t = t % 10;
    [self.bpmPicker selectRow:t inComponent:2 animated:NO];
}


- (void)viewDidUnload
{
    self.delegate = nil;
    self.tempo = nil;

    [self setBpmPicker:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UIPickerViewDataSource

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return 2;
            
        case 1:
        case 2:
            return 10;
            
        default:
            break;
    }
    
    return 0;
}

#pragma mark - UIPickerViewDelegate
- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%d", row];
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    // Calculate the selected tempo from the three picker components
    NSInteger bpm = [pickerView selectedRowInComponent:0] * 100 + [pickerView selectedRowInComponent:1] * 10 + [pickerView selectedRowInComponent:2];
    self.tempo = [NSNumber numberWithInteger:bpm];
    
    // Notify the delegate of the new tempo
    [self.delegate bpmController:self didChangeTempo:self.tempo];
}

@end

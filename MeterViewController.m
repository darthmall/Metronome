//
//  MeterViewController.m
//  metronome
//
//  Created by Evan Sheehan on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MeterViewController.h"

@implementation MeterViewController
@synthesize delegate = _delegate;
@synthesize meter = _meter;


#pragma mark - View lifecycle

- (void)viewDidUnload
{
    self.meter = nil;

    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UITableViewController methods

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (section == 0) ? 13 : 0;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"MeterCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    NSInteger row = [indexPath indexAtPosition:indexPath.length - 1];
    cell.textLabel.text = [NSString stringWithFormat:@"%d", row + 1];

    // Set the selection on the cell if it's the current meter value
    if (row == _meter.integerValue - 1) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }

    return cell;
}

#pragma mark - UITableViewDelegate methods

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate meterViewController:self didSelectMeter:[indexPath indexAtPosition:indexPath.length - 1] + 1];
}

@end

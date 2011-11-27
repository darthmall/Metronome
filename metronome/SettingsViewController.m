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

@synthesize current, settingsDelegate;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Settings";
    
    [self.tableView setScrollEnabled:NO];
}

- (void)viewDidUnload
{
    self.current = nil;
    
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

# pragma mark - MeterViewControllerDelegate

- (void) meterViewController:(MeterViewController *)controller didSelectMeter:(NSInteger)meter {
    self.current.meter = [NSNumber numberWithInteger:meter];
    
    NSUInteger path[] = {0, 1};
    NSArray *rows = [NSArray arrayWithObject:[NSIndexPath indexPathWithIndexes:path length:2]];

    [self.navigationController popViewControllerAnimated:YES];
    [self.settingsDelegate settingsViewController:self didChangeSettings:current];

    [self.tableView reloadRowsAtIndexPaths:rows withRowAnimation:YES];
}

# pragma mark - BpmViewControllerDelegate

- (void) bpmController:(BpmController *)controller didChangeTempo:(NSNumber *)tempo {
    self.current.tempo = tempo;
    
    NSUInteger path[] = {0, 0};
    NSArray *rows = [NSArray arrayWithObject:[NSIndexPath indexPathWithIndexes:path length:2]];

    [self.settingsDelegate settingsViewController:self didChangeSettings:current];

    [self.tableView reloadRowsAtIndexPaths:rows withRowAnimation:YES];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"SettingsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    switch ([indexPath indexAtPosition:indexPath.length - 1]) {
        case 0:
            cell.textLabel.text = [current.tempo stringValue];
            cell.detailTextLabel.text = @"bpm";
            break;
            
        case 1:
            cell.textLabel.text = [current.meter stringValue];
            cell.detailTextLabel.text = @"meter";
            break;
            
        default:
            break;
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *controller;
    BpmController *bpm;
    MeterViewController *meter;

    switch ([indexPath indexAtPosition:indexPath.length - 1]) {
        case 0:
            bpm = [[BpmController alloc] initWithNibName:@"TempoView" bundle:nil];
            bpm.delegate = self;
            controller = bpm;
            break;
            
        case 1:
            meter = [[MeterViewController alloc] initWithStyle:UITableViewStyleGrouped];
            meter.delegate = self;
            controller = meter;
            break;
            
        default:
            break;
    }

    [self.navigationController pushViewController:controller animated:YES];
}

@end

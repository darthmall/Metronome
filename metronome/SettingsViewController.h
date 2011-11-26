//
//  SettingsViewController.h
//  metronome
//
//  Created by Evan Sheehan on 11/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Settings.h"
#import "MeterViewController.h"

@protocol SettingsViewControllerDelegate;

@interface SettingsViewController : UITableViewController <MeterViewControllerDelegate>

@property (weak, nonatomic) id <SettingsViewControllerDelegate> delegate;
@property (weak, nonatomic) Settings *current;
@property (weak, nonatomic) IBOutlet UILabel *tempoLabel;
@property (weak, nonatomic) IBOutlet UILabel *meterLabel;

- (IBAction)done:(id)sender;

@end

@protocol SettingsViewControllerDelegate <NSObject>

- (void)settingsViewController:(SettingsViewController *)controller didChangeSettings:(Settings *)settings;

@end
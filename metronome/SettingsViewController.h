//
//  SettingsViewController.h
//  metronome
//
//  Created by Evan Sheehan on 11/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Settings.h"

@protocol SettingsViewControllerDelegate;

@interface SettingsViewController : UITableViewController

@property (weak, nonatomic) id <SettingsViewControllerDelegate> delegate;
@property (weak, nonatomic) Settings *current;
@property (weak, nonatomic) IBOutlet UITextField *tempoInput;
@property (weak, nonatomic) IBOutlet UITextField *meterInput;

- (IBAction)done:(id)sender;

@end

@protocol SettingsViewControllerDelegate <NSObject>

- (void)settingsViewController:(SettingsViewController *)controller didChangeSettings:(Settings *)settings;

@end
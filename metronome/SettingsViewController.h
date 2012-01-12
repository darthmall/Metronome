//
//  SettingsViewController.h
//
//  View controller for the settings page. Uses the SettingsViewControllerDelegate to pass new settings to the MetronomeViewController.
//
//  Created by Evan Sheehan on 11/22/11.
//  Copyright (c) 2011 Evan Sheehan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingsViewControllerDelegate;

@interface SettingsViewController : UIViewController

@property (strong, nonatomic) NSNumber *meter;
@property (strong, nonatomic) NSNumber *tempo;

@property (weak, nonatomic) id<SettingsViewControllerDelegate> settingsDelegate;

@property (weak, nonatomic) IBOutlet UILabel *meterLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempoLabel;
@property (weak, nonatomic) IBOutlet UISlider *meterSlider;
@property (weak, nonatomic) IBOutlet UISlider *tempoSlider;

- (IBAction)onMeterSliderChange:(id)sender;
- (IBAction)onTempoSliderChange:(id)sender;

- (IBAction)onSliderTouchDown:(id)sender;
- (IBAction)onSliderTouchUp:(id)sender;

@end

@protocol SettingsViewControllerDelegate <NSObject>

- (void)meterDidChange:(NSNumber *)meter;
- (void)tempoDidChange:(NSNumber *)tempo;

@end
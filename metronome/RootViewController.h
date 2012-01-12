//
//  RootViewController.h
//  
//  Root controller that sets up the metronome and settings controllers in a UIScrollView.
//
//  Created by Evan Sheehan on 11/26/11.
//  Copyright (c) 2011 Evan Sheehan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MetronomeViewController.h"
#import "SettingsViewController.h"

@interface RootViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) MetronomeViewController *metronome;
@property (strong, nonatomic) SettingsViewController *settings;

@end

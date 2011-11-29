//
//  RootViewController.h
//  metronome
//
//  Created by Evan Sheehan on 11/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MetronomeViewController.h"
#import "SettingsViewController.h"

@interface RootViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) MetronomeViewController *metronome;
@property (strong, nonatomic) SettingsViewController *settings;

@end

//
//  AppDelegate.h
//  metronome
//
//  Created by Evan Sheehan on 11/21/11.
//  Copyright (c) 2011 Evan Sheehan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RootViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (strong, nonatomic) RootViewController *rootView;

@end

//
//  AppDelegate.m
//  metronome
//
//  Created by Evan Sheehan on 11/21/11.
//  Copyright (c) 2011 Evan Sheehan. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window, rootView;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    self.rootView = [[RootViewController alloc] init];

    [self.window addSubview:rootView.view];
    [self.window makeKeyAndVisible];

    return YES;
}

@end

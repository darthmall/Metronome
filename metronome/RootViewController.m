//
//  RootViewController.m
//  metronome
//
//  Created by Evan Sheehan on 11/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

@synthesize scrollView, metronome, settings;

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect rect = self.view.bounds;

    self.wantsFullScreenLayout = YES;

    // Configure the scroll view
    self.scrollView = [[UIScrollView alloc] initWithFrame:rect];
    self.scrollView.contentSize = CGSizeMake(rect.size.width, 2 * rect.size.height);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    // Set up the metronome view
    metronome = [[MetronomeViewController alloc] initWithNibName:@"MetronomeView" bundle:nil];
    metronome.view.frame = CGRectMake(0.0, rect.size.height, rect.size.width, rect.size.height);
    
    [scrollView scrollRectToVisible:metronome.view.frame
                           animated:NO];
    
    [self.scrollView addSubview:metronome.view];
    
    // Set up the settings view
    UIStoryboard *settingsStoryboard = [UIStoryboard storyboardWithName:@"Settings" bundle:nil];
    UINavigationController *navigationController = [settingsStoryboard instantiateInitialViewController];
    SettingsViewController *settingsView = (SettingsViewController *) navigationController.topViewController;
    settingsView.view.frame = rect;
    settingsView.current = metronome.current;
    
    self.settings = settingsView;
    [self.scrollView addSubview:settingsView.view];

    [self.view addSubview:scrollView];
}

- (void)viewDidUnload {
    [super viewDidUnload];

    self.scrollView = nil;
    self.metronome = nil;
    self.settings = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.metronome stop:nil];
}

@end

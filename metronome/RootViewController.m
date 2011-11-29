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
    self.scrollView.delegate = self;

    // FIXME: Load from plist
    NSNumber *defaultMeter = [NSNumber numberWithInt:4];
    NSNumber *defaultTempo = [NSNumber numberWithInt:120];

    // Set up the metronome view
    metronome = [[MetronomeViewController alloc] initWithNibName:@"MetronomeView" bundle:nil];
    metronome.view.frame = CGRectMake(0.0, rect.size.height, rect.size.width, rect.size.height);
    metronome.meter = defaultMeter;
    metronome.tempo = defaultTempo;
    
    [scrollView scrollRectToVisible:metronome.view.frame animated:NO];
    
    [self.scrollView addSubview:metronome.view];
    
    // Set up the settings view
    settings = [[SettingsViewController alloc] initWithNibName:@"SettingsView" bundle:nil];
    settings.meter = defaultMeter;
    settings.tempo = defaultTempo;
    settings.settingsDelegate = metronome;
    
    [scrollView addSubview:settings.view];

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

#pragma mark - Navigation Controller Delegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    CGSize size = self.view.bounds.size;
    
    // Set the content size of the scroll view to allow for scrolling between the metronome and settings only when the settings view is displayed by the navigation controller. Otherwise we're drilled down in the settings and should set the content height to match the view bounds so that users can't scroll until they go back to the root settings view.
    if ([viewController isEqual:settings]) {
        size.height *= 2;
    }

    self.scrollView.contentSize = size;
}

@end

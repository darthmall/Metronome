//
//  RootViewController.m
//  metronome
//
//  Created by Evan Sheehan on 11/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

@synthesize scrollView, metronome, settings, navController;

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect rect = self.view.bounds;
//    rect.origin.y -= 20;

    self.wantsFullScreenLayout = YES;

    // Configure the scroll view
    self.scrollView = [[UIScrollView alloc] initWithFrame:rect];
    self.scrollView.contentSize = CGSizeMake(rect.size.width, 2 * rect.size.height);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    
    // Set up the metronome view
    metronome = [[MetronomeViewController alloc] initWithNibName:@"MetronomeView" bundle:nil];
    metronome.view.frame = CGRectMake(0.0, rect.size.height, rect.size.width, rect.size.height);
    
    [scrollView scrollRectToVisible:metronome.view.frame
                           animated:NO];
    
    [self.scrollView addSubview:metronome.view];
    
    self.navController = [[UINavigationController alloc] init];
    [navController.view setFrame:CGRectMake(0.0, 0.0, rect.size.width, rect.size.height)];
    
    // Set up the settings view
    settings = [[SettingsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [settings.view setFrame:navController.view.frame];
    settings.current = metronome.current;
    settings.settingsDelegate = metronome;
    navController.delegate = self;
    [navController pushViewController:settings animated:NO];

    [self.scrollView addSubview:navController.view];

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
    
    if ([viewController isEqual:settings]) {
        size.height *= 2;
    }
    self.scrollView.contentSize = size;
}

@end

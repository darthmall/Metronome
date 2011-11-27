//
//  MetronomeViewController.m
//  metronome
//
//  Created by Evan Sheehan on 11/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MetronomeViewController.h"

@implementation MetronomeViewController
@synthesize meterLabel;
@synthesize tempoLabel;
@synthesize pageScrollView, metronomeView, settingsView;

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    self.metronomeView = 
    self.settingsView = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingsView"];

    CGRect rect = self.pageScrollView.frame;
    
    self.metronomeView.view.frame = CGRectMake(0, rect.size.height, rect.size.width, rect.size.height);
    self.settingsView.view.frame = rect;

    self.pageScrollView.pagingEnabled = YES;
    self.pageScrollView.contentOffset = CGPointMake(0, rect.size.height);
    self.pageScrollView.contentSize = CGSizeMake(rect.size.width, rect.size.height * 2);
    self.pageScrollView.showsVerticalScrollIndicator = NO;
    
    [self.pageScrollView addSubview:self.settingsView.view];    
    [self.pageScrollView addSubview:self.metronomeView.view];
    
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [self setPageScrollView:nil];
    [self setMeterLabel:nil];
    [self setTempoLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)start:(id)sender {
}
@end

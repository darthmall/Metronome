//
//  MeterViewController.h
//  metronome
//
//  Created by Evan Sheehan on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MeterViewControllerDelegate;

@interface MeterViewController : UITableViewController

@property (strong, nonatomic) NSNumber *meter;
@property (weak, nonatomic) id <MeterViewControllerDelegate> delegate;

@end

@protocol MeterViewControllerDelegate <NSObject>

- (void)meterViewController:(MeterViewController *)controller didSelectMeter:(NSInteger)meter;

@end
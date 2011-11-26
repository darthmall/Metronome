//
//  BpmController.h
//  metronome
//
//  Created by Evan Sheehan on 11/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BpmControllerDelegate;

@interface BpmController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) id<BpmControllerDelegate> delegate;
@property (strong, nonatomic) NSNumber *tempo;
@property (weak, nonatomic) IBOutlet UIPickerView *bpmPicker;

@end

@protocol BpmControllerDelegate <NSObject>

- (void) bpmController:(BpmController *)controller didChangeTempo:(NSNumber *)tempo;

@end
//
//  Settings.h
//  metronome
//
//  Created by Evan Sheehan on 11/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Settings : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *tempo;
@property (nonatomic, strong) NSNumber *meter;

@end

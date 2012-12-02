//
//  GameIcon.m
//  exploreolympic
//
//  Created by bunny on 12-4-7.
//  Copyright (c) 2012年 iDreamStudio. All rights reserved.
//

#import "GameIcon.h"

@implementation GameIcon

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event  
{
    if ([delegate conformsToProtocol:@protocol(IconDelegate)] && [delegate respondsToSelector:@selector(tapIcon:)]) { 
            [delegate performSelector:@selector(tapIcon:) withObject:self]; 
        } 
}

@end

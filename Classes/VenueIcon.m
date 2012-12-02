//
//  VenueIcon.m
//  exploreolympic
//
//  Created by bunny on 12-3-30.
//  Copyright (c) 2012年 iDreamStudio. All rights reserved.
//

#import "VenueIcon.h"

@implementation VenueIcon

@synthesize delegate;

- (id) init
{
    self = [super init];
    if (self) {

    }
    return self;
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (col == -1) {
        if ([delegate conformsToProtocol:@protocol(IconDelegate)] && [delegate respondsToSelector:@selector(moveToBottom:)]) { 
            [delegate performSelector:@selector(moveToBottom:) withObject:self]; 
        } 
    }else {
        if ([delegate conformsToProtocol:@protocol(IconDelegate)] && [delegate respondsToSelector:@selector(moveToTop:)]) { 
            [delegate performSelector:@selector(moveToTop:) withObject:self]; 
        } 
    }
    
    
}

- (void) dealloc 
{
    [super dealloc];
}



@end

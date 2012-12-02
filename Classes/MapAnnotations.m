//
//  MapAnnotations.m
//  exploreolympic
//
//  Created by bunny on 12-5-3.
//  Copyright (c) 2012年 iDreamStudio. All rights reserved.
//

#import "MapAnnotations.h"

@implementation MapAnnotations
@synthesize coordinate;
@synthesize title;
@synthesize subtitle;
-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
    coordinate = c;
    return self;
}

-(void) setTitle:(NSString *)t
{
    title = t;
}
-(void) setSubTitle:(NSString *)subt
{
    subtitle = subt;
}

- (void) dealloc  
{
    [title release];
    [subtitle release];
    [super dealloc];
}
@end

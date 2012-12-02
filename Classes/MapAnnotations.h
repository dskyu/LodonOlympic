//
//  MapAnnotations.h
//  exploreolympic
//
//  Created by bunny on 12-5-3.
//  Copyright (c) 2012年 iDreamStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h> 
#import <MapKit/MapKit.h> 

@interface MapAnnotations : NSObject <MKAnnotation>
{
    CLLocationCoordinate2D coordinate;
    NSString *subtitle; 
    NSString *title; 
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

-(void) setTitle:(NSString *)t;
-(void) setSubTitle:(NSString *)subt;
-(id)initWithCoordinate:(CLLocationCoordinate2D) coordinate;
@end

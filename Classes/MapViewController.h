//
//  MapViewController.h
//  exploreolympic
//
//  Created by bunny on 12-4-12.
//  Copyright (c) 2012年 iDreamStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapAnnotations.h"

@interface MapViewController : UIViewController <MKMapViewDelegate,UIPopoverControllerDelegate>
{
    MKMapView *olympicMap;
    UIToolbar *toolBar;
    UIPopoverController *popverController;
    UIPopoverController *popverVenuesController;
}

@property (nonatomic, retain) IBOutlet MKMapView *olympicMap;
@property (nonatomic, retain) IBOutlet UIToolbar *toolBar;
@property (nonatomic, retain) UIPopoverController *popverController;
@property (nonatomic, retain) UIPopoverController *popverVenuesController;

- (IBAction)buttonSwitchPressed:(id)sender;
- (IBAction)buttonVenuesPressed:(id)sender;
@end

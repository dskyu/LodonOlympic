//
//  MapViewController.m
//  exploreolympic
//
//  Created by bunny on 12-4-12.
//  Copyright (c) 2012年 iDreamStudio. All rights reserved.
//

#import "MapViewController.h"
#import "MapTypeViewController.h"
#import "VenuesListViewController.h"


@implementation MapViewController

@synthesize toolBar;
@synthesize olympicMap;
@synthesize popverController;
@synthesize popverVenuesController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = NSLocalizedString(@"地图",@"tabItem6Title");
        self.tabBarItem.image = [UIImage imageNamed:@"map.png"];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    CLLocationCoordinate2D coords;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    switch ([defaults integerForKey:kMapType]) {
        case 0:
            olympicMap.mapType = MKMapTypeStandard;
            break;
        case 1:
            olympicMap.mapType = MKMapTypeSatellite;
            break;   
        case 2:
            olympicMap.mapType = MKMapTypeHybrid;
            break;   
        default:
            break;
    } 
    coords.latitude = 51.538415;
    coords.longitude = -0.016517;
    MKCoordinateSpan span = MKCoordinateSpanMake(0.002389, 0.005681);
    MKCoordinateRegion region = MKCoordinateRegionMake(coords, span);
    [olympicMap setRegion:region animated:YES];
    
    
    MapAnnotations *annotation = [[MapAnnotations alloc] initWithCoordinate:coords];
    [self.olympicMap addAnnotation:annotation];
    [annotation release];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void) dealloc
{
    [toolBar release];
    [popverController release];
    [olympicMap release];
    [popverVenuesController release];
    [super dealloc];
}

- (IBAction)buttonVenuesPressed:(id)sender
{
    if (!popverVenuesController.popoverVisible) {
        VenuesListViewController *content = [[VenuesListViewController alloc] initWithNibName:@"VenuesListViewController" bundle:nil];
        
        UIPopoverController *aPopover = [[UIPopoverController alloc] initWithContentViewController:content];
        aPopover.delegate = self;
        [content release];
        
        self.popverVenuesController.popoverContentSize = CGSizeMake(320, 200);
        self.popverVenuesController = aPopover;
        [aPopover release];
        [self.popverVenuesController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }  
}

- (IBAction)buttonSwitchPressed:(id)sender
{
    if (!popverController.popoverVisible) {
        MapTypeViewController *content = [[MapTypeViewController alloc] initWithNibName:@"MapTypeViewController" bundle:nil];
        
        UIPopoverController *aPopover = [[UIPopoverController alloc] initWithContentViewController:content];
        aPopover.delegate = self;
        [content release];
        
        self.popverController.popoverContentSize = CGSizeMake(320, 200);
        self.popverController = aPopover;
        [aPopover release];
        [self.popverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }  
    
}

#pragma mark -
#pragma mark MKMapDelegate 


- (void) mapViewWillStartLoadingMap:(MKMapView *)mapView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void) mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void) mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error
{
  /*  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"发生错误"
                                                    message:@"网络连接失败"
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];*/
}

#pragma mark - 
#pragma mark UIPopverController delegate
- (void) popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    
}

- (BOOL) popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
{
    return YES;
}


@end

//
//  VenuesListViewController.m
//  exploreolympic
//
//  Created by bunny on 12-4-17.
//  Copyright (c) 2012年 iDreamStudio. All rights reserved.
//

#import "VenuesListViewController.h"
#import "MapViewController.h"
#import "exploreolympicAppDelegate.h"
#import "MapAnnotations.h"


@implementation VenuesListViewController
@synthesize venuesTableView;
@synthesize selectVenuesInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    exploreolympicAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    database = appDelegate.database;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)dealloc
{
    [super dealloc];
    [selectVenuesInfo release];
    [venuesTableView release];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger result = 0;
    switch (section) {
        case 0:
            result = VenueRow0Number;
            break;
        case 1:
            result = VenueRow1Number;
            break;
        case 2:
            result = VenueRow2Number;
            break;
        default:
            break;
    }
    return result;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *result = nil;
    switch (section) {
        case 0:
            result = @"奥林匹克公园";
            break;
        case 1:
            result = @"伦敦地区场馆";
            break;
        case 2:
            result = @"其它地区场馆";
            break;
            
        default:
            break;
    }
    return result;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"VenuesCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    UIImage *image = nil;
    UIImageView *imageView = nil;
    switch (indexPath.section) {
        case 0:
            image = [UIImage imageNamed:[NSString stringWithFormat:@"hengfur0c%d",indexPath.row]];
            imageView = [[UIImageView alloc] initWithImage:image];
            break;
        case 1:
            image = [UIImage imageNamed:[NSString stringWithFormat:@"hengfur1c%d",indexPath.row]];
            imageView = [[UIImageView alloc] initWithImage:image];
            break;
        case 2:
            image = [UIImage imageNamed:[NSString stringWithFormat:@"hengfur2c%d",indexPath.row]];
            imageView = [[UIImageView alloc] initWithImage:image];
            break;
        default:
            break;
    }
    imageView.frame = CGRectMake(0, 0, 320, 80);
    
    
   
    NSString *query = [[NSString alloc] initWithFormat:@"select zh_name from venues where row = %d and col = %d;",indexPath.section+1,indexPath.row+1];
    NSArray *venuesArray = [database fetchQuery:query];
    [query release];
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textColor = [UIColor whiteColor];
    label.text = (NSString *)[venuesArray objectAtIndex:0];
    label.frame = CGRectMake(10, 55, 300, 20);
    [imageView addSubview:label];
    [label release];
    
    
    
    [cell addSubview:imageView];
    [imageView release];
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *query = [[NSString alloc] initWithFormat:@"select latitude,longitude from venues where row = %d and col = %d;",indexPath.section+1,indexPath.row+1];
    selectVenuesInfo = [database fetchQuery:query];
    [query release];
    
    exploreolympicAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    MapViewController *mapViewController = [appDelegate.tabBarController.viewControllers objectAtIndex:5];
    CLLocationCoordinate2D coords;
    coords.latitude = [[selectVenuesInfo objectAtIndex:0] floatValue];
    coords.longitude = [[selectVenuesInfo objectAtIndex:1] floatValue];
    MKCoordinateSpan span = MKCoordinateSpanMake(0.002389, 0.005681);
    MKCoordinateRegion region = MKCoordinateRegionMake(coords, span);
    [mapViewController.olympicMap setRegion:region animated:YES];
    
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:coords.latitude longitude:coords.longitude];
    [geocoder  reverseGeocodeLocation: loc completionHandler: 
     ^(NSArray *placemarks, NSError *error) {
         for (CLPlacemark *placemark in placemarks) 
         {
             NSLog(@"name%@", [placemark name]);     
             
             NSLog(@"ISOcountryCode%@", [placemark ISOcountryCode]);     
             
             NSLog(@"administrativeArea%@", [placemark administrativeArea]);     
             
             NSLog(@"subAdministrativeArea%@", [placemark subAdministrativeArea]);     
             
             NSLog(@"subLocality%@", [placemark subLocality]);
             
             NSLog(@"locality%@", [placemark locality]);
             
             NSLog(@"thoroughfare%@", [placemark thoroughfare]);
             
             NSLog(@"subThoroughfare%@", [placemark subThoroughfare]);
             
             NSLog(@"region%@", [placemark region]);
         }
     }];
    MapAnnotations *annotation = [[MapAnnotations alloc] initWithCoordinate:coords];
   
    [mapViewController.olympicMap addAnnotation:annotation];
    [geocoder release];
    [loc release];
    [annotation release];
    
    [mapViewController.popverVenuesController dismissPopoverAnimated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}


@end

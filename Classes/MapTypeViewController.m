//
//  MapTypeViewController.m
//  exploreolympic
//
//  Created by bunny on 12-4-13.
//  Copyright (c) 2012年 iDreamStudio. All rights reserved.
//

#import "MapTypeViewController.h"
#import "MapViewController.h"
#import "define.h"
#import "exploreolympicAppDelegate.h"

@implementation MapTypeViewController
@synthesize mapTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void) dealloc
{
    [super dealloc];
    [mapTableView release];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"地图";
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"标准";
                break;
            case 1:
                cell.textLabel.text = @"卫星";
                break;
            case 2:
                cell.textLabel.text = @"混合";
                break;
            default:
                break;
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        if (indexPath.row == [defaults integerForKey:kMapType]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            cell.textLabel.textColor = [UIColor blueColor];
          
        }
    }
    
    return cell;
}



#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    exploreolympicAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    MapViewController *mapViewController = [appDelegate.tabBarController.viewControllers objectAtIndex:5];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                mapViewController.olympicMap.mapType = MKMapTypeStandard;
                break;
            case 1:
                mapViewController.olympicMap.mapType = MKMapTypeSatellite;
                break;
            case 2:
                mapViewController.olympicMap.mapType = MKMapTypeHybrid;
                break;
                
            default:
                break;
        }
        [defaults setInteger:indexPath.row forKey:kMapType];
        [mapViewController.popverController dismissPopoverAnimated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end

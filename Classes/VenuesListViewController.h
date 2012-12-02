//
//  VenuesListViewController.h
//  exploreolympic
//
//  Created by bunny on 12-4-17.
//  Copyright (c) 2012年 iDreamStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "define.h"
#import "DB.h"
#import "exploreolympicAppDelegate.h"

@interface VenuesListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *venuesTableView;
    NSArray *selectVenuesInfo;
    DB *database;
}

@property (nonatomic ,retain) IBOutlet UITableView *venuesTableView;
@property (nonatomic ,retain) NSArray *selectVenuesInfo;
@end

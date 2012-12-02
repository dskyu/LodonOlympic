//
//  exploreolympicAppDelegate.m
//  exploreolympic
//
//  Created by idream on 12-3-28.
//  Copyright 2012 iDreamStudio. All rights reserved.
//

#import "exploreolympicAppDelegate.h"
#import "MainViewController.h"
#import "NavVenueViewController.h"
#import "GameViewController.h"
#import "ScheduleViewController.h"
#import "RankViewController.h"
#import "MapViewController.h"
#import "StartViewController.h"

@implementation exploreolympicAppDelegate
@synthesize window;
@synthesize tabBarController;
@synthesize database;

#pragma mark -
#pragma mark Application lifecycle


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {   

    database = [[DB alloc] init];
    [self.database createDatabaseIfNeeded:DbFile];
    [self.database openDB];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *mapTypeDefault = [NSDictionary dictionaryWithObject:@"0" forKey:kMapType];
    NSDictionary *mapRoadDefault = [NSDictionary dictionaryWithObject:@"NO" forKey:kMapRoadStatues];
    [defaults registerDefaults:mapTypeDefault];
    [defaults registerDefaults:mapRoadDefault];
    [defaults synchronize];
    
    /*
    if ([defaults boolForKey:kOpeningVideo]) {
        NSURL *myURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"start" ofType:@"mov"]];
        StartViewController *startViewController = [[StartViewController alloc] initWithContentURL:myURL];
        [self.window addSubview:startViewController.view];
        [startViewController release];
    }else {
        [self loadMainView];
    }
    */
    [self loadMainView];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)loadMainView
{
    MainViewController *viewController1 = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    RankViewController *viewController2 = [[RankViewController alloc] initWithNibName:@"RankViewController" bundle:nil];
    NavVenueViewController *viewController3 = [[NavVenueViewController alloc] initWithNibName:@"VenueViewController" bundle:nil];
    GameViewController *viewController4 = [[GameViewController alloc] initWithNibName:@"GameViewController" bundle:nil];
    ScheduleViewController *viewController5 = [[ScheduleViewController alloc] initWithNibName:@"ScheduleViewController" bundle:nil];
    MapViewController *viewController6 = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
    
    self.tabBarController = [[[UITabBarController alloc] init] autorelease];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:viewController1, viewController2, viewController3, viewController4, viewController5, viewController6, nil];
    self.window.rootViewController = self.tabBarController;
    [viewController1 release];
    [viewController2 release];
    [viewController3 release];
    [viewController4 release];
    [viewController5 release];
    [viewController6 release];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:kOpenDelete]) {
        NSString *sql = @"UPDATE schedule SET favorite = 0";
        if ([database execQuery:sql]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"关注信息已经清除"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        [defaults setBool:NO forKey:kOpenDelete];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
	[self.database closeDB];
}


- (void)dealloc {
    [window release];
	[tabBarController release];
    [super dealloc];
}


@end

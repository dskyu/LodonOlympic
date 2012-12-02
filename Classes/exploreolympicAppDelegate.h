//
//  exploreolympicAppDelegate.h
//  exploreolympic
//
//  Created by idream on 12-3-28.
//  Copyright 2012 iDreamStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "StartViewController.h"
#import "DB.h"
#import "define.h"

@interface exploreolympicAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UITabBarController *tabBarController; 
    DB *database;
}


@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UITabBarController *tabBarController;
@property (nonatomic, readwrite, assign) DB *database;

-(void) loadMainView;
@end


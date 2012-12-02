//
//  NavVenueViewController.h
//  exploreolympic
//
//  Created by bunny on 12-4-29.
//  Copyright (c) 2012年 iDreamStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavVenueViewController : UINavigationController<UINavigationControllerDelegate>
{
    UINavigationController *navController;
    NSInteger flagSqueue;
}
@property (nonatomic,retain) UINavigationController *navController;
@property (readwrite) NSInteger flagSqueue;

@end

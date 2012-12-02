//
//  SportIcon.m
//  exploreolympic
//
//  Created by bunny on 12-4-29.
//  Copyright (c) 2012年 iDreamStudio. All rights reserved.
//

#import "SportIcon.h"
#import "VenueViewController.h"
#import "GameViewController.h"
#import "exploreolympicAppDelegate.h"

@implementation SportIcon
@synthesize imageView;
@synthesize sport_id;

- (id) initWithImage:(UIImage *) image
{
    self = [super init];
    if (self) {
        UIImageView *myImageView = [[UIImageView alloc] initWithImage:image];
        myImageView.frame = CGRectMake(0, 0, 42, 42);
        [self addSubview:myImageView];
        self.imageView = myImageView;
        [myImageView release];
    }
    return self;
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    VenueViewController *venueController = [VenueViewController shareController];

    GameViewController *gameViewController = [[GameViewController alloc] initByOtherWithNibName:@"GameViewController" bundle:nil];
    
    [venueController.navigationController pushViewController:gameViewController animated:YES];
    venueController.navigationController.navigationBarHidden = NO;
    venueController.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    venueController.navigationController.navigationBar.backItem.title = @"场馆";
    
    
    gameViewController.nextSportNumber = sport_id - 1;
    gameViewController.flag = 1;
    [gameViewController updateStatues];
    [gameViewController.navScrollView setContentOffset:CGPointMake((sport_id-4)*(15+84), 0) animated:YES];
    gameViewController.videoView.hidden = YES;
    [gameViewController release];

}

- (void) dealloc 
{
    [imageView release];
    [super dealloc];
}
@end

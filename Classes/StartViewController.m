//
//  StartViewController.m
//  exploreolympic
//
//  Created by bunny on 12-5-3.
//  Copyright (c) 2012年 iDreamStudio. All rights reserved.
//

#import "StartViewController.h"

@implementation StartViewController

- (id)initWithContentURL:(NSURL *)contentURL
{
    self = [super initWithContentURL:contentURL];
    if (self) {
        self.moviePlayer.view.frame = CGRectMake(0, 0, 1024, 768);
        
        self.moviePlayer.fullscreen = YES;
        self.moviePlayer.scalingMode = MPMovieScalingModeAspectFill;
        self.moviePlayer.controlStyle = MPMovieControlStyleNone;
        self.moviePlayer.shouldAutoplay = YES;
 
        [self.moviePlayer play];
        
        
        UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
        [self.view addSubview:coverView];
        [coverView release];
        
        UIButton *skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        skipButton.frame = CGRectMake(900, 680, 70, 50);
        [skipButton setImage:[UIImage imageNamed:@"skip.png"] forState:UIControlStateNormal];
        [coverView addSubview:skipButton];
        [skipButton addTarget:self action:@selector(moviePlayBackDidFinish:) forControlEvents:UIControlEventTouchUpInside];
        
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(moviePlayBackDidFinish:) 
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:nil]; 
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void) moviePlayBackDidFinish:(NSNotification*)notification 
{
    exploreolympicAppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app loadMainView];
    [[NSNotificationCenter defaultCenter] removeObserver:self 
                                                    name:MPMoviePlayerPlaybackDidFinishNotification 
                                                  object:nil]; 
    [self.moviePlayer stop];
    [self.moviePlayer.view removeFromSuperview];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void) dealloc
{
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end

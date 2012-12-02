//
//  CustomMoviePlayerViewController.m
//  exploreolympic
//
//  Created by bunny on 12-5-14.
//  Copyright (c) 2012年 iDreamStudio. All rights reserved.
//

#import "CustomMoviePlayerViewController.h" 

#pragma mark - 
#pragma mark Compiler Directives & Static Variables 

@implementation CustomMoviePlayerViewController 

@synthesize movieURL; 
@synthesize timeout;

- (void)viewDidLoad 
{ 
    [super viewDidLoad]; 
    
    loadingAni = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((1024-37)/2, (768-37)/2, 37, 37)]; 
    loadingAni.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge; 
    [self.view addSubview:loadingAni]; 
    
    label = [[UILabel alloc] initWithFrame:CGRectMake((1024-80)/2, (768-40)/2-37, 80, 40)]; 
    label.text = @"加载中..."; 
    label.textColor = [UIColor whiteColor]; 
    label.backgroundColor = [UIColor clearColor]; 
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backBtn setImage:[UIImage imageNamed:@"timeoutBtn.png"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(10, 10, 50, 29);
    [backBtn addTarget:self action:@selector(loadTimeout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];

    
    [[self view] setBackgroundColor:[UIColor blackColor]]; 
    
    [loadingAni startAnimating]; 
    [self.view addSubview:label]; 
    
} 

- (void) loadTimeout
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO]; 
    [self dismissModalViewControllerAnimated:NO]; 
}

- (void) moviePlayerLoadStateChanged:(NSNotification*)notification 
{ 
    [loadingAni stopAnimating]; 
    [label removeFromSuperview]; 
    
    // Unless state is unknown, start playback 
    if ([mp loadState] != MPMovieLoadStateUnknown) 
    { 
        // Remove observer 
        [[NSNotificationCenter defaultCenter] removeObserver:self 
                                                        name:MPMoviePlayerLoadStateDidChangeNotification 
                                                      object:nil]; 
        
        // When tapping movie, status bar will appear, it shows up 
        // in portrait mode by default. Set orientation to landscape 
        //设置横屏 
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES]; 
        // Rotate the view for landscape playback 
        [[self view] setBounds:CGRectMake(0, 0, 1024, 768)]; 
       // [[self view] setCenter:CGPointMake(0, 100)]; 
        //选中当前view 
        
        
        // Set frame of movieplayer 
        [[mp view] setFrame:CGRectMake(0, 0, 1024, 768)]; 
        
        // Add movie player as subview 
        [[self view] addSubview:[mp view]]; 
        
        // Play the movie 
        [mp play]; 
    } 
} 


- (void) moviePlayBackDidFinish:(NSNotification*)notification 
{ 
    //[[UIApplication sharedApplication] setStatusBarHidden:YES]; 
    //还原状态栏为默认状态 
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO]; 
    // Remove observer 
    [[NSNotificationCenter defaultCenter] removeObserver:self 
                                                    name:MPMoviePlayerPlaybackDidFinishNotification 
                                                  object:nil]; 
    
    [self dismissModalViewControllerAnimated:NO]; 
} 


- (void) readyPlayer 
{ 
    mp = [[MPMoviePlayerController alloc] initWithContentURL:movieURL]; 
    
    if ([mp respondsToSelector:@selector(loadState)]) 
    { 
        // Set movie player layout 
        [mp setControlStyle:MPMovieControlStyleFullscreen]; //MPMovieControlStyleFullscreen //MPMovieControlStyleEmbedded 
        //满屏 
        [mp setFullscreen:YES]; 
        // 有助于减少延迟 
        [mp prepareToPlay]; 
        
        // Register that the load state changed (movie is ready) 
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(moviePlayerLoadStateChanged:) 
                                                     name:MPMoviePlayerLoadStateDidChangeNotification 
                                                   object:nil]; 
    } 
    else 
    { 
        // Play the movie For 3.1.x devices 
        [mp play]; 
    } 
    
    // Register to receive a notification when the movie has finished playing. 
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(moviePlayBackDidFinish:) 
                                                 name:MPMoviePlayerPlaybackDidFinishNotification 
                                               object:nil]; 
} 
     
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void)dealloc 
{ 
    [mp release]; 
    [movieURL release]; 
    [loadingAni release]; 
    [label release]; 
    
    [super dealloc]; 
} 

@end 
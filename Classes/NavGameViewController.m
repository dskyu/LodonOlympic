//
//  NavGameViewController.m
//  exploreolympic
//
//  Created by bunny on 12-5-3.
//  Copyright (c) 2012年 iDreamStudio. All rights reserved.
//

#import "NavGameViewController.h"
#import "GameViewController.h"

@implementation NavGameViewController
@synthesize navController;
@synthesize flagSqueue;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = NSLocalizedString(@"运动项目",@"tabItem3Title");
        self.tabBarItem.image = [UIImage imageNamed:@"game.png"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    GameViewController *mainController = [[GameViewController alloc] initWithNibName:@"GameViewController" bundle:nil];
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mainController];
    [mainController release];
	self.navController = nav;
    [nav release];
    
    flagSqueue = 0;
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];  
    if (version >= 5.0)  
    {  
        self.view.bounds = CGRectMake(0, -20, 768, 1024);
    }else {
        self.view.bounds = CGRectMake(0, 0, 768, 1024);
    }
    
    self.navController.delegate = self;
    self.navController.navigationBarHidden = YES;
	
	[self.view addSubview:self.navController.view];
    
}

-(void)viewWillAppear:(BOOL)animated 
{   
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];  
    if (version < 5.0 && flagSqueue)  
    { 
        self.view.bounds = CGRectMake(0, -20, 768, 1024);
    }
    [super viewWillAppear:animated];     
    
} 

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    flagSqueue = 1;

}

- (void)viewDidUnload
{
    [super viewDidUnload];
}


- (void) dealloc
{
    [navController release];
    [super dealloc];
}

#pragma mark -
#pragma mark navViewController Delegate
-(void) navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	[viewController viewWillAppear:animated];
    
}

-(void) navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	[viewController viewDidAppear:animated];
}

@end

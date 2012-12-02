//
//  NavIcon.m
//  exploreolympic
//
//  Created by bunny on 12-4-1.
//  Copyright (c) 2012年 iDreamStudio. All rights reserved.
//

#import "NavIcon.h"
#import "MainViewController.h"
#import "exploreolympicAppDelegate.h"
#import "CustomMoviePlayerViewController.h"

@implementation NavIcon


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = (UITouch *)[touches anyObject];
    CGPoint point = [touch locationInView:self];
    MainViewController *mainController = [MainViewController shareController];
    
    if (!mainController.canBeTouched) {
        return ;
    }
    
    mainController.canBeTouched = NO;
    
 
    if (point.x > 138 && point.y < 144) {
       
        NSString *str = @"";
        
        switch (col) {
            case 0:
                str = @"history";
                break;
            case 1:
                str = @"mascot";
                break;
            case 2:
                str = @"london";
                break;    
        }
        
        NSURL *myURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:str ofType:@"mov"]];
        
        CustomMoviePlayerViewController *moviePlayer = [[[CustomMoviePlayerViewController alloc] init] autorelease]; 
        moviePlayer.movieURL = myURL;
        [moviePlayer readyPlayer]; 
        [mainController presentViewController:moviePlayer animated:YES completion:nil]; 
        
        
    }
    mainController.canBeTouched = YES;
}

- (void) dealloc 
{
    [super dealloc];
}



@end

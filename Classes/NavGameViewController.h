//
//  NavGameViewController.h
//  exploreolympic
//
//  Created by bunny on 12-5-3.
//  Copyright (c) 2012年 iDreamStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavGameViewController : UINavigationController<UINavigationControllerDelegate>
{
    UINavigationController *navController;
    NSInteger flagSqueue;
}
@property (nonatomic,retain) UINavigationController *navController;
@property (readwrite) NSInteger flagSqueue;

@end

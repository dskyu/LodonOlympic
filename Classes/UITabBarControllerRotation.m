//
//  UITabBarControllerRotation.m
//  exploreolympic
//
//  Created by idream on 12-3-28.
//  Copyright 2012 iDreamStudio. All rights reserved.
//

#import "UITabBarControllerRotation.h"


@implementation UITabBarController(Rotation)

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
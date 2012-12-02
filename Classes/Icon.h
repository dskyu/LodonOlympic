//
//  Icon.h
//  exploreolympic
//
//  Created by bunny on 12-4-1.
//  Copyright (c) 2012年 iDreamStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconDelegate.h"

@interface Icon : UIView
{
    NSInteger row;
    NSInteger col;
}

@property  (readwrite) NSInteger row;
@property  (readwrite) NSInteger col;

@end

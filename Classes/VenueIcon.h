//
//  VenueIcon.h
//  exploreolympic
//
//  Created by bunny on 12-3-30.
//  Copyright (c) 2012年 iDreamStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Icon.h"

@interface VenueIcon : Icon 
{
    id <IconDelegate> delegate; 
}

@property(nonatomic,retain) id <IconDelegate> delegate;
@end

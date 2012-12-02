//
//  SportIcon.h
//  exploreolympic
//
//  Created by bunny on 12-4-29.
//  Copyright (c) 2012年 iDreamStudio. All rights reserved.
//

#import "Icon.h"

@interface SportIcon : Icon
{
    UIImageView *imageView;
    NSInteger sport_id;
}
@property (nonatomic ,retain) UIImageView *imageView;
@property (readwrite)  NSInteger sport_id;
- (id) initWithImage:(UIImage *) image;
@end

//
//  CustomDetailTableCell.m
//  exploreolympic
//
//  Created by bunny on 12-4-15.
//  Copyright (c) 2012年 iDreamStudio. All rights reserved.
//

#import "CustomDetailTableCell.h"

@implementation CustomDetailTableCell

@synthesize dataArray;
@synthesize sportImageView,medalButton,sportTitleLabel,beijingTimeLabel,londonTimeLabel,contentLabel,venuesLabel;
@synthesize favoriteButton;
@synthesize midline,underline,underline2;
@synthesize sportImageView2,medalButton2,sportTitleLabel2,beijingTimeLabel2,londonTimeLabel2,contentLabel2,venuesLabel2;
@synthesize favoriteButton2;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void) dealloc
{
    [super dealloc];
    [dataArray release];
    [sportImageView release];
    [medalButton release];
    [sportTitleLabel release];
    [beijingTimeLabel release];
    [londonTimeLabel release];
    [contentLabel release];
    [venuesLabel release];
    [favoriteButton release];
    
    [midline release];
    [underline release];
    [underline2 release];
    
    [sportImageView2 release];
    [medalButton2 release];
    [sportTitleLabel2 release];
    [beijingTimeLabel2 release];
    [londonTimeLabel2 release];
    [contentLabel2 release];
    [venuesLabel2 release];
    [favoriteButton2 release];
}
@end

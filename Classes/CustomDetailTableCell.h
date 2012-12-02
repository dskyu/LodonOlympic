//
//  CustomDetailTableCell.h
//  exploreolympic
//
//  Created by bunny on 12-4-15.
//  Copyright (c) 2012年 iDreamStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomDetailTableCell : UITableViewCell
{
    NSArray *dataArray;
    
    UIImageView *sportImageView;
    UIButton *medalButton;
    UILabel *sportTitleLabel;
    UILabel *londonTimeLabel;
    UILabel *beijingTimeLabel;
    UILabel *contentLabel;
    UILabel *venuesLabel;
    UIButton *favoriteButton;
    
    UIImageView *midline;
    UIImageView *underline;
    UIImageView *underline2;
    
    UIImageView *sportImageView2;
    UIButton *medalButton2;
    UILabel *sportTitleLabel2;
    UILabel *londonTimeLabel2;
    UILabel *beijingTimeLabel2;
    UILabel *contentLabel2;
    UILabel *venuesLabel2;
    UIButton *favoriteButton2;
}
@property (nonatomic,retain) NSArray *dataArray;
@property (nonatomic,retain) IBOutlet UIImageView *sportImageView;
@property (nonatomic,retain) IBOutlet UIButton *medalButton;
@property (nonatomic,retain) IBOutlet UILabel *sportTitleLabel;
@property (nonatomic,retain) IBOutlet UILabel *londonTimeLabel;
@property (nonatomic,retain) IBOutlet UILabel *beijingTimeLabel;
@property (nonatomic,retain) IBOutlet UILabel *contentLabel;
@property (nonatomic,retain) IBOutlet UILabel *venuesLabel;
@property (nonatomic,retain) IBOutlet UIButton *favoriteButton;

@property (nonatomic,retain) IBOutlet UIImageView *midline;;
@property (nonatomic,retain) IBOutlet UIImageView *underline;;
@property (nonatomic,retain) IBOutlet UIImageView *underline2;;

@property (nonatomic,retain) IBOutlet UIImageView *sportImageView2;
@property (nonatomic,retain) IBOutlet UIButton *medalButton2;
@property (nonatomic,retain) IBOutlet UILabel *sportTitleLabel2;
@property (nonatomic,retain) IBOutlet UILabel *londonTimeLabel2;
@property (nonatomic,retain) IBOutlet UILabel *beijingTimeLabel2;
@property (nonatomic,retain) IBOutlet UILabel *contentLabel2;
@property (nonatomic,retain) IBOutlet UILabel *venuesLabel2;
@property (nonatomic,retain) IBOutlet UIButton *favoriteButton2;

@end

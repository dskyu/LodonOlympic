//
//  VenueViewController.h
//  exploreolympic
//
//  Created by bunny on 12-3-28.
//  Copyright (c) 2012年 iDreamStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "exploreolympicAppDelegate.h"
#import "define.h"
#import <QuartzCore/QuartzCore.h>
#import "VenueIcon.h"
#import "IconDelegate.h"
#import "OlmpicPageControl.h"

@interface VenueViewController : UIViewController <IconDelegate> {
    NSMutableArray *bannerImageViewArray;
    NSMutableArray *parkImageViewArray;
    NSMutableArray *londonvenuesImageViewArray;
    NSMutableArray *othervenuesImageViewArray;
    UIImageView *parkImageView;
    UIImageView *londonvenuesImageView;
    UIImageView *othervenuesImageView;
    UIView *parkView;
    UIView *londonView;
    UIView *othervenuesView;
    UIScrollView *bannerScrollView;
    UIScrollView *parkScrollView;
    UIScrollView *londonvenuesScrollView;
    UIScrollView *othervenuesScrollView;
    VenueIcon *backIcon1;
    VenueIcon *backIcon2;
    VenueIcon *backIcon3;
    
    UIImageView *lineView1;
    UIImageView *lineView2;
    UIImageView *lineView3;
    
    UIImageView *logotitleImageView;
    
    UIScrollView *imageScrollView;
    UIPageControl *imagePageControl;
    NSArray *imageArray;
    
    NSMutableDictionary *Section1ContentDic;
    NSMutableDictionary *Section2ContentDic;
    
    NSInteger currentRow;
    NSInteger currentCol;
    NSInteger nextRow;
    NSInteger nextCol;
    
    DB *database;
    
    NSMutableString *preHtmlString;
    
    BOOL canBeTouched;
}

@property (nonatomic,retain) IBOutlet UIImageView *lineView1;
@property (nonatomic,retain) IBOutlet UIImageView *lineView2;
@property (nonatomic,retain) IBOutlet UIImageView *lineView3;
@property (nonatomic,retain) IBOutlet UIImageView *logotitleImageView;
@property (nonatomic,retain) NSMutableArray *bannerImageViewArray;
@property (nonatomic,retain) NSMutableArray *parkImageViewArray;
@property (nonatomic,retain) NSMutableArray *londonvenuesImageViewArray;
@property (nonatomic,retain) NSMutableArray *othervenuesImageViewArray;
@property (nonatomic,retain) IBOutlet UIImageView *parkImageView;
@property (nonatomic,retain) IBOutlet UIImageView *londonvenuesImageView;
@property (nonatomic,retain) IBOutlet UIImageView *othervenuesImageView;
@property (nonatomic,retain) IBOutlet UIView *parkView;
@property (nonatomic,retain) IBOutlet UIView *londonView;
@property (nonatomic,retain) IBOutlet UIView *othervenuesView;
@property (nonatomic,retain) IBOutlet UIScrollView *parkScrollView;
@property (nonatomic,retain) IBOutlet UIScrollView *londonvenuesScrollView;
@property (nonatomic,retain) IBOutlet UIScrollView *othervenuesScrollView;
@property (nonatomic,retain) VenueIcon *backIcon1;
@property (nonatomic,retain) VenueIcon *backIcon2;
@property (nonatomic,retain) VenueIcon *backIcon3;
@property (nonatomic,retain) IBOutlet UIScrollView *bannerScrollView;

@property (nonatomic ,retain) UIScrollView *imageScrollView;
@property (nonatomic ,retain) UIPageControl *imagePageControl;
@property (nonatomic ,retain) NSArray *imageArray;

@property (nonatomic ,retain) NSMutableDictionary *Section1ContentDic;
@property (nonatomic ,retain) NSMutableDictionary *Section2ContentDic;

@property (readwrite) NSInteger currentRow;
@property (readwrite) NSInteger currentCol;
@property (readwrite) NSInteger nextRow;
@property (readwrite) NSInteger nextCol;

@property (nonatomic ,retain) NSMutableString *preHtmlString;
@property (readwrite) BOOL canBetouched;

+(VenueViewController *) shareController;
@end

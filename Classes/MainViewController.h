//
//  MainViewController.h
//  exploreolympic
//
//  Created by idream on 12-3-28.
//  Copyright 2012 iDreamStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "define.h"
#import <QuartzCore/QuartzCore.h>

@interface MainViewController : UIViewController<UITabBarControllerDelegate,UIScrollViewDelegate>
{  
    UIImageView *background2;
    UIScrollView *countDownView;
    NSMutableArray *imageArray;
    NSInteger flagSqueue;
    
    int index;
    CATransition *transition;
    UIImageView *logoImageView;
    UIScrollView *imageScrollView;
    UIPageControl *imagePageControl;
    NSArray *eventArray;
    
    UIImageView *day1;
    UIImageView *day2;
    UIImageView *day3;
    UIImageView *hour1;
    UIImageView *hour2;
    UIImageView *min1;
    UIImageView *min2;
    UIImageView *sec1;
    UIImageView *sec2;
    NSArray *numberArray;
    
    
    UIImageView *logoImage1;
    UIImageView *logoImage2;
    UIImageView *logoImage3;
    UIImageView *logoImage4;
    UIImageView *logoImage5;
    UIImageView *logoImage6;
    UIImageView *logoImage7;
    UIImageView *logoImage8;
    UIImageView *logoImage9;
    UIImageView *logoImage10;
    UIImageView *logoImage11;
    UIImageView *logoImage12;
    UIImageView *logoImage13;
    UIImageView *logoImage14;
    UIImageView *logoImage15;
    UIImageView *logoImage16;
    UIImageView *logoImage17;
    UIImageView *logoImage18;
    UIImageView *logoImage19;
    UIImageView *logoImage20;
    UIImageView *logoImage21;
    UIImageView *logoImage22;
    UIImageView *logoImage23;
    UIImageView *logoImage24;
    UIImageView *logoImage25;
    UIImageView *logoImage26;
    UIImageView *logoImage27;
    UIImageView *logoImage28;
    UIImageView *logoImage29;
    UIImageView *logoImage30;
    UIImageView *logoImage31;
    UIImageView *logoImage32;
    UIImageView *logoImage33;
    UIImageView *logoImage34;
    UIImageView *logoImage35;
    UIImageView *logoImage36;
    UIImageView *logoImage37;
    UIImageView *logoImage38;
    UIImageView *logoImage39;
    UIImageView *logoImage40;
    UIImageView *logoImage41;
    UIImageView *logoImage42;
    UIImageView *logoImage43;
    UIImageView *logoImage44;
    UIImageView *logoImage45;
    UIImageView *logoImage46;
    UIImageView *logoImage47;
    UIImageView *logoImage48;
    UIImageView *logoImage49;
    UIImageView *logoImage50;
    UIImageView *logoImage51;
    UIImageView *logoImage52;
    UIImageView *logoImage53;
    UIImageView *logoImage54;
    UIImageView *logoImage55;
    UIImageView *logoImage56;
    UIImageView *logoImage57;
    UIImageView *logoImage58;
    UIImageView *logoImage59;
    UIImageView *logoImage60;
    
    BOOL canBeTouched;

}
@property (readwrite) NSInteger flagSqueue;

@property (nonatomic,retain) IBOutlet UIImageView *background2;
@property (nonatomic,retain) IBOutlet UIScrollView *countDownView;
@property (nonatomic,retain) UIPageControl *imagePageControl;
@property (nonatomic,retain) UIScrollView *imageScrollView;
@property (nonatomic,retain) UIImageView *logoImageView;
@property (nonatomic,retain) NSArray *eventArray;
@property (nonatomic,retain) NSMutableArray *imageArray;
@property (nonatomic,retain) CATransition *transition;
@property (nonatomic,retain) IBOutlet UIImageView *day1;
@property (nonatomic,retain) IBOutlet UIImageView *day2;
@property (nonatomic,retain) IBOutlet UIImageView *day3;
@property (nonatomic,retain) IBOutlet UIImageView *hour1;
@property (nonatomic,retain) IBOutlet UIImageView *hour2;
@property (nonatomic,retain) IBOutlet UIImageView *min1;
@property (nonatomic,retain) IBOutlet UIImageView *min2;
@property (nonatomic,retain) IBOutlet UIImageView *sec1;
@property (nonatomic,retain) IBOutlet UIImageView *sec2;
@property (nonatomic,retain) NSArray *numberArray;
@property int index;
@property BOOL canBeTouched;

@property (nonatomic,retain) IBOutlet UIImageView *logoImage1;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage2;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage3;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage4;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage5;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage6;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage7;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage8;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage9;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage10;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage11;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage12;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage13;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage14;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage15;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage16;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage17;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage18;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage19;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage20;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage21;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage22;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage23;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage24;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage25;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage26;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage27;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage28;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage29;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage30;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage31;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage32;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage33;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage34;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage35;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage36;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage37;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage38;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage39;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage40;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage41;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage42;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage43;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage44;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage45;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage46;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage47;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage48;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage49;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage50;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage51;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage52;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage53;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage54;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage55;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage56;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage57;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage58;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage59;
@property (nonatomic,retain) IBOutlet UIImageView *logoImage60;


+(MainViewController *) shareController;

@end

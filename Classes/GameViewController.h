//
//  GameViewController.h
//  exploreolympic
//
//  Created by bunny on 12-3-28.
//  Copyright (c) 2012年 iDreamStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "exploreolympicAppDelegate.h"
#import "GameIcon.h"
#import "define.h"
#import "OlmpicPageControl.h"

@interface GameViewController : UIViewController<IconDelegate>
{
    UIImageView *bannerImageView;
    UIImageView *titleImageView;
    UIImageView *smallIcon;
    UIImageView *background;
    UIView *navView;
    UIScrollView *navScrollView;
    
    NSMutableArray *iconImageArray;
    
    DB *database;
    NSMutableString *preHtmlString;
    UIView *webView;
    OlmpicPageControl *webPageControl;
    UIWebView *webView1;
    UIWebView *webView2;
    UIWebView *webView3;
    
    NSInteger currSportNumber;
    NSInteger nextSportNumber;
    
    UIView *viewLeft;
    UILabel *dateText;
    UILabel *venuesText;
    UILabel *totalText;
    
    UIImageView *point;
    NSInteger flag;
    
    UIView *videoView;
    UIImageView *videoBack;
    UIButton *videoFront;
    NSMutableString *url;
}

@property (nonatomic,retain) IBOutlet UIImageView *videoBack;
@property (nonatomic,retain) IBOutlet UIButton *videoFront;
@property (nonatomic,retain) IBOutlet UIView *videoView;
@property (nonatomic,retain) NSMutableString *url;

@property (nonatomic,retain) IBOutlet UIImageView *bannerImageView;
@property (nonatomic,retain) IBOutlet UIImageView *titleImageView;
@property (nonatomic,retain) IBOutlet UIImageView *smallIcon;
@property (nonatomic,retain) IBOutlet UIImageView *background;
@property (nonatomic,retain) IBOutlet UIView *navView;
@property (nonatomic,retain) IBOutlet UIScrollView *navScrollView;

@property (nonatomic,retain) OlmpicPageControl *webPageControl;
@property (nonatomic,retain) UIWebView *webView1;
@property (nonatomic,retain) UIWebView *webView2;
@property (nonatomic,retain) UIWebView *webView3;
@property (nonatomic,retain) NSMutableArray *iconImageArray;
@property (nonatomic,retain) NSMutableString *preHtmlString;
@property (nonatomic,retain) IBOutlet UIView *webView;
@property (readwrite) NSInteger nextSportNumber;
@property (readwrite) NSInteger currSportNumber;

@property (nonatomic,retain) IBOutlet UIView *viewLeft;
@property (nonatomic,retain) IBOutlet UILabel *dateText;
@property (nonatomic,retain) IBOutlet UILabel *venuesText;
@property (nonatomic,retain) IBOutlet UILabel *totalText;
@property (nonatomic,retain) IBOutlet UIImageView *point;
@property (readwrite) NSInteger flag;

- (IBAction)playVideo:(id) sender;
-(void) updateStatues;
- (id)initByOtherWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
+(GameViewController *) shareController;
@end

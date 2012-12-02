//
//  GameViewController.m
//  exploreolympic
//
//  Created by bunny on 12-3-28.
//  Copyright (c) 2012年 iDreamStudio. All rights reserved.
//

#import "GameViewController.h"
#import "OlmpicPageControl.h"
#import "MapViewController.h"
#import "VenuesListViewController.h"
#import "CustomMoviePlayerViewController.h"

GameViewController *thisController;

@implementation GameViewController
@synthesize webPageControl;
@synthesize bannerImageView;
@synthesize titleImageView;
@synthesize smallIcon;
@synthesize background;
@synthesize navView;
@synthesize navScrollView;
@synthesize iconImageArray;
@synthesize preHtmlString;
@synthesize webView;
@synthesize nextSportNumber,currSportNumber;
@synthesize viewLeft,venuesText,dateText,totalText;
@synthesize point;
@synthesize flag;
@synthesize webView1,webView2,webView3;
@synthesize videoBack,videoFront,videoView;
@synthesize url;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = NSLocalizedString(@"运动项目",@"tabItem3Title");
        self.tabBarItem.image = [UIImage imageNamed:@"game.png"];
    }
    thisController = self;
    return self;
}

- (id)initByOtherWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}


+(GameViewController *) shareController
{
    return thisController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    exploreolympicAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    database = appDelegate.database;
    
    flag = 0;
    currSportNumber = -1;
    nextSportNumber = 0;
    int sum = SportNumber;
    int interval = 15;
    
    
    NSMutableArray *array1 = [[NSMutableArray alloc] initWithCapacity:sum];
    self.iconImageArray = array1;
    [array1 release];

    
    self.navScrollView.contentSize = CGSizeMake(interval+(interval+84)*sum, 115);
    self.navScrollView.showsHorizontalScrollIndicator = NO;
    UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PlaceTouched:)];  
    singleFingerOne.numberOfTouchesRequired = 1; 
    singleFingerOne.numberOfTapsRequired = 1; 
    [self.venuesText addGestureRecognizer:singleFingerOne];
    [singleFingerOne release];
    
    for (int i=0; i<sum; i++) {
        GameIcon *gameIcon = [[GameIcon alloc] init];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"sport%d.png",i]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
        gameIcon.col = i; 
        gameIcon.row = 0;
        gameIcon.delegate = self;
        [gameIcon addSubview:imageView];
        gameIcon.frame  = CGRectMake(interval+(interval+84)*i, 25, 84, 84);
        
        [navScrollView addSubview:gameIcon];
        [iconImageArray addObject:gameIcon];
        [gameIcon release];
        [imageView release];
    }
    point.frame = CGRectMake(interval-8, 25-8, 100, 100);
    
    NSMutableString *urlstring = [[NSMutableString alloc] initWithCapacity:200];
    self.url = urlstring;
    [urlstring release];

    NSMutableString *str = [[NSMutableString alloc] initWithString:@"<head><style> .title{margin:8px;font-size:30px;font-weight:bold}  .title1{margin:5px;font-size:24px;font-weight:bold} .title2{margin:3px;font-size:20px;font-weight:bold} p{margin:5px} </style></head><body style=\"background-color:#0085a1;color:#FFFFFF;font-size:20px;word-spacing: -2px;text-indent: 2em;\"></body>"];
    self.preHtmlString = str;
    [str release];
    
    CGRect contentFrame = [webView frame];
    
    float fWidth = contentFrame.size.width;
    float fHeight = contentFrame.size.height;
    
    
    UIScrollView *aScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, fWidth, fHeight)];
    [aScrollView setContentSize:CGSizeMake(fWidth*3, fHeight)];
    
    OlmpicPageControl *aPageControl = [[OlmpicPageControl alloc] initWithFrame:CGRectMake(0, 0, fWidth, fHeight*2) AndScrollView:aScrollView];   
    [aScrollView release];
    
    aPageControl.backgroundColor = [UIColor clearColor];   
    aPageControl.numberOfPages = 3;   
    aPageControl.currentPage = 0;      
    
    [webView addSubview:aPageControl];   
    self.webPageControl = aPageControl;
    [aPageControl release];
    
    
    UIImage *htmltitle1 = [UIImage imageNamed:@"gtitle1.png"];
    UIImage *htmltitle2 = [UIImage imageNamed:@"gtitle2.png"];
    UIImage *htmltitle3 = [UIImage imageNamed:@"gtitle3.png"];
    UIImageView *htmlView1 = [[UIImageView alloc] initWithImage:htmltitle1];
    UIImageView *htmlView2 = [[UIImageView alloc] initWithImage:htmltitle2];
    UIImageView *htmlView3 = [[UIImageView alloc] initWithImage:htmltitle3];
    htmlView1.frame = CGRectMake(40, 5, 72, 16);
    htmlView2.frame = CGRectMake(fWidth+40, 5, 72, 16);
    htmlView3.frame = CGRectMake(2*fWidth+40, 5, 72, 16);
    [aScrollView addSubview:htmlView1];
    [aScrollView addSubview:htmlView2];
    [aScrollView addSubview:htmlView3];
    [htmlView1 release];
    [htmlView2 release];
    [htmlView3 release];
    
    UIWebView *web1 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 30, fWidth, fHeight-40)];
    self.webView1 = web1;
    [web1 release];
    webView1.backgroundColor = [UIColor clearColor];
    webView1.scalesPageToFit = YES;
    webView1.multipleTouchEnabled = YES;
    [webView1 loadHTMLString:preHtmlString baseURL:nil];
    [aScrollView addSubview:webView1];
    
    
    UIWebView *web2 = [[UIWebView alloc] initWithFrame:CGRectMake(fWidth, 30, fWidth, fHeight-40)];
    self.webView2 = web2;
    [web2 release];
    webView2.backgroundColor = [UIColor clearColor];
    webView2.scalesPageToFit = YES;
    webView2.multipleTouchEnabled = YES;
    [webView2 loadHTMLString:preHtmlString baseURL:nil];
    [aScrollView addSubview:webView2];

    
    UIWebView *web3 = [[UIWebView alloc] initWithFrame:CGRectMake(fWidth*2, 30, fWidth, fHeight-40)];
    self.webView3 = web3;
    [web3 release];
    webView3.backgroundColor = [UIColor clearColor];
    webView3.scalesPageToFit = YES;
    webView3.multipleTouchEnabled = YES;
    [webView3 loadHTMLString:preHtmlString baseURL:nil];
    [aScrollView addSubview:webView3];

    viewLeft.alpha = 0;
    bannerImageView.alpha = 0;
    
    videoBack.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showVideoView:)];
    [videoBack addGestureRecognizer:tapGesture1];
    [tapGesture1 release];
        
    UISwipeGestureRecognizer *swipeGesture1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(showVideoView:)];
    [swipeGesture1 setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.videoView addGestureRecognizer:swipeGesture1];
    [swipeGesture1 release];
    
    UISwipeGestureRecognizer *swipeGesture2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(hideVideoView:)];
    [swipeGesture2 setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.videoView addGestureRecognizer:swipeGesture2];
    [swipeGesture2 release];
    
    [self updateStatues];
}

- (void) showVideoView:(id) sender
{
    [UIView animateWithDuration:SportVideoSwitchDuration 
                     animations:^{
                         videoView.frame = SportVideoFrameShow;
                     }completion:^(BOOL finished){
                         
                     }];
    NSString *host = kHostAddress;
    [url setString:[NSString stringWithFormat:@"%@/video%d.mov",host,nextSportNumber]];
  
    NSURL *u = [NSURL URLWithString:url];
    MPMoviePlayerController *player = [[MPMoviePlayerController alloc] initWithContentURL:u];
    UIImage *thumbnail = [player thumbnailImageAtTime:0 timeOption:MPMovieTimeOptionNearestKeyFrame];
    [player stop];
    [player release];
    if (thumbnail) {
        [videoFront setBackgroundImage:thumbnail forState:UIControlStateNormal];
    }else {
        [videoFront setBackgroundImage:[UIImage imageNamed:@"shipin2.png"] forState:UIControlStateNormal];
    }
}

- (void) hideVideoView:(id) sender
{
    [UIView animateWithDuration:SportVideoSwitchDuration 
                     animations:^{
                         videoView.frame = SportVideoFrameHide;
                     }completion:^(BOOL finished){
                         
                     }];
}

- (IBAction)playVideo:(id)sender
{
    CustomMoviePlayerViewController *moviePlayer = [[[CustomMoviePlayerViewController alloc] init] autorelease]; 
    moviePlayer.movieURL = [NSURL URLWithString:url];
    [moviePlayer readyPlayer]; 
    [self presentViewController:moviePlayer animated:YES completion:nil]; 
}

- (void)viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:animated];
    if ([self.navigationController.viewControllers count] != 2) {
        self.navigationController.navigationBarHidden = YES;
    }
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void) PlaceTouched:(id) sender
{

}


- (void) dealloc
{
    [super dealloc];
    [bannerImageView release];
    [background  release];
    [navView release];
    [navScrollView release];
    [iconImageArray release];
    [titleImageView release];
    [smallIcon release];
    [preHtmlString release];
    [webView release];
    [viewLeft release];
    [venuesText release];
    [dateText release];
    [totalText release];
    [point release];
    [webView1 release];
    [webView2 release];
    [webView3 release];
    [videoView release];
    [videoFront release];
    [videoBack release];
    [webPageControl release];
    [url release];
}


- (void)updateStatues
{

    [self hideVideoView:nil];
    [UIView animateWithDuration:SportContentSwitchDuration
                     animations:^{
                         [webPageControl setCurrentPage:0];
                         [webPageControl.aScrollView setContentOffset:CGPointMake(0, 0)];
                         viewLeft.frame = SportLeftViewFrameOut;
                         viewLeft.alpha = 0;
                         bannerImageView.frame = SportRightViewFrameOut;
                         bannerImageView.alpha = 0;
                         point.frame = CGRectMake(7+(15+84)*nextSportNumber, 25-8, 100, 100);
                         if (flag) {
                             [self.navScrollView setContentOffset:CGPointMake((nextSportNumber-3)*(25+84), 0) animated:YES];
                             flag = 0;
                         }
                     }
                     completion:^(BOOL finished){
                         [self leftContentSwitch];
                         [self RightContentSwitch];
                         [UIView animateWithDuration:SportContentSwitchDuration 
                                          animations:^{
                                              viewLeft.frame = SportLeftViewFrameIn;
                                              viewLeft.alpha = 1;
                                              bannerImageView.frame = SportRightViewFrameIn;
                                              bannerImageView.alpha = 1;
                                          }completion:^(BOOL finished){
                                              
                                          }];
                     }];
    currSportNumber = nextSportNumber;
    
    

}

-(void) leftContentSwitch
{
    UIImage *image1 = [UIImage imageNamed:[NSString stringWithFormat:@"sporttitle%d.png",nextSportNumber]];
    self.titleImageView.image = image1;
    
    UIImage *image3 = [UIImage imageNamed:[NSString stringWithFormat:@"sport%d.png",nextSportNumber]];
    self.smallIcon.image = image3;
    
    NSArray *dataArray = [self fetchData:nextSportNumber];
    NSString *datastring = [dataArray objectAtIndex:3];
    NSArray *htmlArray = [datastring componentsSeparatedByString:@"_"];
    
    NSMutableString *content = [[NSMutableString alloc] initWithCapacity:2000];
    [content setString:preHtmlString ];
    [content insertString:[htmlArray objectAtIndex:0] atIndex:[content rangeOfString:@"</body>"].location];
    [webView1 loadHTMLString:content baseURL:nil];
    [content release];
    
    NSMutableString *content1 = [[NSMutableString alloc] initWithCapacity:2000];
    [content1 setString:preHtmlString ];
    [content1 insertString:[htmlArray objectAtIndex:1] atIndex:[content1 rangeOfString:@"</body>"].location];
    [webView2 loadHTMLString:content1 baseURL:nil];
    [content1 release];
    
    NSMutableString *content2 = [[NSMutableString alloc] initWithCapacity:2000];
    [content2 setString:preHtmlString ];
    [content2 insertString:[htmlArray objectAtIndex:2] atIndex:[content2 rangeOfString:@"</body>"].location];
    [webView3 loadHTMLString:content2 baseURL:nil];
    [content2 release];
    
    
    NSString *date = [[NSString alloc] initWithFormat:@"%@-%@",[dataArray objectAtIndex:0],[dataArray objectAtIndex:1]];
    dateText.text = date;
    [date release];
    
    NSString *text = [[NSString alloc] initWithFormat:@"%@ ",[dataArray objectAtIndex:2]];
    venuesText.text = text;
    [text release];
    
    NSString *total = [[NSString alloc] initWithFormat:@"%@枚",[dataArray objectAtIndex:5]];
    totalText.text = total;
    [total release];
}

-(void) RightContentSwitch
{
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"banner%d.png",nextSportNumber]];
    self.bannerImageView.image = image;
}

#pragma mark -
#pragma mark icon delegate

- (void) tapIcon:(id) sender
{
    GameIcon *icon = (GameIcon *) sender;
    nextSportNumber = icon.col;
    if (nextSportNumber != currSportNumber) {
        [self updateStatues];
    }
    
}

-(NSArray *) fetchData:(NSInteger )i
{
    NSString *str = [[[NSString alloc] initWithFormat:@"SELECT time_begin,time_end,venues,description,venues_id,total FROM sport where id = %d;",i+1] autorelease];
    return [database fetchQuery:str];
}


@end

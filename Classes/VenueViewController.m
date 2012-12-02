//
//  VenueViewController.m
//  exploreolympic
//
//  Created by bunny on 12-3-28.
//  Copyright (c) 2012年 iDreamStudio. All rights reserved.
//

#import "VenueViewController.h"
#import "VenueIcon.h"
#import "SportIcon.h"
#import "MapViewController.h"

static VenueViewController *thisController;

@implementation VenueViewController

@synthesize logotitleImageView;
@synthesize bannerImageViewArray;
@synthesize parkImageViewArray;
@synthesize londonvenuesImageViewArray;
@synthesize othervenuesImageViewArray;
@synthesize parkImageView;
@synthesize londonvenuesImageView;
@synthesize othervenuesImageView;
@synthesize parkScrollView;
@synthesize londonvenuesScrollView;
@synthesize othervenuesScrollView;
@synthesize parkView;
@synthesize londonView;
@synthesize othervenuesView;
@synthesize bannerScrollView;
@synthesize backIcon1,backIcon2,backIcon3;
@synthesize imageScrollView;
@synthesize imageArray;
@synthesize imagePageControl;
@synthesize Section1ContentDic,Section2ContentDic;
@synthesize currentCol,currentRow,nextCol,nextRow;
@synthesize preHtmlString;
@synthesize canBetouched;
@synthesize lineView1,lineView2,lineView3;

const static int flag[3][13] = {{1,2,1,2,1,2,1,2,1,2,1,2,1},
    {1,2,1,2,1,2,1,2,1,2,1,2,1},
    {1,2,1,2,1,2,1,2,1,2,1,2,1}};

+(VenueViewController *) shareController
{
    return thisController;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = NSLocalizedString(@"场馆",@"tabItem2Title");
        self.tabBarItem.image = [UIImage imageNamed:@"venue.png"];
    }
    thisController = self;
    return self;
}


- (void) viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    exploreolympicAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    database = appDelegate.database;
    
    int const sum1 = VenueRow0Number;
    int const sum2 = VenueRow1Number;
    int const sum3 = VenueRow2Number;
    int const conut = sum1+sum2+sum3;
    
    currentRow = 1;
    currentCol = 12;
    nextRow = 0;
    nextCol = 0;
    
    canBeTouched = YES;
    NSMutableArray *array0 = [[NSMutableArray alloc] initWithCapacity:conut];
    self.bannerImageViewArray = array0;
    [array0 release];
    NSMutableArray *array1 = [[NSMutableArray alloc] initWithCapacity:sum1];
    self.parkImageViewArray = array1;
    [array1 release];
    NSMutableArray *array2 = [[NSMutableArray alloc] initWithCapacity:sum2];
    self.londonvenuesImageViewArray = array2;
    [array2 release];
    NSMutableArray *array3 = [[NSMutableArray alloc] initWithCapacity:sum3];
    self.othervenuesImageViewArray = array3;
    [array3 release];

    
    VenueIcon *icon1 = [[VenueIcon alloc] init];
    VenueIcon *icon2 = [[VenueIcon alloc] init];
    VenueIcon *icon3 = [[VenueIcon alloc] init];
    self.backIcon1 = icon1;
    self.backIcon2 = icon2;
    self.backIcon3 = icon3;
    [icon1 release];
    [icon2 release];
    [icon3 release];
    
    UIImage *image1 = [UIImage imageNamed:@"back.png"];
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:image1];
    backIcon1.col = -1;
    backIcon1.row = 0;
    backIcon1.delegate = self;
    backIcon1.alpha = 0;
    backIcon1.frame = CGRectMake(1, 50, 50, 50);
    [backIcon1 addSubview:imageView1];
    [parkView addSubview:backIcon1];
    [imageView1 release];
  
    
    UIImage *image2 = [UIImage imageNamed:@"back.png"];
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:image2];
    backIcon2.col = -1;
    backIcon2.row = 1;
    backIcon2.delegate = self;
    backIcon2.alpha = 0;
    [backIcon2 addSubview:imageView2];
    backIcon2.frame = CGRectMake(1, 50, 50, 50);
    [londonView addSubview:backIcon2];
    [imageView2 release];
    

    UIImage *image3 = [UIImage imageNamed:@"back.png"];
    UIImageView *imageView3 = [[UIImageView alloc] initWithImage:image3];
    backIcon3.col = -1;
    backIcon3.row = 2;
    backIcon3.delegate = self;
    backIcon3.alpha = 0;
    [backIcon3 addSubview:imageView3];
    backIcon3.frame = CGRectMake(1, 50, 50, 50);
    [othervenuesView addSubview:backIcon3];
    [imageView3 release];
    
    self.bannerScrollView.frame = VenueBannerFrameOut;
    self.bannerScrollView.alpha = 0;
    self.bannerScrollView.contentSize = CGSizeMake(1024*conut, 150);
    self.bannerScrollView.showsHorizontalScrollIndicator = NO;
    for (int i = 0; i<conut; i++) {
        
        int row;
        int col;
        if (i<sum1) row=0,col=i;
        else if (i>=sum1 && i<sum1+sum2) row=1,col=i-sum1;
        else if (i>=sum1+sum2 && i<conut) row=2,col=i-sum1-sum2;
            
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"hengfur%dc%d.png",row,col]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
        imageView.frame  = CGRectMake(1024*i, 0, 1024, 150);
        [bannerScrollView addSubview:imageView];
        [bannerImageViewArray addObject:imageView];
        [imageView release];
    }
    
    
    self.parkScrollView.contentSize = CGSizeMake(150*sum1, 104);
    self.parkScrollView.showsVerticalScrollIndicator = NO;
    self.parkScrollView.showsHorizontalScrollIndicator = NO;
    for (int i = 0; i<sum1; i++) {
        VenueIcon *venueIcon = [[VenueIcon alloc] init];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"venuesr0c%d.png",i]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
        venueIcon.col = i; 
        venueIcon.row = 0;
        venueIcon.delegate = self;
        [venueIcon addSubview:imageView];
        venueIcon.frame  = CGRectMake(150*i, 10, 140, 85);
        
        [parkScrollView addSubview:venueIcon];
        [parkImageViewArray addObject:venueIcon];
        [venueIcon release];
        [imageView release];
    }
    
    self.londonvenuesScrollView.contentSize = CGSizeMake(150*sum2, 107);
    self.londonvenuesScrollView.showsVerticalScrollIndicator = NO;
    self.londonvenuesScrollView.showsHorizontalScrollIndicator = NO;
    for (int i = 0; i<sum2; i++) {
        VenueIcon *venueIcon = [[VenueIcon alloc] init];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"venuesr1c%d.png",i]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
        venueIcon.col = i; 
        venueIcon.row = 1;
        venueIcon.delegate = self;
        [venueIcon addSubview:imageView];
        venueIcon.frame  = CGRectMake(150*i, 10, 140, 85);
        
        [londonvenuesScrollView addSubview:venueIcon];
        [londonvenuesImageViewArray addObject:venueIcon];
        [venueIcon release];
        [imageView release];

    }
    
    self.othervenuesScrollView.contentSize = CGSizeMake(150*sum3, 107);
    self.othervenuesScrollView.showsVerticalScrollIndicator = NO;
    self.othervenuesScrollView.showsHorizontalScrollIndicator = NO;
    for (int i = 0; i<sum3; i++) {
        VenueIcon *venueIcon = [[VenueIcon alloc] init];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"venuesr2c%d.png",i]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
        venueIcon.col = i; 
        venueIcon.row = 2;
        venueIcon.delegate = self;
        [venueIcon addSubview:imageView];
        venueIcon.frame  = CGRectMake(150*i, 10, 140, 85);
        
        [othervenuesScrollView addSubview:venueIcon];
        [othervenuesImageViewArray addObject:venueIcon];
        [venueIcon release];
        [imageView release];

    }
    
    UISwipeGestureRecognizer *gestureRecognizer1 = [[UISwipeGestureRecognizer alloc]  initWithTarget:self action:@selector(moveToTop0)];
    [gestureRecognizer1 setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.parkView addGestureRecognizer:gestureRecognizer1];
    [gestureRecognizer1 release];
    
    
    UISwipeGestureRecognizer *gestureRecognizer2 = [[UISwipeGestureRecognizer alloc]  initWithTarget:self action:@selector(moveToTop1)];
    [gestureRecognizer2 setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.londonView addGestureRecognizer:gestureRecognizer2];
    [gestureRecognizer2 release];
    
    UISwipeGestureRecognizer *gestureRecognizer3 = [[UISwipeGestureRecognizer alloc]  initWithTarget:self action:@selector(moveToTop2)];
    [gestureRecognizer3 setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.othervenuesView addGestureRecognizer:gestureRecognizer3];
    [gestureRecognizer3 release];
    
    UISwipeGestureRecognizer *gestureRecognizer4 = [[UISwipeGestureRecognizer alloc]  initWithTarget:self action:@selector(moveToBottom0)];
    [gestureRecognizer4 setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.parkView addGestureRecognizer:gestureRecognizer4];
    [gestureRecognizer4 release];
    
    UISwipeGestureRecognizer *gestureRecognizer5 = [[UISwipeGestureRecognizer alloc]  initWithTarget:self action:@selector(moveToBottom1)];
    [gestureRecognizer5 setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.londonView addGestureRecognizer:gestureRecognizer5];
    [gestureRecognizer5 release];
    
    UISwipeGestureRecognizer *gestureRecognizer6 = [[UISwipeGestureRecognizer alloc]  initWithTarget:self action:@selector(moveToBottom2)];
    [gestureRecognizer6 setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.othervenuesView addGestureRecognizer:gestureRecognizer6];
    [gestureRecognizer6 release];
    
    
    self.logotitleImageView.frame = VenueLogoTitleFrameIn;
    
    NSMutableDictionary *contentDic2 = [[NSMutableDictionary alloc] initWithCapacity:10];
    self.Section2ContentDic= contentDic2;
    [contentDic2 release];
    
    
    UIView *section2View = [[UIView alloc] init];
    section2View.frame = VenueView2FrameRight;
    section2View.backgroundColor = [UIColor clearColor];
    section2View.alpha = 0;
    [self.view addSubview:section2View];
    [self.Section2ContentDic setObject:section2View forKey:@"view2"];
    [section2View release];
    
    UIImage *photoImage= [UIImage imageNamed:@"photor0c0.png"];
    UIImageView *photoImageView = [[UIImageView alloc] initWithImage:photoImage];
    photoImageView.frame = VenuePhotoFrame;
    [section2View addSubview:photoImageView];
    [self.Section2ContentDic setObject:photoImageView forKey:@"photoView"];
    [photoImageView release];
    
    UIImage *photoTitleImage= [UIImage imageNamed:@"titler0c0.png"];
    UIImageView *photoTitleImageView = [[UIImageView alloc] initWithImage:photoTitleImage];
    photoTitleImageView.frame = VenueTitleFrameRight;
    [section2View addSubview:photoTitleImageView];
    [self.Section2ContentDic setObject:photoTitleImageView forKey:@"photoTitleView"];
    [photoTitleImageView release];
    
    
    
    
    NSMutableDictionary *contentDic1 = [[NSMutableDictionary alloc] initWithCapacity:10];
    self.Section1ContentDic = contentDic1;
    [contentDic1 release];
    
    
    UIView *section1View = [[UIView alloc] init];
    section1View.frame = VenueView1FrameLeft;
    section1View.backgroundColor = [UIColor clearColor];
    section1View.alpha = 0;
    [self.view addSubview:section1View];
    [self.Section1ContentDic setObject:section1View forKey:@"view1"];
    [section1View release];
    
    
    UIImage *bannerinfo11 = [UIImage imageNamed:@"vbanner0-0.png"];
    UIImageView *bannerinfoView11 = [[UIImageView alloc] initWithImage:bannerinfo11];
    bannerinfoView11.frame = VenueBannerInfo1FrameRight;
    [section1View addSubview:bannerinfoView11];
    [self.Section1ContentDic setObject:bannerinfoView11 forKey:@"bannerinfoView11"];
    [bannerinfoView11 release];
    
    UIImage *bannerinfo12 = [UIImage imageNamed:@"vbanner0-1.png"];
    UIImageView *bannerinfoView12 = [[UIImageView alloc] initWithImage:bannerinfo12];
    bannerinfoView12.frame = VenueBannerInfo2FrameRight;
    [section1View addSubview:bannerinfoView12];
    [self.Section1ContentDic setObject:bannerinfoView12 forKey:@"bannerinfoView12"];
    [bannerinfoView12 release];
    
    
    UIImage *titleImage1 = [UIImage imageNamed:@"title1.png"];
    UIImageView *subtitle1 = [[UIImageView alloc] initWithImage:titleImage1];
    subtitle1.frame = VenueSubtitle1FrameRight;
    [section1View addSubview:subtitle1];
    [self.Section1ContentDic setObject:subtitle1 forKey:@"subtitle1"];
    [subtitle1 release];
    
    
    UITextView *subTitleLabel1 = [[UITextView alloc] init];
    subTitleLabel1.frame = VenueSubTitleLabel1FrameRight;
    subTitleLabel1.userInteractionEnabled = YES;
    subTitleLabel1.editable = NO;
    subTitleLabel1.scrollEnabled = NO;
    subTitleLabel1.text = @"伦敦西北部，距离伦敦市中心仅6英里。坐落在温布利体育场旁。";
    subTitleLabel1.font = [UIFont fontWithName:@"HelveticaBold" size:12];
    subTitleLabel1.textColor = [UIColor whiteColor];
    subTitleLabel1.backgroundColor = [UIColor clearColor];
    [self.Section1ContentDic setObject:subTitleLabel1 forKey:@"subTitleLabel1"];
    [section1View addSubview:subTitleLabel1];
    [subTitleLabel1 release];

    UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PlaceTouched:)];  
    singleFingerOne.numberOfTouchesRequired = 1; 
    singleFingerOne.numberOfTapsRequired = 1; 
    [subTitleLabel1 addGestureRecognizer:singleFingerOne];
    [singleFingerOne release];
    
    
    UIImage *titleImage2 = [UIImage imageNamed:@"title2.png"];
    UIImageView *subtitle2 = [[UIImageView alloc] initWithImage:titleImage2];
    subtitle2.frame = VenueSubtitle2FrameRight;
    [section1View addSubview:subtitle2];
    [self.Section1ContentDic setObject:subtitle2 forKey:@"subtitle2"];
    [subtitle2 release];
    
    UITextView *subTitleLabel2 = [[UITextView alloc] init];
    subTitleLabel2.frame = VenueSubTitleLabel2FrameRight;
    subTitleLabel2.userInteractionEnabled = YES;
    subTitleLabel2.editable = NO;
    subTitleLabel2.scrollEnabled = NO;
    subTitleLabel2.text = @"奥运会马术比赛的主场地，包括场地障碍赛、盛装舞步赛、综合全能马术赛";
    subTitleLabel2.font = [UIFont fontWithName:@"HelveticaBold" size:12];
    subTitleLabel2.backgroundColor = [UIColor clearColor];
    subTitleLabel2.textColor = [UIColor whiteColor];
    [self.Section1ContentDic setObject:subTitleLabel2 forKey:@"subTitleLabel2"];
    [section1View addSubview:subTitleLabel2];
    [subTitleLabel2 release];
    
    UIImage *titleImage3 = [UIImage imageNamed:@"title3.png"];
    UIImageView *subtitle3 = [[UIImageView alloc] initWithImage:titleImage3];
    subtitle3.frame = VenueSubtitle3FrameRight;
    [section1View addSubview:subtitle3];
    [self.Section1ContentDic setObject:subtitle3 forKey:@"subtitle3"];
    [subtitle3 release];
    
    UITextView *subTitleLabel3 = [[UITextView alloc] init];
    subTitleLabel3.frame = VenueSubTitleLabel3FrameRight;
    subTitleLabel3.userInteractionEnabled = YES;
    subTitleLabel3.editable = NO;
    subTitleLabel3.scrollEnabled = NO;
    subTitleLabel3.text = @"场馆1：6 000座位(举重) 场馆2：10 000座位(柔道等)";
    subTitleLabel3.font = [UIFont fontWithName:@"HelveticaBold" size:12];
    subTitleLabel3.textColor = [UIColor whiteColor];
    subTitleLabel3.backgroundColor = [UIColor clearColor];
    [self.Section1ContentDic setObject:subTitleLabel3 forKey:@"subTitleLabel3"];
    [section1View addSubview:subTitleLabel3];
    [subTitleLabel3 release];
    
    

    NSMutableString *str = [[NSMutableString alloc] initWithString:@"<head><style> .two {                    font-size:18px;} p {text-indent: 2em;}</style></head><body style=\"background-color:#0085a1;color:#FFFFFF;font-size:14px;font-weight:100;letter-spacing: -1px;\"></body>"];
    self.preHtmlString = str;
    [str release];
    CGRect contentFrame = VenueWebViewFrameRight;
    
    float fWidth = contentFrame.size.width;
    float fHeight = contentFrame.size.height/2;
    
    
    UIScrollView *aScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, fWidth, fHeight)];
    [aScrollView setContentSize:CGSizeMake(fWidth*3, fHeight)];
    
    OlmpicPageControl *aPageControl = [[OlmpicPageControl alloc] initWithFrame:contentFrame AndScrollView:aScrollView];   
    [self.Section1ContentDic setObject:aPageControl forKey:@"aPageControl"];
    [aScrollView release];
    
    aPageControl.backgroundColor = [UIColor clearColor];   
    aPageControl.numberOfPages = 3;   
    aPageControl.currentPage = 0;      
    
    [section1View addSubview:aPageControl];   
    
    UIImage *htmltitle1 = [UIImage imageNamed:@"vWebTab1.png"];
    UIImage *htmltitle2 = [UIImage imageNamed:@"vWebTab2.png"];
    UIImage *htmltitle3 = [UIImage imageNamed:@"vWebTab3.png"];
    UIImageView *htmlView1 = [[UIImageView alloc] initWithImage:htmltitle1];
    UIImageView *htmlView2 = [[UIImageView alloc] initWithImage:htmltitle2];
    UIImageView *htmlView3 = [[UIImageView alloc] initWithImage:htmltitle3];
    htmlView1.frame = CGRectMake((fWidth-72)/2, 5, 72, 16);
    htmlView2.frame = CGRectMake(fWidth+(fWidth-72)/2, 5, 72, 16);
    htmlView3.frame = CGRectMake(2*fWidth+(fWidth-72)/2, 5, 72, 16);
    [aScrollView addSubview:htmlView1];
    [aScrollView addSubview:htmlView2];
    [aScrollView addSubview:htmlView3];
    [htmlView1 release];
    [htmlView2 release];
    [htmlView3 release];
    
    UIWebView *webView1 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 30, fWidth, fHeight-40)];
    webView1.backgroundColor = [UIColor clearColor];
    webView1.scalesPageToFit = NO;
    webView1.multipleTouchEnabled = YES;
    [webView1 loadHTMLString:preHtmlString baseURL:nil];
    [aScrollView addSubview:webView1];
    [self.Section1ContentDic setObject:webView1 forKey:@"webView1"];
    [webView1 release];
    
    
    UIWebView *webView2 = [[UIWebView alloc] initWithFrame:CGRectMake(fWidth, 30, fWidth, fHeight-40)];
    webView2.backgroundColor = [UIColor clearColor];
    webView2.scalesPageToFit = NO;
    webView2.multipleTouchEnabled = YES;
    [webView2 loadHTMLString:preHtmlString baseURL:nil];
    [aScrollView addSubview:webView2];
    [self.Section1ContentDic setObject:webView2 forKey:@"webView2"];
    [webView2 release];
    
    UIWebView *webView3 = [[UIWebView alloc] initWithFrame:CGRectMake(fWidth*2, 30, fWidth, fHeight-40)];
    webView3.backgroundColor = [UIColor clearColor];
    webView3.scalesPageToFit = NO;
    webView3.multipleTouchEnabled = YES;
    [webView3 loadHTMLString:preHtmlString baseURL:nil];
    [aScrollView addSubview:webView3];
    [self.Section1ContentDic setObject:webView3 forKey:@"webView3"];
    [webView3 release];
    
    
    UIView *sportIconView = [[UIView alloc] init];
    sportIconView.frame = VenueSportIconViewFrameLeft;
    [section1View addSubview:sportIconView];
    [self.Section1ContentDic setObject:sportIconView forKey:@"sportIconView"];
    [sportIconView release];
    
    UIImage *sportIconImage1 = [UIImage imageNamed:@"sport0.png"];
    SportIcon *sportIcon1 = [[SportIcon alloc] initWithImage:sportIconImage1];
    sportIcon1.frame = CGRectMake(52, 0, 42, 42);
    [sportIconView addSubview:sportIcon1];
    [self.Section1ContentDic setObject:sportIcon1 forKey:@"sportIcon1"];
    [sportIcon1 release];
    
    UIImage *sportIconImage2 = [UIImage imageNamed:@"sport1.png"];
    SportIcon *sportIcon2 = [[SportIcon alloc] initWithImage:sportIconImage2];
    sportIcon2.frame = CGRectMake(0, 0, 42, 42);
    [sportIconView addSubview:sportIcon2];
    [self.Section1ContentDic setObject:sportIcon2 forKey:@"sportIcon2"];
    [sportIcon2 release];

    
    lineView1.alpha = 0;
    lineView2.alpha = 0;
    lineView3.alpha = 0;
    
}

- (void)updateStatues
{
    int currStatues = flag[currentRow][currentCol];
    int nextStatues = flag[nextRow][nextCol];
    int index = 0;
    
    switch (nextRow) {
        case 0:
            index = nextCol;
            [UIView animateWithDuration:VenueContentSwitchDuration
                             animations:^{
                                 lineView1.alpha = 1;
                                 lineView1.frame = CGRectMake(150*nextCol, 98, 136, 7);
                             }
                             completion:^(BOOL finished){
            }];
            break;
        case 1:
            index = VenueRow0Number + nextCol;
            [UIView animateWithDuration:VenueContentSwitchDuration
                             animations:^{
                                 lineView2.alpha = 1;
                                 lineView2.frame = CGRectMake(150*nextCol, 98, 136, 7);
                             }
                             completion:^(BOOL finished){
                             }];
            break;
        case 2:
            index = VenueRow0Number + VenueRow1Number + nextCol;
            [UIView animateWithDuration:VenueContentSwitchDuration
                             animations:^{
                                 lineView3.alpha = 1;
                                 lineView3.frame = CGRectMake(150*nextCol, 98, 136, 7);
                             }
                             completion:^(BOOL finished){
                             }];
            break;
    }
    
    
    [self.bannerScrollView setContentOffset:CGPointMake(index*1024, 0) animated:YES];
    
    
    if (currStatues == 1 && nextStatues == 1) {
        [self moveFirstImageActionTo:VenueView1FrameLeftSwap 
                             Through:VenueView1FrameLeftSwap 
                           FinallyTo:VenueView1FrameLeft];
        [self moveSecondImageActionTo:VenueView2FrameRightSwap
                              Through:VenueView2FrameRightSwap
                            FinallyTo:VenueView2FrameRight];
    }
    else if (currStatues == 1 && nextStatues == 2) {
        [self moveFirstImageActionTo:VenueView1FrameLeftSwap 
                             Through:VenueView1FrameRightSwap 
                           FinallyTo:VenueView1FrameRight];
        [self moveSecondImageActionTo:VenueView2FrameRightSwap
                              Through:VenueView2FrameLeftSwap
                            FinallyTo:VenueView2FrameLeft];
    }
    else if (currStatues == 2 && nextStatues == 1) {
        [self moveFirstImageActionTo:VenueView1FrameRightSwap
                             Through:VenueView1FrameLeftSwap 
                           FinallyTo:VenueView1FrameLeft];
        [self moveSecondImageActionTo:VenueView2FrameLeftSwap
                              Through:VenueView2FrameRightSwap
                            FinallyTo:VenueView2FrameRight];
    }
    else if (currStatues == 2 && nextStatues == 2) {
        [self moveFirstImageActionTo:VenueView1FrameRightSwap
                             Through:VenueView1FrameRightSwap 
                           FinallyTo:VenueView1FrameRight];
        [self moveSecondImageActionTo:VenueView2FrameLeftSwap
                              Through:VenueView2FrameLeftSwap
                            FinallyTo:VenueView2FrameLeft];
    }
    currentRow = nextRow;
    currentCol = nextCol;
    
}

- (void)moveFirstImageActionTo:(CGRect )p1 Through:(CGRect )p2 FinallyTo:(CGRect )p3 
{
    
    int nextStatues = flag[nextRow][nextCol];
    
    UIView *view1 = [Section1ContentDic objectForKey:@"view1"];
    [UIView animateWithDuration:VenueContentSwitchDuration
                     animations:^{
                         view1.alpha = 0;
                         view1.frame = p1;
                     }
                     completion:^(BOOL finished){
                         view1.frame = p2;
                         [UIView animateWithDuration:VenueContentSwitchDuration 
                                          animations:^{
                                              NSArray *dataArray = [self fetchData];
                                              UIImageView *subtitle1 = [Section1ContentDic objectForKey:@"subtitle1"];
                                              UIImageView *subtitle2 = [Section1ContentDic objectForKey:@"subtitle2"];
                                              UIImageView *subtitle3 = [Section1ContentDic objectForKey:@"subtitle3"];
                                              UIImageView *banner1 = [Section1ContentDic objectForKey:@"bannerinfoView11"];
                                              UIImageView *banner2 = [Section1ContentDic objectForKey:@"bannerinfoView12"];
                                              OlmpicPageControl *pageControl = [Section1ContentDic objectForKey:@"aPageControl"];
                                              pageControl.currentPage = 0;  
                                              [pageControl.aScrollView setContentOffset:CGPointMake(0, 0)];
                                              UITextView *textView1 = [Section1ContentDic objectForKey:@"subTitleLabel1"];
                                              NSString *text = [[NSString alloc] initWithFormat:@"%@",[dataArray objectAtIndex:0]];
                                              textView1.text = text;
                                              [text release];
                                              
                                              UITextView *textView2 = [Section1ContentDic objectForKey:@"subTitleLabel2"];
                                              textView2.text = [dataArray objectAtIndex:1];
                                              UITextView *textView3 = [Section1ContentDic objectForKey:@"subTitleLabel3"];
                                              textView3.text = [dataArray objectAtIndex:2];
                                              UIWebView *webView1 = [Section1ContentDic objectForKey:@"webView1"];
                                              UIWebView *webView2 = [Section1ContentDic objectForKey:@"webView2"];
                                              UIWebView *webView3 = [Section1ContentDic objectForKey:@"webView3"];
                                              UIView *sportIconView = [Section1ContentDic objectForKey:@"sportIconView"];
                                              if (nextStatues == 1) {
                                                  subtitle1.frame = VenueSubtitle1FrameLeft;
                                                  subtitle2.frame = VenueSubtitle2FrameLeft;
                                                  subtitle3.frame = VenueSubtitle3FrameLeft;
                                                  textView1.frame = VenueSubTitleLabel1FrameLeft;
                                                  textView2.frame = VenueSubTitleLabel2FrameLeft;
                                                  textView3.frame = VenueSubTitleLabel3FrameLeft;
                                                  banner1.frame = VenueBannerInfo1FrameLeft;
                                                  banner2.frame = VenueBannerInfo2FrameLeft;
                                                  pageControl.frame = VenueWebViewFrameLeft;
                                                  sportIconView.frame = VenueSportIconViewFrameLeft;
                                              
                                                  banner1.image = [UIImage imageNamed:[NSString stringWithFormat:@"vbanner%d-2.png",nextRow]];
                                                  banner2.image = [UIImage imageNamed:[NSString stringWithFormat:@"vbanner%d-3.png",nextRow]];
                                                  
                                              }else if (nextStatues == 2) {
                                                  subtitle1.frame = VenueSubtitle1FrameRight;
                                                  subtitle2.frame = VenueSubtitle2FrameRight;
                                                  subtitle3.frame = VenueSubtitle3FrameRight;
                                                  textView1.frame = VenueSubTitleLabel1FrameRight;
                                                  textView2.frame = VenueSubTitleLabel2FrameRight;
                                                  textView3.frame = VenueSubTitleLabel3FrameRight;
                                                  banner1.frame = VenueBannerInfo1FrameRight;
                                                  banner2.frame = VenueBannerInfo2FrameRight;
                                                  pageControl.frame = VenueWebViewFrameRight;
                                                  sportIconView.frame = VenueSportIconViewFrameRight;
                                                  
                                                  banner1.image = [UIImage imageNamed:[NSString stringWithFormat:@"vbanner%d-0.png",nextRow]];
                                                  banner2.image = [UIImage imageNamed:[NSString stringWithFormat:@"vbanner%d-1.png",nextRow]];
                                              }
                                              
                                              NSString *datastring = [dataArray objectAtIndex:3];
                                              NSArray *htmlArray = [datastring componentsSeparatedByString:@"_"];
                                              
                                              NSMutableString *content1 = [[NSMutableString alloc] initWithCapacity:1000];
                                              [content1 setString:preHtmlString ];
                                              
                                              [content1 insertString:[htmlArray objectAtIndex:0] atIndex:[content1 rangeOfString:@"</body>"].location];
                                              [webView1 loadHTMLString:content1 baseURL:nil];
                                              [content1 release];
                                              
                                              NSMutableString *content2 = [[NSMutableString alloc] initWithCapacity:1000];
                                              [content2 setString:preHtmlString ];
                                              [content2 insertString:[htmlArray objectAtIndex:1] atIndex:[content2 rangeOfString:@"</body>"].location];
                                              [webView2 loadHTMLString:content2 baseURL:nil];
                                              [content2 release];
                                              
                                              NSMutableString *content3 = [[NSMutableString alloc] initWithCapacity:1000];
                                              [content3 setString:preHtmlString ];
                                              [content3 insertString:[htmlArray objectAtIndex:2] atIndex:[content3 rangeOfString:@"</body>"].location];
                                              [webView3 loadHTMLString:content3 baseURL:nil];
                                              [content3 release];
                                              
                                              view1.alpha = 1;
                                              view1.frame = p3;
                                              
                                              SportIcon *sportIcon1 = [Section1ContentDic objectForKey:@"sportIcon1"];
                                              SportIcon *sportIcon2 = [Section1ContentDic objectForKey:@"sportIcon2"];
                                              NSString *games_id = [dataArray objectAtIndex:4];
                                              NSArray *array = [games_id componentsSeparatedByString:@"_"];
                                              NSInteger sport_id = [[array objectAtIndex:0] integerValue];
                                              UIImage *image1 = [UIImage imageNamed:[NSString stringWithFormat:@"sport%d",sport_id - 1]];
                                              sportIcon1.imageView.image = image1;
                                              sportIcon1.sport_id = sport_id;
                                              
                                              if ([array count] > 1)  {
                                                  NSInteger sport_id = [[array objectAtIndex:1] integerValue];
                                                  UIImage *image2 = [UIImage imageNamed:[NSString stringWithFormat:@"sport%d",sport_id - 1]];
                                                  sportIcon2.imageView.image = image2;
                                                  sportIcon2.sport_id = sport_id;
                                                  
                                              }else {
                                                  sportIcon2.imageView.image = nil;
                                                  sportIcon2.sport_id = 0;
                                              }
                                                                                     
                                              
                                          }
                                          completion:^(BOOL finished){
                                              
                                          }];
                     }];

}


- (void)moveSecondImageActionTo:(CGRect )p1 Through:(CGRect )p2 FinallyTo:(CGRect )p3 
{
    
    int nextStatues = flag[nextRow][nextCol];
    
    UIView *view2 = [Section2ContentDic objectForKey:@"view2"];
    
    [UIView animateWithDuration:VenueContentSwitchDuration
                     animations:^{
                         view2.alpha = 0;
                         view2.frame = p1;
                     }
                     completion:^(BOOL finished){
                         view2.frame = p2;
                         [UIView animateWithDuration:VenueContentSwitchDuration 
                                          animations:^{
                                              UIImageView *imageView1 = [Section2ContentDic objectForKey:@"photoView"];
                                              UIImage *image1 = [UIImage imageNamed:[NSString stringWithFormat:@"photor%dc%d.png",currentRow,currentCol]];
                                              imageView1.image = image1;
                                              
                                              UIImageView *imageView2 = [Section2ContentDic objectForKey:@"photoTitleView"];
                                              UIImage *image2 = [UIImage imageNamed:[NSString stringWithFormat:@"titler%dc%d.png",currentRow,currentCol]];
                                              imageView2.image = image2;
                                              
                                              if (nextStatues == 1) {
                                                  imageView2.frame = VenueTitleFrameRight;
                                              }else if (nextStatues == 2) {
                                                  imageView2.frame = VenueTitleFrameLeft;
                                              } 
                                              
                                              
                                              view2.alpha = 1;
                                              view2.frame = p3;
                                          }completion:^(BOOL finished){
                                              
                                          }];
                     }];
    
}

- (NSArray *) fetchData
{
    NSString *str = [[[NSString alloc] initWithFormat:@"SELECT location,games,seating,description,game_id FROM venues where row = %d AND col = %d;",nextRow+1,nextCol+1] autorelease];
    return [database fetchQuery:str];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
}


- (void)dealloc {
    [lineView1 release];
    [lineView2 release];
    [lineView3 release];
    [logotitleImageView release];
    [bannerImageViewArray release];
    [parkImageViewArray release];
    [londonvenuesImageViewArray release];
    [othervenuesImageViewArray release];
    [parkImageView release];
    [londonvenuesImageView release];
    [othervenuesImageView release];
    [parkScrollView  release];
    [londonvenuesScrollView release];
    [othervenuesScrollView release];
    [londonView release];
    [othervenuesView release];
    [parkView release];
    [backIcon1 release];
    [backIcon2 release];
    [backIcon3 release];
    [imageScrollView release];
    [imageArray release];
    [imagePageControl release];
    [Section1ContentDic release];
    [Section2ContentDic release];
    [preHtmlString release];
    [bannerScrollView release];
    [super dealloc];
}



- (void) moveToTop0
{
    if (!canBeTouched) {
        return ;
    }
    
    canBeTouched = NO;
    
    [UIView animateWithDuration:VenueNavSwitchDuration 
                     animations:^{
                         self.parkView.frame = CGRectMake(0, VenueMoveToTopY, 1024, 107);
                         self.londonView.frame = CGRectMake(-50, 800, 1024, 107);
                         self.othervenuesView.frame = CGRectMake(107+50, 900, 1024, 107);
                         self.londonView.alpha = 0;
                         self.othervenuesView.alpha = 0;
                         self.backIcon1.alpha = 1;
                         self.bannerScrollView.frame = VenueBannerFrameIn;
                         self.bannerScrollView.alpha = 1;
                         self.logotitleImageView.frame = VenueLogoTitleFrameOut;
                         self.logotitleImageView.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         canBeTouched = YES;
                         nextRow = 0;
                         nextCol = random() % VenueRow0Number;
                         [self updateStatues];
                     }];    
    
    
}

- (void) moveToTop1
{
    if (!canBeTouched) {
        return ;
    }
    
    canBeTouched = NO;
    
    [UIView animateWithDuration:VenueNavSwitchDuration 
                     animations:^{
                         self.parkView.frame = CGRectMake(-50, -200, 1024, 107);
                         self.londonView.frame = CGRectMake(0, VenueMoveToTopY, 1024, 107);
                         self.othervenuesView.frame = CGRectMake(107+50, 800, 1024, 107);
                         self.parkView.alpha = 0;
                         self.othervenuesView.alpha = 0;
                         self.backIcon2.alpha = 1;
                         self.bannerScrollView.frame = VenueBannerFrameIn;
                         self.bannerScrollView.alpha = 1;
                         self.logotitleImageView.frame = VenueLogoTitleFrameOut;
                         self.logotitleImageView.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         canBeTouched = YES;
                         nextRow = 1;
                         nextCol = random() % VenueRow1Number;
                         [self updateStatues];
                     }];   
    
}

- (void) moveToTop2
{
    if (!canBeTouched) {
        return ;
    }
    
    canBeTouched = NO;
    
    [UIView animateWithDuration:VenueNavSwitchDuration 
                     animations:^{
                         self.parkView.frame = CGRectMake(-50, -200, 1024, 107);
                         self.londonView.frame = CGRectMake(107+50, -100, 1024, 107);
                         self.othervenuesView.frame = CGRectMake(0, VenueMoveToTopY, 1024, 107);
                         self.londonView.alpha = 0;
                         self.parkView.alpha = 0;
                         self.backIcon3.alpha = 1;
                         self.bannerScrollView.frame = VenueBannerFrameIn;
                         self.bannerScrollView.alpha = 1;
                         self.logotitleImageView.frame = VenueLogoTitleFrameOut;
                         self.logotitleImageView.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         canBeTouched = YES;
                         nextRow = 2;
                         nextCol = random() % VenueRow2Number;
                         [self updateStatues];
                     }];   
    

}

- (void) moveToBottom0
{
    if (!canBeTouched) {
        return ;
    }
    
    canBeTouched = NO;
    
    [UIView animateWithDuration:VenueNavSwitchDuration 
                     animations:^{
                         lineView1.alpha = 0;
                         self.parkView.frame = CGRectMake(0, 317, 1024, 107);
                         self.londonView.frame = CGRectMake(0, 449, 1024, 107);
                         self.othervenuesView.frame = CGRectMake(0, 581, 1024, 107);
                         self.londonView.alpha = 1;
                         self.othervenuesView.alpha = 1;
                         self.backIcon1.alpha = 0;
                         self.bannerScrollView.frame = VenueBannerFrameOut;
                         self.bannerScrollView.alpha = 0;
                         self.logotitleImageView.frame = VenueLogoTitleFrameIn;
                         self.logotitleImageView.alpha = 1;
                     }
                     completion:^(BOOL finished){
                         canBeTouched = YES;
                     }];  
    
    [UIView animateWithDuration:VenueContentSwitchDuration
                     animations:^{
                         UIView *view1 = [Section1ContentDic objectForKey:@"view1"];
                         UIView *view2 = [Section2ContentDic objectForKey:@"view2"];
                         int nextStates = flag[currentRow][currentCol];
                         if (nextStates == 1) {
                             view1.frame = VenueView1FrameLeftSwap;
                             view2.frame = VenueView2FrameRightSwap;
                         }else if (nextStates == 2) {
                             view1.frame = VenueView1FrameRightSwap;
                             view2.frame = VenueView2FrameLeftSwap;
                         }
                         view1.alpha = 0;
                         view2.alpha = 0;
                     }];
    currentRow = 1;
    currentCol = 12;
    nextRow = 0;
    nextCol = 0;
     
}

- (void) moveToBottom1
{
    if (!canBeTouched) {
        return ;
    }
    
    canBeTouched = NO;
    
    [UIView animateWithDuration:VenueNavSwitchDuration 
                     animations:^{
                         lineView2.alpha = 0;
                         self.parkView.frame = CGRectMake(0, 317, 1024, 107);
                         self.londonView.frame = CGRectMake(0, 449, 1024, 107);
                         self.othervenuesView.frame = CGRectMake(0, 581, 1024, 107);
                         self.parkView.alpha = 1;
                         self.othervenuesView.alpha = 1;
                         self.backIcon2.alpha = 0;
                         self.bannerScrollView.frame = VenueBannerFrameOut;
                         self.bannerScrollView.alpha = 0;
                         self.logotitleImageView.frame = VenueLogoTitleFrameIn;
                         self.logotitleImageView.alpha = 1;
                     }
                     completion:^(BOOL finished){
                         canBeTouched = YES;
                     }];   
    
    [UIView animateWithDuration:VenueContentSwitchDuration
                     animations:^{
                         UIView *view1 = [Section1ContentDic objectForKey:@"view1"];
                         UIView *view2 = [Section2ContentDic objectForKey:@"view2"];
                         int nextStates = flag[currentRow][currentCol];
                         if (nextStates == 1) {
                             view1.frame = VenueView1FrameLeftSwap;
                             view2.frame = VenueView2FrameRightSwap;
                         }else if (nextStates == 2) {
                             view1.frame = VenueView1FrameRightSwap;
                             view2.frame = VenueView2FrameLeftSwap;
                         }
                         view1.alpha = 0;
                         view2.alpha = 0;
                     }];
    currentRow = 1;
    currentCol = 12;
    nextRow = 0;
    nextCol = 0;
}

- (void) moveToBottom2
{
    if (!canBeTouched) {
        return ;
    }
    
    canBeTouched = NO;
    
    [UIView animateWithDuration:VenueNavSwitchDuration 
                     animations:^{
                         lineView3.alpha = 0;
                         self.parkView.frame = CGRectMake(0, 317, 1024, 107);
                         self.londonView.frame = CGRectMake(0, 449, 1024, 107);
                         self.othervenuesView.frame = CGRectMake(0, 581, 1024, 107);
                         
                         self.londonView.alpha = 1;
                         self.parkView.alpha = 1;
                         self.backIcon3.alpha = 0;
                         self.bannerScrollView.frame = VenueBannerFrameOut;
                         self.bannerScrollView.alpha = 0;
                         self.logotitleImageView.frame = VenueLogoTitleFrameIn;
                         self.logotitleImageView.alpha = 1;
                     }
                     completion:^(BOOL finished){
                         canBeTouched = YES;
                     }];   
    [UIView animateWithDuration:VenueContentSwitchDuration
                     animations:^{
                         UIView *view1 = [Section1ContentDic objectForKey:@"view1"];
                         UIView *view2 = [Section2ContentDic objectForKey:@"view2"];
                         int nextStates = flag[currentRow][currentCol];
                         if (nextStates == 1) {
                             view1.frame = VenueView1FrameLeftSwap;
                             view2.frame = VenueView2FrameRightSwap;
                         }else if (nextStates == 2) {
                             view1.frame = VenueView1FrameRightSwap;
                             view2.frame = VenueView2FrameLeftSwap;
                         }
                         view1.alpha = 0;
                         view2.alpha = 0;
                     }];
    currentRow = 1;
    currentCol = 12;
    nextRow = 0;
    nextCol = 0;

}


#pragma mark - 
#pragma mark VenueIcon Delegate

- (void) moveToTop:(id)sender
{
    VenueIcon *icon = (VenueIcon*)sender;
        
    if (!canBeTouched) {
        return ;
    }
    
    canBeTouched = NO;
    
    [UIView animateWithDuration:VenueNavSwitchDuration 
                     animations:^{
                         if (icon.row == 0) {
                             self.parkView.frame = CGRectMake(0, VenueMoveToTopY, 1024, 107);
                             self.londonView.frame = CGRectMake(-50, 800, 1024, 107);
                             self.othervenuesView.frame = CGRectMake(107+50, 900, 1024, 107);
                             self.londonView.alpha = 0;
                             self.othervenuesView.alpha = 0;
                             self.backIcon1.alpha = 1;
                         }else if (icon.row == 1) {
                             self.parkView.frame = CGRectMake(-50, -200, 1024, 107);
                             self.londonView.frame = CGRectMake(0, VenueMoveToTopY, 1024, 107);
                             self.othervenuesView.frame = CGRectMake(107+50, 800, 1024, 107);
                             self.parkView.alpha = 0;
                             self.othervenuesView.alpha = 0;
                             self.backIcon2.alpha = 1;
                         }else if (icon.row == 2) {
                             self.parkView.frame = CGRectMake(-50, -200, 1024, 107);
                             self.londonView.frame = CGRectMake(107+50, -100, 1024, 107);
                             self.othervenuesView.frame = CGRectMake(0, VenueMoveToTopY, 1024, 107);
                             self.londonView.alpha = 0;
                             self.parkView.alpha = 0;
                             self.backIcon3.alpha = 1;
                         }
                         self.bannerScrollView.frame = VenueBannerFrameIn;
                         self.bannerScrollView.alpha = 1;
                         self.logotitleImageView.frame = VenueLogoTitleFrameOut;
                         self.logotitleImageView.alpha = 0;

                     }
                     completion:^(BOOL finished){
                         canBeTouched = YES;
                     }]; 

    nextRow = icon.row;
    nextCol = icon.col;
    if (nextRow != currentRow || nextCol != currentCol) {
        [self updateStatues];
    }
    
    
}
- (void) moveToBottom:(id)sender
{
    VenueIcon *icon = (VenueIcon*)sender;
    
    if (!canBeTouched) {
        return ;
    }
    
    canBeTouched = NO;
    
    [UIView animateWithDuration:VenueNavSwitchDuration 
                     animations:^{
                         lineView1.alpha = 0;
                         lineView2.alpha = 0;
                         lineView3.alpha = 0;
                         self.parkView.frame = CGRectMake(0, 317, 1024, 107);
                         self.londonView.frame = CGRectMake(0, 449, 1024, 107);
                         self.othervenuesView.frame = CGRectMake(0, 581, 1024, 107);
                         if (icon.row == 0) {
                             self.londonView.alpha = 1;
                             self.othervenuesView.alpha = 1;
                             self.backIcon1.alpha = 0;
                         }else if (icon.row == 1) {
                             
                             self.parkView.alpha = 1;
                             self.othervenuesView.alpha = 1;
                             self.backIcon2.alpha = 0;
                         }else if (icon.row == 2) {
                             
                             self.londonView.alpha = 1;
                             self.parkView.alpha = 1;
                             self.backIcon3.alpha = 0;
                         }
                         self.bannerScrollView.frame = VenueBannerFrameOut;
                         self.bannerScrollView.alpha = 0;
                         self.logotitleImageView.frame = VenueLogoTitleFrameIn;
                         self.logotitleImageView.alpha = 1;
                     }
                     completion:^(BOOL finished){
                         canBeTouched = YES;
                     }]; 
    
    [UIView animateWithDuration:VenueContentSwitchDuration
                     animations:^{
                         UIView *view1 = [Section1ContentDic objectForKey:@"view1"];
                         UIView *view2 = [Section2ContentDic objectForKey:@"view2"];
                         int nextStates = flag[currentRow][currentCol];
                         if (nextStates == 1) {
                             view1.frame = VenueView1FrameLeftSwap;
                             view2.frame = VenueView2FrameRightSwap;
                         }else if (nextStates == 2) {
                             view1.frame = VenueView1FrameRightSwap;
                             view2.frame = VenueView2FrameLeftSwap;
                         }
                         view1.alpha = 0;
                         view2.alpha = 0;
                     }];
    currentRow = 1;
    currentCol = 12;
    nextRow = 0;
    nextCol = 0;
    
}

- (void) tapIcon:(id)sender
{
    
}

- (void) PlaceTouched:(id) sender
{/*
    MapViewController *mapViewController = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
    
    [self.navigationController pushViewController:mapViewController animated:YES];
    [mapViewController release];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    mapViewController.olympicMap.mapType = MKMapTypeHybrid;
    mapViewController.toolBar.hidden = YES;
    
    
    NSString *query2 = [[NSString alloc] initWithFormat:@"SELECT latitude,longitude FROM venues where row = %d AND col = %d;",currentRow + 1,currentCol + 1];
    NSArray *selectVenuesInfo = [database fetchQuery:query2];
    CLLocationCoordinate2D coords;
    coords.latitude = [[selectVenuesInfo objectAtIndex:0] floatValue];
    coords.longitude = [[selectVenuesInfo objectAtIndex:1] floatValue];
    MKCoordinateSpan span = MKCoordinateSpanMake(0.002389, 0.005681);
    MKCoordinateRegion region = MKCoordinateRegionMake(coords, span);
    [mapViewController.olympicMap setRegion:region animated:YES];
  */
}

#pragma mark -
#pragma mark scrollview delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width; 
    imagePageControl.currentPage = index;
}

-(void)PageTurnResponse:(UIPageControl *)thePageControl
{
    int choosePage = thePageControl.currentPage;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    imageScrollView.contentOffset = CGPointMake(320 * choosePage, 0.0f);
    [UIView commitAnimations];
}



@end

    //
//  MainViewController.m
//  exploreolympic
//
//  Created by idream on 12-3-28.
//  Copyright 2012 iDreamStudio. All rights reserved.
//

#import "MainViewController.h"
#import "NavIcon.h"
#import "exploreolympicAppDelegate.h"

static MainViewController *thisController;

@interface MainViewController(private)
    
-(void)PageTurnResponse:(UIPageControl *)thePageControl;
-(void) startAnimation;
-(void) loadNavImage;
-(void) loadCountDown;
-(void) loadPolygon;
-(void) loadLogoImage;
@end


@implementation MainViewController
@synthesize flagSqueue;
@synthesize canBeTouched;
@synthesize background2;
@synthesize countDownView;
@synthesize imagePageControl;
@synthesize imageArray;
@synthesize transition;
@synthesize index;
@synthesize eventArray;
@synthesize imageScrollView;
@synthesize logoImageView;
@synthesize day1,day2,day3,hour1,hour2,min1,min2,sec1,sec2;
@synthesize numberArray;
@synthesize logoImage1,logoImage2,logoImage3,logoImage4,logoImage5,logoImage6,logoImage7,logoImage8,logoImage9,logoImage10;
@synthesize logoImage11,logoImage12,logoImage13,logoImage14,logoImage15,logoImage16,logoImage17,logoImage18,logoImage19,logoImage20;
@synthesize logoImage21,logoImage22,logoImage23,logoImage24,logoImage25,logoImage26,logoImage27,logoImage28,logoImage29,logoImage30;
@synthesize logoImage31,logoImage32,logoImage33,logoImage34,logoImage35,logoImage36,logoImage37,logoImage38,logoImage39,logoImage40;
@synthesize logoImage41,logoImage42,logoImage43,logoImage44,logoImage45,logoImage46,logoImage47,logoImage48,logoImage49,logoImage50;
@synthesize logoImage51,logoImage52,logoImage53,logoImage54,logoImage55,logoImage56,logoImage57,logoImage58,logoImage59,logoImage60;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        thisController = self;
        self.tabBarItem.title = NSLocalizedString(@"首页",@"tabItem1Title");
        self.tabBarItem.image = [UIImage imageNamed:@"home.png"];
       
    }
    return self;
}

+ (MainViewController *) shareController 
{
    return thisController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadMainView];
}

-(void) loadMainView
{    
    [self preLoadPolygon];
    canBeTouched = YES;
    
    UIImage *image1 = [UIImage imageNamed:@"logo1.png"];
    UIImageView *View = [[UIImageView alloc] initWithFrame:CGRectMake(341, 157, 321, 339)];
    View.image = image1;
    [self.view addSubview:View];
    [View release];
    
    countDownView.alpha = 0;
    [self loadCountDown];
    
    [UIView animateWithDuration:MainLogoMoveDuration 
                     animations:^{
                         View.frame = CGRectMake(35, 14, 178, 202);
                     }
                     completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:MainPolygonLoadDuration 
                                          animations:^{
                                              [self loadPolygon];
                                              countDownView.alpha = 1;
                                          }
                                          completion:^(BOOL finished) {
                                              [self loadNavImage];
                                              [self loadLogoImage];
                                          }];
                         
                     }];
}

-(void) loadNavImage
{

    float fImageWidth = 342;
    float fImageHeight = 200;
    imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 500, fImageWidth*3, fImageHeight)];
    
    imageScrollView.contentSize = CGSizeMake(fImageWidth*3, fImageHeight);
    imageScrollView.showsVerticalScrollIndicator = NO;
    imageScrollView.showsHorizontalScrollIndicator = NO;

    for (int i = 0; i<3; i++) {
        NavIcon *icon = [[NavIcon alloc] init];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"pic_%d.png",i+1]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
        icon.col = i; 
        icon.row = 0;
        [icon addSubview:imageView];
        icon.frame  = CGRectMake(fImageWidth*i, 0, fImageWidth, fImageHeight);
        
        [imageScrollView addSubview:icon];
        [icon release];

        [imageView release];
    }
    imageScrollView.alpha = 0;
    [self.view addSubview:imageScrollView];

    [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(showNavImage) userInfo:nil repeats:NO];
    
}

- (void) showNavImage
{
    background2.hidden = NO;
    CATransition *myTransition = [CATransition animation];
    
	myTransition.duration = 3;
	myTransition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	NSString *subtypes[4] = {kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom};
       NSString *moreTypes[]={@"cube",@"suckEffect",@"oglFlip",@"rippleEffect",@"pageCurl",@"pageUnCurl",@"cameraIrisHollowOpen",@"cameraIrisHollowClose"};
    
    myTransition.type = moreTypes[3];
    myTransition.subtype = subtypes[random() % 4];
	myTransition.delegate = self;

    [imageScrollView.layer addAnimation:myTransition forKey:nil];
    imageScrollView.alpha = 1;

}
-(void) loadCountDown
{
    UIImage *image0 = [UIImage imageNamed:@"0.png"];
    UIImage *image1 = [UIImage imageNamed:@"1.png"];
    UIImage *image2 = [UIImage imageNamed:@"2.png"];
    UIImage *image3 = [UIImage imageNamed:@"3.png"];
    UIImage *image4 = [UIImage imageNamed:@"4.png"];
    UIImage *image5 = [UIImage imageNamed:@"5.png"];
    UIImage *image6 = [UIImage imageNamed:@"6.png"];
    UIImage *image7 = [UIImage imageNamed:@"7.png"];
    UIImage *image8 = [UIImage imageNamed:@"8.png"];
    UIImage *image9 = [UIImage imageNamed:@"9.png"];
    NSArray *array1 = [[NSArray alloc] initWithObjects:image0,image1,image2,image3
                       ,image4,image5,image6,image7,image8,image9, nil];
    self.numberArray = array1;
    [array1 release];
    
    countDownView.hidden = NO;
    
    UIScrollView *timeView = [[UIScrollView alloc] initWithFrame:CGRectMake(714, 58, 270, 48)];
    [self.view addSubview:timeView];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownTime) userInfo:nil repeats:YES];
    [timeView release];

}

- (void) countDownTime
{
    NSLocale *Locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:Locale];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *dateOpen = [dateFormatter dateFromString:@"2012-07-28 03:12:00"];
    NSDate *date1 = [NSDate date];
    NSInteger countdown = (NSInteger)[dateOpen timeIntervalSinceDate:date1];
    [dateFormatter release];
    [Locale release];
    
    NSUInteger leftday = countdown/(3600*24);
    NSUInteger lefthour = (countdown - leftday*3600*24)/3600;
    NSUInteger leftmin = (countdown - leftday*3600*24 - lefthour*3600)/60;
    NSUInteger leftsec = (countdown - leftday*3600*24 - lefthour*3600 - leftmin*60);
    
    
    self.day1.image = nil;//[numberArray objectAtIndex:leftday/100];
    self.day2.image = [numberArray objectAtIndex:(leftday%100)/10];
    self.day3.image = [numberArray objectAtIndex:leftday%10];
    self.hour1.image = [numberArray objectAtIndex:lefthour/10];
    self.hour2.image = [numberArray objectAtIndex:lefthour%10];
    self.min1.image = [numberArray objectAtIndex:leftmin/10];
    self.min2.image = [numberArray objectAtIndex:leftmin%10];
    self.sec1.image = [numberArray objectAtIndex:leftsec/10];
    self.sec2.image = [numberArray objectAtIndex:leftsec%10];
}

-(void) preLoadPolygon {
    index = 0;
    
    NSMutableArray *myArray = [[NSMutableArray alloc] initWithCapacity:60];
    self.imageArray = myArray;
    [myArray release];
    
    [self.imageArray addObject:logoImage1];
    [self.imageArray addObject:logoImage2];
    [self.imageArray addObject:logoImage3];
    [self.imageArray addObject:logoImage4];
    [self.imageArray addObject:logoImage5];
    [self.imageArray addObject:logoImage6];
    [self.imageArray addObject:logoImage7];
    [self.imageArray addObject:logoImage8];
    [self.imageArray addObject:logoImage9];
    [self.imageArray addObject:logoImage10];
    [self.imageArray addObject:logoImage11];
    [self.imageArray addObject:logoImage12];
    [self.imageArray addObject:logoImage13];
    [self.imageArray addObject:logoImage14];
    [self.imageArray addObject:logoImage15];
    [self.imageArray addObject:logoImage16];
    [self.imageArray addObject:logoImage17];
    [self.imageArray addObject:logoImage18];
    [self.imageArray addObject:logoImage19];
    [self.imageArray addObject:logoImage20];
    [self.imageArray addObject:logoImage21];
    [self.imageArray addObject:logoImage22];
    [self.imageArray addObject:logoImage23];
    [self.imageArray addObject:logoImage24];
    [self.imageArray addObject:logoImage25];
    [self.imageArray addObject:logoImage26];
    [self.imageArray addObject:logoImage27];
    [self.imageArray addObject:logoImage28];
    [self.imageArray addObject:logoImage29];
    [self.imageArray addObject:logoImage30];
    [self.imageArray addObject:logoImage31];
    [self.imageArray addObject:logoImage32];
    [self.imageArray addObject:logoImage33];
    [self.imageArray addObject:logoImage34];
    [self.imageArray addObject:logoImage35];
    [self.imageArray addObject:logoImage36];
    [self.imageArray addObject:logoImage37];
    [self.imageArray addObject:logoImage38];
    [self.imageArray addObject:logoImage39];
    [self.imageArray addObject:logoImage40];
    [self.imageArray addObject:logoImage41];
    [self.imageArray addObject:logoImage42];
    [self.imageArray addObject:logoImage43];
    [self.imageArray addObject:logoImage44];
    [self.imageArray addObject:logoImage45];
    [self.imageArray addObject:logoImage46];
    [self.imageArray addObject:logoImage47];
    [self.imageArray addObject:logoImage48];
    [self.imageArray addObject:logoImage49];
    [self.imageArray addObject:logoImage50];
    [self.imageArray addObject:logoImage51];
    [self.imageArray addObject:logoImage52];
    [self.imageArray addObject:logoImage53];
    [self.imageArray addObject:logoImage54];
    [self.imageArray addObject:logoImage55];
    [self.imageArray addObject:logoImage56];
    [self.imageArray addObject:logoImage57];
    [self.imageArray addObject:logoImage58];
    [self.imageArray addObject:logoImage59];
    [self.imageArray addObject:logoImage60];
    
    for (int i=0; i<=59; i++) {
        UIImageView *view = (UIImageView *)[imageArray objectAtIndex:i];
        view.alpha = 0;
    }

}

-(void) loadPolygon {
        
    for (int i=0; i<=59; i++) {
        [NSTimer scheduledTimerWithTimeInterval:0.03*(i+1) target:self selector:@selector(startAnimation) userInfo:nil repeats:NO];
        
    }

}
-(void) loadLogoImage;
{
    UIImage *image1 = [UIImage imageNamed:@"logo1.png"];
  /*  UIImage *image2 = [UIImage imageNamed:@"logo2.png"];
    UIImage *image3 = [UIImage imageNamed:@"logo3.png"];
    UIImage *image4 = [UIImage imageNamed:@"logo4.png"];
    UIImage *image5 = [UIImage imageNamed:@"logo5.png"];
    NSArray *array = [[NSArray alloc] initWithObjects:image1,image2,image3,image4,image5, nil];*/
    UIImageView *iView = [[UIImageView alloc] initWithFrame:CGRectMake(35, 14, 178, 202)];
    iView.image = image1;
 //   self.logoImageView = iView;
 //   self.logoImageView.animationDuration = 10;
 //   self.logoImageView.animationImages = array;
    [self.view addSubview:self.logoImageView];
 //   [self.logoImageView startAnimating ];
//    [array release];
    [iView release];
}


-(void)PageTurnResponse:(UIPageControl *)thePageControl
{
    int choosePage = thePageControl.currentPage;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    imageScrollView.contentOffset = CGPointMake(344 * choosePage, 0.0f);
    [UIView commitAnimations];
}


-(void) startAnimation {
    CATransition *myTransition = [CATransition animation];
    
	myTransition.duration = 0.1;
	myTransition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    NSString *types[4] = {kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal, kCATransitionFade};
	NSString *subtypes[4] = {kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom};

	myTransition.type = types[0];

    myTransition.subtype = subtypes[random() % 4];
	myTransition.delegate = self;

    UIImageView *curView = (UIImageView *)[self.imageArray objectAtIndex:index];
    index ++;
    [curView.layer addAnimation:myTransition forKey:nil];
    curView.alpha = 1;

}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO]; 
}

- (void)dealloc {
    [countDownView release];
    [background2 release];
    [eventArray release];
    [imageScrollView release];
    [imagePageControl release];
    [imageArray release];
    [transition release];
    [logoImageView release];
    [day1 release];
    [day2 release];
    [day3 release];
    [hour1 release];
    [hour2 release];
    [min1 release];
    [min2 release];
    [sec1 release];
    [sec2 release];
    [numberArray release];
    [logoImage1 release];
    [logoImage2 release];
    [logoImage3 release];
    [logoImage4 release];
    [logoImage5 release];
    [logoImage6 release];
    [logoImage7 release];
    [logoImage8 release];
    [logoImage9 release];
    [logoImage10 release];
    [logoImage11 release];
    [logoImage12 release];
    [logoImage13 release];
    [logoImage14 release];
    [logoImage15 release];
    [logoImage16 release];
    [logoImage17 release];
    [logoImage18 release];
    [logoImage19 release];
    [logoImage20 release];
    [logoImage21 release];
    [logoImage22 release];
    [logoImage23 release];
    [logoImage24 release];
    [logoImage25 release];
    [logoImage26 release];
    [logoImage27 release];
    [logoImage28 release];
    [logoImage29 release];
    [logoImage31 release];
    [logoImage32 release];
    [logoImage33 release];
    [logoImage34 release];
    [logoImage35 release];
    [logoImage36 release];
    [logoImage37 release];
    [logoImage38 release];
    [logoImage39 release];
    [logoImage40 release];
    [logoImage41 release];
    [logoImage42 release];
    [logoImage43 release];
    [logoImage44 release];
    [logoImage45 release];
    [logoImage46 release];
    [logoImage47 release];
    [logoImage48 release];
    [logoImage49 release];
    [logoImage50 release];
    [logoImage51 release];
    [logoImage52 release];
    [logoImage53 release];
    [logoImage54 release];
    [logoImage55 release];
    [logoImage56 release];
    [logoImage57 release];
    [logoImage58 release];
    [logoImage59 release];
    [logoImage60 release];
    [super dealloc];
}

- (void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {

}

-(void)animationDidStart:(CAAnimation *)anim
{
    
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
}

#pragma mark -
#pragma mark scrollview delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{   
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
   
}

@end

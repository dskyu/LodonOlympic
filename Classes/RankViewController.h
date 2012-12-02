//
//  RankViewController.h
//  exploreolympic
//
//  Created by bunny on 12-4-13.
//  Copyright (c) 2012年 iDreamStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "OlmpicPageControl.h"
#import "RefreshView.h"

@interface RankViewController : UIViewController <RefreshViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIWebView *webView;
    NSMutableDictionary *dicNews;
    NSMutableDictionary *dicChina;
    NSMutableArray *arrayRankOld;
    NSMutableArray *arrayRankNew;
    UITableView *tableViewNews;
    UITableView *tableViewChina;
    UITableView *tableViewRankOld;
    UITableView *tableViewRankNew;
    
    NSMutableData *receviedDataNews;
    NSMutableData *receviedDataChina;
    RefreshView *refreshViewNews;
    RefreshView *refreshViewChina;
    
    UIImageView *gestureImageView;
    
}
@property (nonatomic, retain) IBOutlet UIImageView *gestureImageView;
@property (nonatomic, retain) IBOutlet UITableView *tableViewNews;
@property (nonatomic, retain) IBOutlet UITableView *tableViewChina;
@property (nonatomic, retain) IBOutlet UITableView *tableViewRankOld;
@property (nonatomic, retain) IBOutlet UITableView *tableViewRankNew;
@property (nonatomic, retain) RefreshView *refreshViewNews;
@property (nonatomic, retain) RefreshView *refreshViewChina;
@property (nonatomic ,retain) IBOutlet UIWebView *webView;
@property (nonatomic ,retain) NSMutableDictionary *dicNews;
@property (nonatomic ,retain) NSMutableDictionary *dicChina;
@property (nonatomic ,retain) NSMutableArray *arrayRankOld;
@property (nonatomic ,retain) NSMutableArray *arrayRankNew;
@property (nonatomic ,retain) NSMutableData *receviedDataNews;
@property (nonatomic ,retain) NSMutableData *receviedDataChina;
@end

//
//  ScheduleViewController.h
//  exploreolympic
//
//  Created by bunny on 12-3-28.
//  Copyright (c) 2012年 iDreamStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "exploreolympicAppDelegate.h"
#import "define.h"

typedef enum {
    ScheduleListByVenues,
    ScheduleListBySports,
    ScheduleListByDate,
    ScheduleListByMedal,
    ScheduleListByFavorite,
    ScheduleListAll
}ScheduleListType;

@interface ScheduleViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    UITableView *atableView;
    UITableView *btableView;
    DB *database;
    BOOL flag[5][3];
    NSMutableString *query;
    
    ScheduleListType scheduleListType;
    
    NSArray *super_eventArray;
    NSArray *dateArray;
    NSArray *venuesArray;
    NSArray *medalArray;
    NSArray *favoriteArray;
    
    NSUInteger super_eventCount;
    NSUInteger dateCount;
    NSUInteger venuesCount;
    NSUInteger medalCount;
    NSUInteger favoriteCount;
    
    NSDictionary *detailTableViewData;
    NSUInteger selectedIndex;
    UIView *detailView;
    
}

@property (nonatomic ,retain) IBOutlet UITableView *atableView;
@property (nonatomic ,retain) IBOutlet UITableView *btableView;
@property (nonatomic ,retain) IBOutlet UIView *detailView;
@property (nonatomic ,retain) NSMutableString *query;
@property (nonatomic ,retain) NSArray *super_eventArray;
@property (nonatomic ,retain) NSArray *dateArray;
@property (nonatomic ,retain) NSArray *venuesArray;
@property (nonatomic ,retain) NSArray *medalArray;
@property (nonatomic ,retain) NSArray *favoriteArray;
@property (readwrite) NSUInteger super_eventCount;
@property (readwrite) NSUInteger dateCount;
@property (readwrite) NSUInteger venuesCount;
@property (readwrite) NSUInteger medalCount;
@property (readwrite) NSUInteger favoriteCount;


@property (nonatomic ,retain) NSDictionary *detailTableViewData;
@property (readwrite) NSUInteger selectedIndex;
- (void) updateTableView;
- (IBAction)changeListType:(id)sender;

@end

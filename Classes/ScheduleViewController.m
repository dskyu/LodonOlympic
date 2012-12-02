//
//  ScheduleViewController.m
//  exploreolympic
//
//  Created by bunny on 12-3-28.
//  Copyright (c) 2012年 iDreamStudio. All rights reserved.
//

#import "ScheduleViewController.h"
#import "CustomDetailTableCell.h"

@implementation ScheduleViewController
@synthesize atableView,btableView;
@synthesize query,venuesArray,dateArray,super_eventArray,medalArray,favoriteArray;
@synthesize venuesCount,dateCount,super_eventCount,medalCount,favoriteCount;
@synthesize detailTableViewData,selectedIndex,detailView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = NSLocalizedString(@"赛程",@"tabItem4Title");
        self.tabBarItem.image = [UIImage imageNamed:@"schedule.png"];
    }
    return self;
}

- (void)viewDidLoad
{  
    [super viewDidLoad];
    
    exploreolympicAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    database = appDelegate.database;
    scheduleListType = ScheduleListByVenues;
    
    NSMutableString *myQuery = [[NSMutableString alloc] initWithCapacity:100];
    self.query = myQuery;
    [myQuery release];
    
    [query setString:@"select id,zh_name from sport"];
    super_eventArray = [database fetchQuery:query];
    super_eventCount = [super_eventArray count]/2;
    
    [query setString:@"select distinct date from schedule"];
    dateArray = [database fetchQuery:query];
    dateCount = [dateArray count];
    
    [query setString:@"select id,zh_name from venues"];
    venuesArray = [database fetchQuery:query];
    venuesCount = [venuesArray count]/2;
    
    [query setString:@"select distinct date from schedule"];
    medalArray = [database fetchQuery:query];
    medalCount = [medalArray count];
    
	memset(flag, YES, sizeof(flag));
    
    detailView.alpha = 0;
    detailView.frame = ScheduleListViewFrameOut;
    atableView.frame = ScheduleNavViewFrameNormal;
    UISwipeGestureRecognizer *gestureRecognizer1 = [[UISwipeGestureRecognizer alloc]  initWithTarget:self action:@selector(moveToLeft:)];
    [gestureRecognizer1 setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.detailView addGestureRecognizer:gestureRecognizer1];
    [gestureRecognizer1 release];

}

- (void)moveToLeft:(id) sender
{
    [UIView animateWithDuration:ScheduleListViewSwitchDuration 
                     animations:^{
                         detailView.alpha = 0;
                         detailView.frame = ScheduleListViewFrameOut;
                         atableView.frame = ScheduleNavViewFrameNormal;
                     }
                     completion:^(BOOL finished){
            
                     }];   
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void) dealloc
{
    [super dealloc];
    [atableView release];
    [btableView release];
    [query release];
    [dateArray release];
    [super_eventArray release];
    [venuesArray release];
    [medalArray release];
    [favoriteArray release];
    [detailTableViewData release];
    [detailView release];
}

- (void) updateTableView
{
    [btableView reloadData];
}

- (IBAction)changeListType:(id)sender
{
    UIButton *button = (UIButton *) sender;
    ScheduleListType type = ScheduleListByVenues;
    switch (button.tag) {
        case 401:
            type = ScheduleListByVenues;
            break;
        case 402:
            type = ScheduleListBySports;
            break;
        case 403:
            type = ScheduleListByDate;
            break;
        case 404:
            type = ScheduleListByMedal;
            break;  
        case 405:
            type = ScheduleListByFavorite;
            break;  
        default:
            break;
    }
    [query setString:@"select distinct date from schedule where favorite = 1"];
    favoriteArray = [database fetchQuery:query];
    favoriteCount = [favoriteArray count];
    
    if (type != scheduleListType) {
        scheduleListType = type;
        [atableView reloadData];
    }
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger result = 0;
    
    if (tableView.tag == 1) {
        switch (scheduleListType) {
            case ScheduleListByVenues:
                result = 3;
                break;
            case ScheduleListBySports:
                result = 1;
                break;
            case ScheduleListByDate:
                result = 1;
                break;
            case ScheduleListByMedal:
                result = 1;
                break;
            case ScheduleListByFavorite:
                result = 1;
                break;
            default:
                break;
        }
    }
    else if(tableView.tag == 2){
        result = 1;
    }
    
    return result;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int result = 0;
    
    if (tableView.tag == 1) {
        switch (scheduleListType) {
            case ScheduleListByVenues:
                if (flag[0][section]) {
                    switch (section) {
                        case 0:
                            result = VenueRow0Number;
                            break;
                        case 1:
                            result = VenueRow1Number - 1;
                            break;
                        case 2:
                            result = VenueRow2Number - 1;
                            break;
                        default:
                            break;
                    }
                }
                else {
                    result =  0;
                }
                break;
            case ScheduleListBySports:
                if (flag[1][section]) {
                    result = super_eventCount;
                }
                else {
                    result =  0;
                }
                
                break;
            case ScheduleListByDate:
                if (flag[2][section]) {
                    result = dateCount;
                }
                else {
                    result =  0;
                }
                
                break;
            case ScheduleListByMedal:
                if (flag[3][section]) {
                    result = medalCount;
                }
                else {
                    result =  0;
                }
                break;
            case ScheduleListByFavorite:
                result = favoriteCount;
                if (result == 0) {
                    result = 1;
                }
                break;
            default:
                break;
        }
    }
    else if(tableView.tag == 2){
        NSArray *dataArray = [detailTableViewData allValues];
        if ([dataArray count]  == 0) {
            return 1;
        }
        result = ([dataArray count]+1)/2;
    }
    
    
    return result;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 1) {
        UIButton *abtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        UIImage *image = [UIImage imageNamed:@"headerimage.png"];
        [abtn setBackgroundImage:image forState:UIControlStateNormal];
        [abtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        abtn.titleLabel.textAlignment = UITextAlignmentLeft;
        abtn.frame = CGRectMake(0, 0, 280, 25);
        abtn.tag = section;
        [abtn addTarget:self action:@selector(headerClicked:) forControlEvents:UIControlEventTouchUpInside];
    
        
        switch (scheduleListType) {
            case ScheduleListByVenues:
                switch (section) {
                    case 0:
                        [abtn setTitle:@"奥林匹克公园" forState:UIControlStateNormal];
                        break;
                    case 1:
                        [abtn setTitle:@"伦敦地区场馆" forState:UIControlStateNormal];
                        break;
                    case 2:
                        [abtn setTitle:@"其它地区场馆" forState:UIControlStateNormal];
                        break;
                    default:
                        break;
                }
                break;
            case ScheduleListBySports:
                [abtn setTitle:@"运动项目" forState:UIControlStateNormal];
                break;
            case ScheduleListByDate:
                [abtn setTitle:@"比赛日期" forState:UIControlStateNormal];
                break;
            case ScheduleListByMedal:
                [abtn setTitle:@"金牌赛程" forState:UIControlStateNormal];
                break;
            case ScheduleListByFavorite:
                [abtn setTitle:@"关注赛事" forState:UIControlStateNormal];
                break;
            default:
                break;
        }
        
        return abtn;
    }
    else if(tableView.tag == 2){
        UIButton *abtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        abtn.hidden = YES;
        return abtn;

    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 2) {
        return 136;
    }
    return 44;
}

-(void)headerClicked:(id)sender
{
	int sectionIndex = ((UIButton*)sender).tag;
    switch (scheduleListType) {
        case ScheduleListByVenues:
            flag[0][sectionIndex] = !flag[0][sectionIndex];
            break;
        case ScheduleListBySports:
            flag[1][sectionIndex] = !flag[1][sectionIndex];
            break;
        case ScheduleListByDate:
            flag[2][sectionIndex] = !flag[2][sectionIndex];
            break;
        case ScheduleListByMedal:
            flag[3][sectionIndex] = !flag[3][sectionIndex];
            break;
        case ScheduleListByFavorite:
            flag[4][sectionIndex] = !flag[4][sectionIndex];
            break;
        default:
            break;
    }
	
	[atableView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.tag == 1) {
        static NSString *CellIdentifier = @"Cell";
        NSInteger temp;
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
        switch (scheduleListType) {
            case ScheduleListByVenues:
                switch (indexPath.section) {
                    case 0:
                        cell.textLabel.text = [venuesArray objectAtIndex:indexPath.row*2+1];
                        break;
                    case 1:
                        temp = 1 + VenueRow0Number + indexPath.row;
                        if (temp >= 19) temp++;
                        cell.textLabel.text = [venuesArray objectAtIndex:(temp)*2+1];
                        break;
                    case 2:
                        cell.textLabel.text = [venuesArray objectAtIndex:(1 + VenueRow0Number + VenueRow1Number + indexPath.row)*2+1];
                        break;
                        
                    default:
                        break;
                } 
                break;
            case ScheduleListBySports:
                cell.textLabel.text = [super_eventArray objectAtIndex:indexPath.row*2+1];
                break;
            case ScheduleListByDate:
                cell.textLabel.text = [NSString stringWithFormat:@"%@赛事",[dateArray objectAtIndex:indexPath.row]];
                break;
            case ScheduleListByMedal:
                cell.textLabel.text = [NSString stringWithFormat:@"%@金牌赛",[medalArray objectAtIndex:indexPath.row]];
                break;
            case ScheduleListByFavorite:
                if (favoriteCount == 0) {
                    cell.textLabel.text = @"无关注赛事";
                    break;
                }
                cell.textLabel.text = [NSString stringWithFormat:@"%@比赛关注",[favoriteArray objectAtIndex:indexPath.row]];
                break;
            default:
                break;
        }
        
        return cell;
    }
    else if(tableView.tag == 2) 
    {
        static NSString *CellIdentifier = @"CustomCell";
        CustomDetailTableCell *CustomCell = nil;
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomDetailTableCell" owner:self options:nil];
            for (id oneObject in nib) {
                if ([oneObject isKindOfClass:[CustomDetailTableCell class]])
                    CustomCell = (CustomDetailTableCell *) oneObject;
            }
        }
        CustomCell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *array = [detailTableViewData allValues];
        if ([array count] == 0) {
            CustomCell.contentLabel.frame = CGRectMake(108, 42, 459, 40);
            CustomCell.contentLabel.font = [UIFont boldSystemFontOfSize:30];
            CustomCell.contentLabel.text = @"您还没有关注任何赛事哦，赶快去关注吧!";
            CustomCell.sportImageView.image = nil;
            [CustomCell.medalButton setImage:nil forState:UIControlStateNormal];
            [CustomCell.favoriteButton setImage:nil forState:UIControlStateNormal];
            CustomCell.londonTimeLabel.text = @"";
            CustomCell.beijingTimeLabel.text = @"";
            CustomCell.sportTitleLabel.text = @"";
            CustomCell.venuesLabel.text = @"";
            CustomCell.contentLabel2.text = @"";
            CustomCell.sportImageView2.image = nil;
            [CustomCell.medalButton2 setImage:nil forState:UIControlStateNormal];
            [CustomCell.favoriteButton2 setImage:nil forState:UIControlStateNormal];
            CustomCell.londonTimeLabel2.text = @"";
            CustomCell.beijingTimeLabel2.text = @"";
            CustomCell.sportTitleLabel2.text = @"";
            CustomCell.venuesLabel2.text = @"";
            CustomCell.midline.image = nil;
            CustomCell.underline.image = nil;
            CustomCell.underline2.image = nil;
            
            cell = CustomCell;
            return cell;
        }
        if (!detailTableViewData) {
            return CustomCell;
        }
        
        NSArray *dataArray = [detailTableViewData valueForKey:[NSString stringWithFormat:@"%d",indexPath.row*2]];

        if (dataArray == nil) {
            cell = CustomCell;
            return cell;
        }
        
        NSString *londonDate = [dataArray objectAtIndex:6];
        NSString *londonTime = [dataArray objectAtIndex:1];
        NSString *beijingDateAndTime = [dataArray objectAtIndex:2];
        NSString *sportTitle = [dataArray objectAtIndex:3];
        NSString *content = [dataArray objectAtIndex:4];
        NSString *venues = [dataArray objectAtIndex:5];
        NSString *hasMedal = [dataArray objectAtIndex:8];
        NSMutableString *favorite = [dataArray objectAtIndex:9];
        NSString *sportIndex = [dataArray objectAtIndex:10];
        
        UIImage *image1 = [UIImage imageNamed:[NSString stringWithFormat:@"sport%d.png",[sportIndex intValue] - 1]];
        CustomCell.sportImageView.image = image1;
        if ([hasMedal isEqualToString:@"0"]) {
            [CustomCell.medalButton setImage:nil forState:UIControlStateNormal];
        }
        
        if ([favorite isEqualToString:@"1"]) {
            UIImage *image3 = [UIImage imageNamed:@"favorite.png"];
            [CustomCell.favoriteButton setImage:image3 forState:UIControlStateNormal];
        }
        
        CustomCell.londonTimeLabel.text = [NSString stringWithFormat:@"伦敦时间：%@ %@",londonDate,londonTime];
        CustomCell.beijingTimeLabel.text = [NSString stringWithFormat:@"北京时间：%@",beijingDateAndTime];
        CustomCell.venuesLabel.text = [NSString stringWithFormat:@"比赛场馆：%@",venues];
        CustomCell.sportTitleLabel.text = sportTitle;
        CustomCell.contentLabel.text = content;
        
        CustomCell.favoriteButton.tag = indexPath.row*2;
        [CustomCell.favoriteButton addTarget:self action:@selector(favoriteTouched:) forControlEvents:UIControlEventTouchUpInside];
        [CustomCell.medalButton addTarget:self action:@selector(medalTouched:) forControlEvents:UIControlEventTouchUpInside];
        
        NSArray *dataArray2 = [detailTableViewData valueForKey:[NSString stringWithFormat:@"%d",indexPath.row*2+1]];
        
        if (dataArray2 == nil) {
            CustomCell.contentLabel2.text = @"";
            CustomCell.sportImageView2.image = nil;
            [CustomCell.medalButton2 setImage:nil forState:UIControlStateNormal];
            [CustomCell.favoriteButton2 setImage:nil forState:UIControlStateNormal];
            CustomCell.londonTimeLabel2.text = @"";
            CustomCell.beijingTimeLabel2.text = @"";
            CustomCell.sportTitleLabel2.text = @"";
            CustomCell.venuesLabel2.text = @"";

            cell = CustomCell;
            return cell;
        }
        
        NSString *londonDate2 = [dataArray2 objectAtIndex:6];
        NSString *londonTime2 = [dataArray2 objectAtIndex:1];
        NSString *beijingDateAndTime2 = [dataArray2 objectAtIndex:2];
        NSString *sportTitle2 = [dataArray2 objectAtIndex:3];
        NSString *content2 = [dataArray2 objectAtIndex:4];
        NSString *venues2 = [dataArray2 objectAtIndex:5];
        NSString *hasMedal2 = [dataArray2 objectAtIndex:8];
        NSMutableString *favorite2 = [dataArray2 objectAtIndex:9];
        NSString *sportIndex2 = [dataArray2 objectAtIndex:10];
        
        UIImage *image2 = [UIImage imageNamed:[NSString stringWithFormat:@"sport%d.png",[sportIndex2 intValue] - 1]];
        CustomCell.sportImageView2.image = image2;
        if ([hasMedal2 isEqualToString:@"0"]) {
            [CustomCell.medalButton2 setImage:nil forState:UIControlStateNormal];
        }
        
        if ([favorite2 isEqualToString:@"1"]) {
            UIImage *image3 = [UIImage imageNamed:@"favorite.png"];
            [CustomCell.favoriteButton2 setImage:image3 forState:UIControlStateNormal];
        }
        
        CustomCell.londonTimeLabel2.text = [NSString stringWithFormat:@"伦敦时间：%@ %@",londonDate2,londonTime2];
        CustomCell.beijingTimeLabel2.text = [NSString stringWithFormat:@"北京时间：%@",beijingDateAndTime2];
        CustomCell.venuesLabel2.text = [NSString stringWithFormat:@"比赛场馆：%@",venues2];
        CustomCell.sportTitleLabel2.text = sportTitle2;
        CustomCell.contentLabel2.text = content2;
        
        CustomCell.favoriteButton2.tag = indexPath.row*2+1;
        [CustomCell.favoriteButton2 addTarget:self action:@selector(favoriteTouched:) forControlEvents:UIControlEventTouchUpInside];
        [CustomCell.medalButton2 addTarget:self action:@selector(medalTouched:) forControlEvents:UIControlEventTouchUpInside]; 

        cell = CustomCell;
        return cell;
    }
    
    return nil;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.tag == 1) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        NSMutableString *string;
        NSInteger temp;
        switch (scheduleListType) {
            case ScheduleListByVenues:
                
                switch (indexPath.section) {
                    case 0:
                        [query setString:[NSString stringWithFormat:@"select * from schedule where venues_id = %d;",indexPath.row + 1]];
                        break;
                    case 1:
                        temp = 1 + VenueRow0Number + indexPath.row + 1;
                        if (temp >= 20) temp++;
                        [query setString:[NSString stringWithFormat:@"select * from schedule where venues_id = %d;",temp]];
                        break;
                    case 2:
                        [query setString:[NSString stringWithFormat:@"select * from schedule where venues_id = %d;",1 + VenueRow0Number + VenueRow1Number + indexPath.row + 1]];
                        break;
                    default:
                        break;
                }
                
                
                break;
            case ScheduleListBySports:
                [query setString:[NSString stringWithFormat:@"select * from schedule where super_event_id = %d;",indexPath.row + 1]];
                break;
            case ScheduleListByDate:
                string = [NSMutableString stringWithString:cell.textLabel.text];
                [query setString:[NSString stringWithFormat:@"select * from schedule where date = \"%@\";",[string substringToIndex:[string length] - 2]]];
                break;
            case ScheduleListByMedal:
                string = [NSMutableString stringWithString:cell.textLabel.text];
                [query setString:[NSString stringWithFormat:@"select * from schedule where haveresult = 1 and date = \"%@\";",[string substringToIndex:[string length] - 3]]];
                break;
            case ScheduleListByFavorite:
                string = [NSMutableString stringWithString:cell.textLabel.text];
                [query setString:[NSString stringWithFormat:@"select * from schedule where favorite = 1 and date = \"%@\";",[string substringToIndex:[string length] - 4]]];
                break;
            default:
                break;
        }
        detailTableViewData = [database fetchMutliQuery:query];
        [self updateTableView];
        
        if (CGRectEqualToRect(atableView.frame, ScheduleNavViewFrameOffset) ) {
            [UIView animateWithDuration:ScheduleListViewSwitchDuration 
                             animations:^{
                                 detailView.alpha = 0;
                                 detailView.frame = ScheduleListViewFrameOut;
                             }
                             completion:^(BOOL finished){
                                 [UIView animateWithDuration:ScheduleListViewSwitchDuration 
                                                  animations:^{
                                                      detailView.alpha = 1;
                                                      detailView.frame = ScheduleListViewFrameIn;

                                                  }
                                                  completion:^(BOOL finished){
                                                      
                                                  }]; 
                             }]; 
        }else {
            [UIView animateWithDuration:ScheduleListViewSwitchDuration 
                             animations:^{
                                 detailView.alpha = 1;
                                 detailView.frame = ScheduleListViewFrameIn;
                                 atableView.frame = ScheduleNavViewFrameOffset;
                             }
                             completion:^(BOOL finished){
                                 
                             }]; 
        }
        
        
    }
    else if (tableView.tag == 2) {
        
    }
}
#pragma mark -
#pragma mark button method


- (void)medalTouched:(id) sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"伦敦奥运金牌"
                                                    message:@""
                                                   delegate:self
                                          cancelButtonTitle:@"确定" 
                                          otherButtonTitles:nil];
    alert.tag = 100;
    UIImageView *view1 = [[UIImageView alloc] initWithFrame:CGRectMake(30.0, 120.0, 220.0, 220.0)];
    view1.image = [UIImage imageNamed:@"goldenmedal1.png"];
    [alert addSubview:view1];
    [view1 release];
    UIImageView *view2 = [[UIImageView alloc] initWithFrame:CGRectMake(30.0, 360.0, 220.0, 220.0)];
    view2.image = [UIImage imageNamed:@"goldenmedal2.png"];
    [alert addSubview:view2];
    [view2 release];
    [alert show];
    [alert release];
}

- (void)favoriteTouched:(id) sender
{
    UIButton *button = (UIButton *)sender;
    selectedIndex = button.tag;
    
    NSArray *array = [detailTableViewData valueForKey:[NSString stringWithFormat:@"%d",selectedIndex]];
    NSString *sql = [[NSString alloc] initWithFormat:@"select favorite from schedule where id = %@",[array objectAtIndex:0]];
    NSArray *result = [database fetchQuery:sql];
    [sql release];
    if ([[result objectAtIndex:0] isEqualToString:@"0"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"关注"
                                                        message:@"是否要关注该项赛事？"
                                                       delegate:self 
                                              cancelButtonTitle:@"我要"
                                              otherButtonTitles:@"不需要", nil];
        alert.tag = 200;
        [alert show];
        [alert release];
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"关注"
                                                        message:@"是否要取消关注该项赛事？"
                                                       delegate:self 
                                              cancelButtonTitle:@"取消关注"
                                              otherButtonTitles:@"不需要", nil];
        alert.tag = 201;
        [alert show];
        [alert release];
    }
}



#pragma mark -
#pragma mark alert view delegate

- (void)willPresentAlertView:(UIAlertView *)alertView {
    if (alertView.tag == 100) {
        alertView.frame = CGRectMake((1024-280)/2,(768-600)/2, 280, 600);
    }
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    if (buttonIndex == 0) {
        if (alertView.tag == 200) {
            NSArray *array = [detailTableViewData valueForKey:[NSString stringWithFormat:@"%d",selectedIndex]];
            NSString *sql = [[NSString alloc] initWithFormat:@"UPDATE schedule SET favorite = 1 WHERE id = %@",[array objectAtIndex:0]];
            if ([database execQuery:sql]) {
                CustomDetailTableCell *cell = (CustomDetailTableCell *)[btableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex/2 inSection:0]];
                UIImage *image3 = [UIImage imageNamed:@"favorite.png"];
                if (selectedIndex%2 == 0) {
                    [cell.favoriteButton setImage:image3 forState:UIControlStateNormal];
                }else {
                    [cell.favoriteButton2 setImage:image3 forState:UIControlStateNormal];
                }
                
            }
            [sql release];
            NSMutableString *favorite = [array objectAtIndex:9];
            [favorite setString:@"1"];
            
            
            NSInteger schedule_id = [(NSString *)[array objectAtIndex:0] integerValue];
            NSString *sql1 = [[NSString alloc] initWithFormat:@"select beijing_time,sub_event,haveresult from schedule WHERE id = %d",schedule_id];
            NSArray *notificationArray = [database fetchQuery:sql1];
            [sql1 release];
            
            UILocalNotification *notification=[[UILocalNotification alloc] init]; 
            NSString *alertText = [NSString stringWithFormat:@"%@，将在10分钟后开赛！",(NSString *)[notificationArray objectAtIndex:1]];
            
            NSLocale *Locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setLocale:Locale];
            [dateFormatter setDateFormat:@"yyyy年MM月d日 HH:mm:ss"];
            NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"2012年%@:00",[notificationArray objectAtIndex:0]]];
            [Locale release];
            [dateFormatter release];
            
            notification.fireDate=[date dateByAddingTimeInterval:-600]; 
            notification.timeZone=[NSTimeZone defaultTimeZone]; 
            notification.alertBody = alertText;
            [notification setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",schedule_id], [NSString stringWithFormat:@"key%d",schedule_id], nil]];
            [[UIApplication sharedApplication] scheduleLocalNotification:notification];
            [notification release];
            
        }else if (alertView.tag == 201) {
            
            NSArray *array = [detailTableViewData valueForKey:[NSString stringWithFormat:@"%d",selectedIndex]];
            NSInteger schedule_id = [(NSString *)[array objectAtIndex:0] integerValue];
            NSString *sql = [[NSString alloc] initWithFormat:@"UPDATE schedule SET favorite = 0 WHERE id = %d",schedule_id];
            if ([database execQuery:sql]) {
                CustomDetailTableCell *cell = (CustomDetailTableCell *)[btableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex/2 inSection:0]];
                UIImage *image3 = [UIImage imageNamed:@"favorite1.png"];

                if (selectedIndex%2 == 0) {
                    [cell.favoriteButton setImage:image3 forState:UIControlStateNormal];
                }else {
                    [cell.favoriteButton2 setImage:image3 forState:UIControlStateNormal];
                }
                
            }
            [sql release];
            NSMutableString *favorite = [array objectAtIndex:9];
            [favorite setString:@"0"];
            
            
            NSArray *myArray = [[UIApplication sharedApplication] scheduledLocalNotifications]; 
            for (int i=0; i<[myArray count]; i++) { 
                UILocalNotification *myUILocalNotification=[myArray objectAtIndex:i]; 
                if ([[[myUILocalNotification userInfo] objectForKey:[NSString stringWithFormat:@"key%d",schedule_id]] intValue]==schedule_id) { 
                    [[UIApplication sharedApplication] cancelLocalNotification:myUILocalNotification]; 
                } 
            } 
        }
        
    }
}

@end

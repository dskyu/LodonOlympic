//
//  MapTypeViewController.h
//  exploreolympic
//
//  Created by bunny on 12-4-13.
//  Copyright (c) 2012年 iDreamStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapTypeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView *mapTableView;

}
@property (nonatomic ,retain) IBOutlet UITableView *mapTableView;

@end

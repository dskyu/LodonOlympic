//
//  CustomMoviePlayerViewController.h
//  exploreolympic
//
//  Created by bunny on 12-5-14.
//  Copyright (c) 2012年 iDreamStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface CustomMoviePlayerViewController : UIViewController
{ 
    MPMoviePlayerController *mp; 
    NSURL *movieURL; //视频地址 
    UIActivityIndicatorView *loadingAni; //加载动画 
    UILabel *label; //加载提醒 
    BOOL timeout;
} 
@property (readwrite) BOOL timeout; 
@property (nonatomic,retain) NSURL *movieURL; 

//准备播放 
- (void)readyPlayer; 
@end

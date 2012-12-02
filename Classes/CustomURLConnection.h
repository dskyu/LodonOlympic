//
//  CustomURLConnection.h
//  exploreolympic
//
//  Created by bunny on 12-5-15.
//  Copyright (c) 2012年 iDreamStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomURLConnection : NSURLConnection
{
    int tag; 
} 
@property (nonatomic, assign) int tag; 
@end

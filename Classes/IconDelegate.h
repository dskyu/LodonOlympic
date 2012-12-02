//
//  IconDelegate.h
//  exploreolympic
//
//  Created by bunny on 12-4-3.
//  Copyright (c) 2012年 iDreamStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IconDelegate <NSObject>

- (void) tapIcon:(id)sender;
@optional
- (void) moveToTop:(id)sender;
- (void) moveToBottom:(id)sender;
@end

//
//  GameIcon.h
//  exploreolympic
//
//  Created by bunny on 12-4-7.
//  Copyright (c) 2012年 iDreamStudio. All rights reserved.
//

#import "Icon.h"

@interface GameIcon : Icon {
    id <IconDelegate> delegate;
}

@property(nonatomic,retain) id <IconDelegate> delegate;
@end

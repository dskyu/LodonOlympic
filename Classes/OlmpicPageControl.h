//
//  OlmpicPageControl.h
//  exploreolympic
//
//  Created by bunny on 12-3-28.
//  Copyright (c) 2012年 iDreamStudio. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OlmpicPageControl : UIPageControl <UIScrollViewDelegate>
{   
    UIScrollView *aScrollView;
    UIImage *imagePageStateNormal;   
    UIImage *imagePageStateHighlighted;   
}   
- (id)initWithFrame:(CGRect)frame AndScrollView:(UIScrollView *)scrollView;   
 
@property (nonatomic, retain) UIScrollView *aScrollView; 
@property (nonatomic, retain) UIImage *imagePageStateNormal;   
@property (nonatomic, retain) UIImage *imagePageStateHighlighted;   
@end  





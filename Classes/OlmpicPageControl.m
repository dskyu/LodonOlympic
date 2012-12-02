//
//  OlmpicPageControl.m
//  exploreolympic
//
//  Created by bunny on 12-3-28.
//  Copyright (c) 2012年 iDreamStudio. All rights reserved.
//

#import "OlmpicPageControl.h"

@interface OlmpicPageControl(private)  
- (void)updateDots;   
@end   

@implementation OlmpicPageControl
@synthesize aScrollView;
@synthesize imagePageStateNormal;   
@synthesize imagePageStateHighlighted;   

- (id)initWithFrame:(CGRect)frame AndScrollView:(UIScrollView *)scrollView;  
{
    self = [super initWithFrame:frame];
    if (self) {
        self.aScrollView = scrollView;
        aScrollView.pagingEnabled = YES;
        [aScrollView setShowsHorizontalScrollIndicator:FALSE];
        [aScrollView setBackgroundColor:[UIColor clearColor]];
        aScrollView.delegate = self;
        [self addSubview:aScrollView];
        
        [self addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}


- (void)setImagePageStateNormal:(UIImage *)image {  // 设置正常状态点按钮的图片   
    [imagePageStateHighlighted release];   
    imagePageStateHighlighted = [image retain];   
    [self updateDots];   
}   
- (void)setImagePageStateHighlighted:(UIImage *)image { // 设置高亮状态点按钮图片   
    [imagePageStateNormal release];   
    imagePageStateNormal = [image retain];   
    [self updateDots];   
}   
- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event { // 点击事件   
    [super endTrackingWithTouch:touch withEvent:event];   
    [self updateDots];   
}   
- (void)updateDots { // 更新显示所有的点按钮   
    if (imagePageStateNormal || imagePageStateHighlighted)   
    {   
        NSArray *subview = self.subviews;  // 获取所有子视图   
        for (NSInteger i = 0; i < [subview count]; i++)   
        {   
            UIImageView *dot = [subview objectAtIndex:i];  // 以下不解释, 看了基本明白   
            dot.image = self.currentPage == i ? imagePageStateNormal : imagePageStateHighlighted;   
        }   
    }   
}   
- (void)dealloc { 
    [imagePageStateNormal release], imagePageStateNormal = nil;   
    [imagePageStateHighlighted release], imagePageStateHighlighted = nil; 
    [aScrollView release]; aScrollView = nil;
    [super dealloc];   
}   

- (void)pageTurn:(UIPageControl *) pageControl
{
    int currentPage = [pageControl currentPage];
    [aScrollView setContentOffset:CGPointMake(currentPage*aScrollView.frame.size.width, 0) animated:YES];
}

#pragma mark -
#pragma mark scroll delegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    self.currentPage = index;
}

@end

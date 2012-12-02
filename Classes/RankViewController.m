//
//  RankViewController.m
//  exploreolympic
//
//  Created by bunny on 12-4-13.
//  Copyright (c) 2012年 iDreamStudio. All rights reserved.
//

#import "RankViewController.h"
#import "CustomMoviePlayerViewController.h"
#import "define.h"
#import "CustomURLConnection.h"

@interface RankViewController (private)
- (void)refresh;
- (void)stopLoading;
- (void)startLoading;
@end

@implementation RankViewController
@synthesize webView;
@synthesize dicNews;
@synthesize dicChina;
@synthesize arrayRankOld;
@synthesize arrayRankNew;
@synthesize tableViewNews;
@synthesize tableViewChina;
@synthesize tableViewRankNew;
@synthesize tableViewRankOld;
@synthesize refreshViewNews;
@synthesize refreshViewChina;
@synthesize receviedDataNews,receviedDataChina;
@synthesize gestureImageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = NSLocalizedString(@"实时资讯",@"tabItem5Title");
        self.tabBarItem.image = [UIImage imageNamed:@"news.png"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSMutableArray *array1 = [[NSMutableArray alloc] initWithObjects:@"1	  中国	51	21	28	100",
                              @"2	  美国	36	38	36	110",
                              @"3	 俄罗斯	23	21	28	72",
                              @"4	  英国	19	13	15	47",
                              @"5	  德国	16	10	15	41",
                              nil];
    self.arrayRankOld = array1;
    [array1 release];
    
    NSMutableArray *array2 = [[NSMutableArray alloc] initWithObjects:@"敬请期待",nil];
    self.arrayRankNew = array2;
    [array2 release];
    
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithCapacity:500];
    self.dicNews = dictionary;
    [dictionary release];
    
    NSMutableDictionary *dictionary2 = [[NSMutableDictionary alloc] initWithCapacity:500];
    self.dicChina = dictionary2;
    [dictionary2 release];
    

    webView.frame = NewsWebViewRightOut;
    webView.multipleTouchEnabled = YES;
    webView.scalesPageToFit = YES;
    gestureImageView.frame = NewsGestureViewLeftOut;
    
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(hideWebView:)];
    [swipeGesture setDirection:UISwipeGestureRecognizerDirectionRight];
    [swipeGesture setNumberOfTouchesRequired:2];
    [webView addGestureRecognizer:swipeGesture];
    [swipeGesture release];
    
    UISwipeGestureRecognizer *swipeGesture2 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(hideWebView:)];
    [swipeGesture2 setDirection:UISwipeGestureRecognizerDirectionLeft];
    [swipeGesture2 setNumberOfTouchesRequired:2];
    [webView addGestureRecognizer:swipeGesture2];
    [swipeGesture2 release];

    NSArray *nils = [[NSBundle mainBundle]loadNibNamed:@"RefreshView" owner:self options:nil];
    self.refreshViewNews = [nils objectAtIndex:0];
    [refreshViewNews setupWithOwner:tableViewNews delegate:self];
    
    NSArray *nils1 = [[NSBundle mainBundle]loadNibNamed:@"RefreshView" owner:self options:nil];
    self.refreshViewChina = [nils1 objectAtIndex:0];
    [refreshViewChina setupWithOwner:tableViewChina delegate:self];
    
    [self refresh:tableViewNews];
    [self refresh:tableViewChina];
}



-(void) hideWebView:(id) sender
{
    UISwipeGestureRecognizer *gesture = (UISwipeGestureRecognizer *) sender;
    
    [UIView animateWithDuration:NewsContentSwitchDuration
                     animations:^{
                         if (gesture.direction == UISwipeGestureRecognizerDirectionLeft) {
                             webView.frame = NewsWebViewLeftOut;
                             gestureImageView.frame = NewsGestureViewRightOut;
                         }
                         if (gesture.direction == UISwipeGestureRecognizerDirectionRight) {
                             webView.frame = NewsWebViewRightOut;
                             gestureImageView.frame = NewsGestureViewLeftOut;
                         }
                         gestureImageView.alpha = 0;
                         webView.alpha = 0;

                     }completion:^(BOOL finished){
                         
                     }];
}

-(void) showWebView:(id) sender
{
    UITableView *tableView = (UITableView *)sender;
    [UIView animateWithDuration:NewsContentSwitchDuration
                     animations:^{
                         if (tableView.tag == 201) {
                             webView.frame = NewsWebViewRightIn;
                             gestureImageView.frame = NewsGestureViewLeftIn;
                         }else if (tableView.tag == 204) {
                             webView.frame = NewsWebViewLeftIn;
                             gestureImageView.frame = NewsGestureViewRightIn;
                         }
                         gestureImageView.alpha = 1;
                         webView.alpha = 1;
                         
                     }completion:^(BOOL finished){
                         
                     }];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response    
{    
    CustomURLConnection *conn = (CustomURLConnection*)connection;
    if (conn.tag == 1) {
        [receviedDataNews setLength:0]; 
    }else if (conn.tag == 4) {
        [receviedDataChina setLength:0]; 
    }
    
    
}    

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data    
{    
    CustomURLConnection *conn = (CustomURLConnection*)connection;
    if (conn.tag == 1) {
        [receviedDataNews appendData:data];
    }else if (conn.tag == 4) {
        [receviedDataChina appendData:data]; 
    }
    
}    

- (void)connectionDidFinishLoading:(NSURLConnection *)connection    
{    
    
    CustomURLConnection *conn = (CustomURLConnection*)connection;
    if (conn.tag == 1) {
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);    
        NSString *html = [[NSString alloc] initWithData:receviedDataNews encoding:enc];
        
        if ([html isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"网络获取失败"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
            return;
        }
        
        NSString *str1 = [html substringFromIndex:[html rangeOfString:@"<div class=\"mod newslist\"><ul><li>"].location];
        [html release];
        
        NSString *str2 = [str1 substringToIndex:[str1 rangeOfString:@"</li></ul></div>"].location];
        
        NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"<li>·<a\\starget=\"_blank\"\\shref=\".*?\">.*?</a>" options:NSRegularExpressionAllowCommentsAndWhitespace error:nil];
        NSArray *array = [regular matchesInString:str2 options:0 range:NSMakeRange(0, [str2 length])];
        for (NSTextCheckingResult *match in array)   
        {  
            NSRange firstHalfRange = [match rangeAtIndex:0];
            NSString *result1=[str2 substringWithRange:firstHalfRange];  
            
            NSString *temp = [result1 substringFromIndex:[result1 rangeOfString:@"http"].location];
            NSString *value = [temp substringToIndex:[temp rangeOfString:@"\">"].location];
            
            NSString *temp1 = [result1 substringFromIndex:[result1 rangeOfString:@"\">"].location+[result1 rangeOfString:@"\">"].length];
            NSString *key = [temp1 substringToIndex:[temp1 rangeOfString:@"</a>"].location];
            
            [dicNews setValue:value forKey:key];
        }  
        
        [self stopLoading:tableViewNews];
    }else if (conn.tag == 4) {
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);    
        NSString *html = [[NSString alloc] initWithData:receviedDataChina encoding:enc];
        
        NSString *str1 = [html substringFromIndex:[html rangeOfString:@"<span>中国军团</span>"].location];
        [html release];
        
        NSString *str2 = [str1 substringToIndex:[str1 rangeOfString:@"<!--排行榜 开始-->"].location];
        
        
        NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"<li><a\\starget=\"_blank\"\\shref=\".*?\">.*?</a>" options:NSRegularExpressionAllowCommentsAndWhitespace error:nil];
        NSArray *array = [regular matchesInString:str2 options:0 range:NSMakeRange(0, [str2 length])];
        for (NSTextCheckingResult *match in array)   
        {  
            NSRange firstHalfRange = [match rangeAtIndex:0];
            NSString *result1=[str2 substringWithRange:firstHalfRange];  
            
            NSString *temp = [result1 substringFromIndex:[result1 rangeOfString:@"/a/"].location];
            NSString *value = [NSString stringWithFormat:@"http://2012.qq.com%@",[temp substringToIndex:[temp rangeOfString:@"\">"].location]];
            
            NSString *temp1 = [result1 substringFromIndex:[result1 rangeOfString:@"\">"].location+[result1 rangeOfString:@"\">"].length];
            NSString *key = [temp1 substringToIndex:[temp1 rangeOfString:@"</a>"].location];
            
            [dicChina setValue:value forKey:key];
        }  
        [self stopLoading:tableViewChina];
    }
}   

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	CustomURLConnection *conn = (CustomURLConnection*)connection;
    if (conn.tag == 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"网络获取失败"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        [self stopLoading:tableViewNews];
        return;
    }else if (conn.tag == 4) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"网络获取失败"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        [self stopLoading:tableViewChina];
        return;
    }
    
}

- (void) updateDicNews 
{
    NSURL *url = [NSURL URLWithString:@"http://2012.qq.com/l/allnews.htm"];
    NSURLRequest *urlRequset = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];

    CustomURLConnection *conn = [[CustomURLConnection alloc] initWithRequest:urlRequset delegate:self];
    conn.tag = 1;
    if (conn) {
        receviedDataNews = [[NSMutableData data] retain];
    }
    else {
        
    }
    [conn release];
}

- (void) updateDicChina
{
    NSURL *url = [NSURL URLWithString:@"http://2012.qq.com/"];
    NSURLRequest *urlRequset = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    
    CustomURLConnection *conn = [[CustomURLConnection alloc] initWithRequest:urlRequset delegate:self];
    conn.tag = 4;
    if (conn) {
        receviedDataChina = [[NSMutableData data] retain];
    }
    else {
        
    }
    [conn release];

}

- (void) dealloc
{
    [super dealloc];
    [webView release];
    [dicNews release];
    [dicChina release];
    [arrayRankOld release];
    [arrayRankNew release];
    [tableViewNews release];
    [tableViewRankNew release];
    [tableViewChina release];
    [tableViewRankOld release];
    [refreshViewNews release];
    [refreshViewChina release];
    [receviedDataNews release];
    [receviedDataChina release];
    [gestureImageView release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)stopLoading:(UITableView *)tableView {
    if (tableView.tag == 201) {
        [refreshViewNews stopLoading];
        [tableViewNews reloadData];
    }
    if (tableView.tag == 204) {
        [refreshViewChina stopLoading];
        [tableViewChina reloadData];
    }
    
}

- (void)startLoading:(UITableView *)tableView {
    if (tableView.tag == 201) {
        [refreshViewNews startLoading];
        [self updateDicNews];
    }
    if (tableView.tag == 204) {
        [refreshViewChina startLoading];
        [self updateDicChina];
    }
   
}
// 刷新
- (void)refresh:(UITableView *)tableView {
    [self startLoading:tableView];
}
#pragma mark - RefreshViewDelegate
- (void)refreshViewDidCallBack:(UIScrollView *)tableView {
    if (tableView.tag == 201) {
        [self refresh:tableViewNews];
    }
    if (tableView.tag == 204) {
        [self refresh:tableViewChina];
    }

}
#pragma mark - UIScrollView 
// 刚拖动的时候
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [refreshViewNews scrollViewWillBeginDragging:scrollView];
}
// 拖动过程中
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [refreshViewNews scrollViewDidScroll:scrollView];
}
// 拖动结束后
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [refreshViewNews scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

#pragma mark - Table view data source
// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger result = 0;
    switch (tableView.tag) {
        case 201:
            result = [dicNews count];
            break;
        case 202:
            result = [arrayRankNew count];
            break;
        case 203:
            result = [arrayRankOld count];
            break;
        case 204:
            result = [dicChina count];
            break;
        default:
            break;
    }
    return result;
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.tag == 201) {
        static NSString *CellIdentifier = @"Cell1";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell.textLabel setFont:[UIFont boldSystemFontOfSize:14]];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.text = [[dicNews allKeys] objectAtIndex:[dicNews count] - indexPath.row - 1];
        return cell;
    }else if (tableView.tag == 202) {
        static NSString *CellIdentifier = @"Cell2";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.text = [arrayRankNew objectAtIndex:indexPath.row];
        return cell;
    }else if (tableView.tag == 203) {
        static NSString *CellIdentifier = @"Cell3";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.text = [arrayRankOld objectAtIndex:indexPath.row];
        return cell;
    }else if (tableView.tag == 204) {
        static NSString *CellIdentifier = @"Cell4";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell.textLabel setFont:[UIFont boldSystemFontOfSize:14]];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.text = [[dicChina allKeys] objectAtIndex:[dicChina count] - indexPath.row - 1];
        return cell;

    }
    return nil;
    
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 201) {
        NSURL *url = [NSURL URLWithString:[[dicNews allValues] objectAtIndex:[dicNews count] - indexPath.row - 1]];
        NSURLRequest *urlRequset = [NSURLRequest requestWithURL:url];
        [webView loadRequest:urlRequset];
        [self showWebView:tableView];    
    }
    else if (tableView.tag == 202) {
    }else if (tableView.tag == 203) {
    }else if (tableView.tag == 204) {
        NSURL *url = [NSURL URLWithString:[[dicChina allValues] objectAtIndex:[dicChina count] - indexPath.row - 1]];
        NSURLRequest *urlRequset = [NSURLRequest requestWithURL:url];
        [webView loadRequest:urlRequset];
        [self showWebView:tableView];    
    }
   
}


@end

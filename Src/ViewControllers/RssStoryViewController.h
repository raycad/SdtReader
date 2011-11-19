//
//  RssStoryViewController.h
//  SdtReader
//
//  Created by raycad on 11/12/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebBrowserViewController.h"
#import "RssStory.h"

@interface RssStoryViewController : WebBrowserViewController {    
    UIWebView               *m_webView;
    UIActivityIndicatorView *m_activityIndicatorView;
    
    RssStory                *m_rssStory;
    UILabel                 *m_loadingLabel;
    UIButton                *m_backWebPageButton;
    UIButton                *m_forwardWebPageButton;
}

@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) RssStory *rssStory;
@property (nonatomic, retain) IBOutlet UILabel *loadingLabel;
@property (nonatomic, retain) IBOutlet UIButton *backWebPageButton;
@property (nonatomic, retain) IBOutlet UIButton *forwardWebPageButton;

- (IBAction)backViewButtonClicked:(id)sender;
- (IBAction)browserButtonClicked:(id)sender;
- (IBAction)backWebPageButtonClicked:(id)sender;
- (IBAction)forwardWebPageButtonClicked:(id)sender;

- (id)initWithRssStory:(RssStory *)rssStory;
- (void)reload;
@end

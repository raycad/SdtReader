//
//  RssStoryViewController.h
//  SdtReader
//
//  Created by raycad on 11/12/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SdtViewController.h"
#import "RssStory.h"

@interface RssStoryViewController : SdtViewController {    
    UIWebView   *m_webView;
    
    RssStory    *m_rssStory;
}

@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) RssStory *rssStory;

- (id)initWithRssStory:(RssStory *)rssStory;
- (void)reload;
@end

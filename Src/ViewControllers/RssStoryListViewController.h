//
//  RssStoryListViewController.h
//  SdtReader
//
//  Created by raycad on 11/11/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SdtViewController.h"
#import "RssFeed.h"
#import "RssStoryModel.h"

@interface RssStoryListViewController : SdtViewController {    
    UITableView             *m_storyListTableView;
    RssFeed                 *m_rssFeed;
    UITextView              *m_headlineTextView;
    UILabel                 *m_totalStoriesLabel;
    RssStoryModel           *m_rssStoryModel;
    UIActivityIndicatorView *m_activityIndicator;
}

@property (nonatomic, retain) IBOutlet UITableView *storyListTableView;
@property (nonatomic, retain) IBOutlet UITextView *headlineTextView;
@property (nonatomic, retain) IBOutlet UILabel *totalStoriesLabel;
@property (nonatomic, retain) RssFeed *rssFeed;
@property (retain, nonatomic) UIActivityIndicatorView *activityIndicator;

- (void)parseRssFeed;
@end

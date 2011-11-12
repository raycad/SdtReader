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
#import "RssParser.h"

@interface RssStoryListViewController : SdtViewController {    
    UITableView             *m_storyListTableView;
    UIActivityIndicatorView *m_activityIndicatorView;
    RssFeed                 *m_rssFeed;
    UILabel                 *m_totalStoriesLabel;
    RssStoryModel           *m_rssStoryModel;
    RssStoryModel           *m_filterRssStoryModel;
    
    RssParser               *m_rssParser;
    UISearchBar             *m_searchBar;
}

@property (nonatomic, retain) IBOutlet UITableView *storyListTableView;
@property (nonatomic, retain) IBOutlet UILabel *totalStoriesLabel;
@property (nonatomic, retain) RssFeed *rssFeed;
@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;

- (void)parseRssFeed;
- (void)refreshData;
@end

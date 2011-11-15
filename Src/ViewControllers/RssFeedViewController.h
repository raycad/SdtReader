//
//  RssFeedViewController.h
//  SdtReader
//
//  Created by raycad on 11/9/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SdtViewController.h"
#import "ReaderModel.h"
#import "RssFeedModel.h"

@interface RssFeedViewController : SdtViewController {
    RssFeedModel    *m_rssFeedModel;
    ReaderModel     *m_readerModel;
    UISearchBar     *m_searchBar;
    UITableView     *m_rssFeedTableView;
}

@property (nonatomic, retain) IBOutlet UITableView *rssFeedTableView;

@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;

- (IBAction)viewRssFeed:(id)sender;
- (IBAction)editRssFeed:(id)sender;
- (IBAction)addRssFeed:(id)sender;
- (void) refreshData;
@end

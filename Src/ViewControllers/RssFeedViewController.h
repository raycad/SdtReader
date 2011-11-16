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

typedef enum {
    Title       = 0,
    Rate        = 1, 
    Category    = 2
} SearchMode; 

@interface RssFeedViewController : SdtViewController {
    RssFeedModel    *m_rssFeedModel;
    ReaderModel     *m_readerModel;
    UISearchBar     *m_searchBar;
    UITableView     *m_rssFeedTableView;
    
    SearchMode      m_searchMode;
    NSMutableArray  *m_rateButtons;
    
    int             m_rateValue;
    UIButton *searchModeButton;
}

@property (nonatomic, retain) IBOutlet UITableView *rssFeedTableView;

@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;
@property (nonatomic, retain) IBOutlet UIButton *searchModeButton;

- (IBAction)viewRssFeed:(id)sender;
- (IBAction)editRssFeed:(id)sender;
- (IBAction)addRssFeed:(id)sender;
- (IBAction)switchSearchMode:(id)sender;

- (void) refreshData;

- (void)setRateValue:(int)rateValue;
- (void)createRateButtons;
- (void)releaseRateButtons;

- (void)showRateButtons:(BOOL)show;
@end

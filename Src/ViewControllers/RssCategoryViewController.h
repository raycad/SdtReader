//
//  RssCategoryViewController.h
//  SdtReader
//
//  Created by raycad on 11/9/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SdtSearchViewController.h"
#import "ReaderModel.h"
#import "RssFeedModel.h"

@interface RssCategoryViewController : SdtSearchViewController {
    RssFeedModel    *m_rssFeedModel;
    ReaderModel     *m_readerModel;
    UISearchBar     *m_searchBar;
    UITableView     *m_rssFeedTableView;
    
    int             m_rateValue;
    UIButton        *m_viewSelectionModeButton;
    UIButton        *m_editSelectionModeButton;
    UIButton        *m_viewSelectionModeLabel;
    UIButton        *m_editSelectionModeLabel;
}

@property (nonatomic, retain) IBOutlet UITableView *rssFeedTableView;

@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;
@property (nonatomic, retain) IBOutlet UIButton *viewSelectionModeButton;

@property (nonatomic, retain) IBOutlet UIButton *editSelectionModeButton;
@property (nonatomic, retain) IBOutlet UIButton *viewSelectionModeLabel;
@property (nonatomic, retain) IBOutlet UIButton *editSelectionModeLabel;

- (IBAction)viewRssFeed:(id)sender;
- (IBAction)editRssFeed:(id)sender;
- (IBAction)addRssFeed:(id)sender;

- (void) refreshData;

- (void)viewRssFeedAtCell:(UITableViewCell *)cell;
- (void)editRssFeedAtCell:(UITableViewCell *)cell;

- (void)setRateValue:(int)rateValue;
- (void)createRateButtons;
- (void)releaseRateButtons;

- (void)updateSelectionMode;
@end

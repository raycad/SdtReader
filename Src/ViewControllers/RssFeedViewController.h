//
//  RssFeedViewController.h
//  SdtReader
//
//  Created by raycad on 11/9/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SdtSearchViewController.h"
#import "ReaderModel.h"
#import "RssFeedModel.h"

@interface RssFeedViewController : SdtSearchViewController {
    RssFeedModel    *m_rssFeedModel;
    ReaderModel     *m_readerModel;
    UISearchBar     *m_searchBar;
    UITableView     *m_rssFeedTableView;
    
    NSMutableArray  *m_rateButtons;
    
    int             m_rateValue;
    UIButton        *m_searchModeButton;
    UIButton        *m_viewSelectionModeButton;
    UIButton        *m_editSelectionModeButton;
    UIButton        *m_viewSelectionModeLabel;
    UIButton        *m_editSelectionModeLabel;
    UILabel         *m_rateLabel;
    UIButton        *m_searchModeLabel;
    UIButton        *m_backButton;
    UIButton        *m_addNewRssFeedButton;
    UIButton        *m_addNewRssFeedLabel;
}

@property (nonatomic, retain) IBOutlet UITableView *rssFeedTableView;

@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;
@property (nonatomic, retain) IBOutlet UIButton *searchModeButton;
@property (nonatomic, retain) IBOutlet UIButton *viewSelectionModeButton;
@property (nonatomic, retain) IBOutlet UILabel *rateLabel;
@property (nonatomic, retain) IBOutlet UIButton *searchModeLabel;

@property (nonatomic, retain) IBOutlet UIButton *editSelectionModeButton;
@property (nonatomic, retain) IBOutlet UIButton *viewSelectionModeLabel;
@property (nonatomic, retain) IBOutlet UIButton *editSelectionModeLabel;
@property (nonatomic, retain) IBOutlet UIButton *backButton;
@property (nonatomic, retain) IBOutlet UIButton *addNewRssFeedButton;
@property (nonatomic, retain) IBOutlet UIButton *addNewRssFeedLabel;

- (IBAction)viewRssFeed:(id)sender;
- (IBAction)editRssFeed:(id)sender;
- (IBAction)addRssFeed:(id)sender;
- (IBAction)switchSearchMode:(id)sender;
- (IBAction)backButtonClicked:(id)sender;

- (void) refreshData;

- (void)viewRssFeedAtCell:(UITableViewCell *)cell;
- (void)editRssFeedAtCell:(UITableViewCell *)cell;

- (void)setRateValue:(int)rateValue;
- (void)createRateButtons;
- (void)releaseRateButtons;

- (void)showRateButtons:(BOOL)show;

- (void)updateSearchMode;
- (void)updateSelectionMode;
@end

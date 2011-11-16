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
    SearchByTitle       = 0,
    SearchByRate        = 1, 
    SearchByCategory    = 2
} SearchMode; 

typedef enum {
    ViewSelectionMode   = 0,
    EditSelectionMode   = 1, 
} SelectionMode;

@interface RssFeedViewController : SdtViewController {
    RssFeedModel    *m_rssFeedModel;
    ReaderModel     *m_readerModel;
    UISearchBar     *m_searchBar;
    UITableView     *m_rssFeedTableView;
    
    SearchMode      m_searchMode;
    SelectionMode   m_selectionMode;
    
    NSMutableArray  *m_rateButtons;
    
    int             m_rateValue;
    UIButton        *m_searchModeButton;
    UIButton        *m_viewSelectionModeButton;
    UIButton        *m_editSelectionModeButton;
    UIButton        *m_viewSelectionModeLabel;
    UIButton        *m_editSelectionModeLabel;
    UILabel         *m_rateLabel;
    UIButton        *m_searchModeLabel;
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

- (IBAction)viewRssFeed:(id)sender;
- (IBAction)editRssFeed:(id)sender;
- (IBAction)addRssFeed:(id)sender;
- (IBAction)switchSearchMode:(id)sender;

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

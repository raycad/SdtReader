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
#import "RssCategoryModel.h"

@interface RssCategoryViewController : SdtSearchViewController {
    RssCategoryModel    *m_rssCategoryModel;
    ReaderModel         *m_readerModel;
    UISearchBar         *m_searchBar;
    UITableView         *m_rssCategoryTableView;
    
    UIButton            *m_viewSelectionModeButton;
    UIButton            *m_editSelectionModeButton;
    UIButton            *m_viewSelectionModeLabel;
    UIButton            *m_editSelectionModeLabel;
}

@property (nonatomic, retain) IBOutlet UITableView *rssCategoryTableView;

@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;
@property (nonatomic, retain) IBOutlet UIButton *viewSelectionModeButton;

@property (nonatomic, retain) IBOutlet UIButton *editSelectionModeButton;
@property (nonatomic, retain) IBOutlet UIButton *viewSelectionModeLabel;
@property (nonatomic, retain) IBOutlet UIButton *editSelectionModeLabel;

- (IBAction)viewRssCategory:(id)sender;
- (IBAction)editRssCategory:(id)sender;
- (IBAction)addRssCategory:(id)sender;

- (void) refreshData;

- (void)viewRssCategoryAtCell:(UITableViewCell *)cell;
- (void)editRssCategoryAtCell:(UITableViewCell *)cell;
@end

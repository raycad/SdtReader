//
//  RssFeedDetailViewController.h
//  SdtReader
//
//  Created by raycad on 11/12/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SdtViewController.h"
#import "RssFeed.h"
#import "RssCategoryModel.h"

@interface RssFeedDetailViewController : SdtViewController {
    RssFeed             *m_rssFeed;
    UITextField         *m_titleTextField;
    UITextField         *m_linkTextField;
    UITextField         *m_websiteTextField;
    UITextView          *m_descriptionTextView;
    
    NSMutableArray      *m_rateButtons;
    UILabel             *m_rateLabel;
    
    int                 m_rateValue;
    UITableView         *m_rssCategoryTableView;
    
    RssCategoryModel    *m_rssCategoryModel;
}

@property (nonatomic, retain) RssFeed *rssFeed;

@property (nonatomic, retain) IBOutlet UITextField *titleTextField;
@property (nonatomic, retain) IBOutlet UITextField *linkTextField;
@property (nonatomic, retain) IBOutlet UITextField *websiteTextField;
@property (nonatomic, retain) IBOutlet UITextView *descriptionTextView;
@property (nonatomic, retain) IBOutlet UILabel *rateLabel;
@property (nonatomic, retain) IBOutlet UITableView *rssCategoryTableView;

- (void)setRateValue:(int)rateValue;
- (void)createRateButtons;
- (void)releaseRateButtons;
@end
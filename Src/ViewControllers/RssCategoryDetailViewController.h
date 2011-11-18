//
//  RssCategoryDetailViewController.h
//  SdtReader
//
//  Created by raycad on 11/12/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SdtViewController.h"
#import "RssCategory.h"

@interface RssCategoryDetailViewController : SdtViewController {
    RssCategory     *m_rssCategory;
    
    UITextField     *m_titleTextField;
    UITextView      *m_descriptionTextView;
}

@property (nonatomic, retain) RssCategory *rssCategory;

@property (nonatomic, retain) IBOutlet UITextField *titleTextField;
@property (nonatomic, retain) IBOutlet UITextView *descriptionTextView;

- (void)viewRssCategoryAtCell:(UITableViewCell *)cell;
- (void)editRssCategoryAtCell:(UITableViewCell *)cell;
@end

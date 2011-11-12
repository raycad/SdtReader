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

@interface RssFeedDetailViewController : SdtViewController {
    RssFeed     *m_rssFeed;
    UITextField *m_titleTextField;
    UITextField *m_linkTextField;
    UITextField *m_websiteTextField;
    UIButton    *m_rate1Button;
    UIButton    *m_rate2Button;
    UIButton    *m_rate3Button;
    UIButton    *m_rate4Button;
    UIButton    *m_rate5Button;
    UITextView  *m_descriptionTextView;
}

@property (nonatomic, retain) RssFeed *rssFeed;

@property (nonatomic, retain) IBOutlet UITextField *titleTextField;
@property (nonatomic, retain) IBOutlet UITextField *linkTextField;
@property (nonatomic, retain) IBOutlet UITextField *websiteTextField;
@property (nonatomic, retain) IBOutlet UITextView *descriptionTextView;
@property (nonatomic, retain) IBOutlet UIButton *rate1Button;
@property (nonatomic, retain) IBOutlet UIButton *rate2Button;
@property (nonatomic, retain) IBOutlet UIButton *rate3Button;
@property (nonatomic, retain) IBOutlet UIButton *rate4Button;
@property (nonatomic, retain) IBOutlet UIButton *rate5Button;
- (IBAction)rate1Clicked:(id)sender;
- (IBAction)rate2Clicked:(id)sender;
- (IBAction)rate3Clicked:(id)sender;
- (IBAction)rate4Clicked:(id)sender;
- (IBAction)rate5Clicked:(id)sender;

@end

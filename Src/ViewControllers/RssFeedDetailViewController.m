//
//  RssFeedDetailViewController.m
//  SdtReader
//
//  Created by raycad on 11/12/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import "RssFeedDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "RateButton.h"
#import "RssFeedModel.h"
#import "ReaderModel.h"

@interface CategoryViewCell : UITableViewCell {
    RssCategory    *m_rssCategory;
}
@property (nonatomic, retain) RssCategory     *rssCategory;
@end

@implementation CategoryViewCell
@synthesize rssCategory = m_rssCategory;
@end

@implementation RssFeedDetailViewController
@synthesize rssFeed                 = m_rssFeed;
@synthesize titleTextField          = m_titleTextField;
@synthesize linkTextField           = m_linkTextField;
@synthesize websiteTextField        = m_websiteTextField;
@synthesize descriptionTextView     = m_descriptionTextView;
@synthesize rateLabel               = m_rateLabel;
@synthesize rssCategoryTableView    = m_rssCategoryTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [self releaseRateButtons];
    
    [m_rssFeed release];
    [m_titleTextField release];
    [m_linkTextField release];
    [m_websiteTextField release];
    [m_descriptionTextView release];
    [m_rateLabel release];
    [m_rssCategoryTableView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Set default parameters   
    [m_descriptionTextView.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
    [m_descriptionTextView.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [m_descriptionTextView.layer setBorderWidth: 1.0];
    [m_descriptionTextView.layer setCornerRadius:10.0f];
    [m_descriptionTextView.layer setMasksToBounds:YES];
    
    [self createRateButtons];
    m_rateValue = -1;
    
    if (m_rssFeed) {
        // Set data
        m_titleTextField.text       = m_rssFeed.title;
        m_linkTextField.text        = m_rssFeed.link;
        m_websiteTextField.text     = m_rssFeed.website;
        m_descriptionTextView.text  = m_rssFeed.description;
        
        [self setRateValue:m_rssFeed.rate];
    }
    
    ReaderModel *readerModel = [ReaderModel instance];
    m_rssCategoryModel = readerModel.rssCategoryModel;
}

- (void)viewDidUnload
{
    [self setTitleTextField:nil];
    [self setLinkTextField:nil];
    [self setWebsiteTextField:nil];
    [self setDescriptionTextView:nil];
    [self setRateLabel:nil];
    [self setRssCategoryTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [m_rssCategoryModel count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView != m_rssCategoryTableView)
        return;
    
    static NSString *CellIdentifier = @"Cell";
    
    CategoryViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[[CategoryViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
    
    int row = indexPath.row;
    
    // Set up the cell...
    RssCategory *rssCategory = [m_rssCategoryModel rssCategoryAtIndex:row];
    if (!rssCategory)
        return nil;
	
    // Reset it to default values.
    
    cell.editingAccessoryView = nil;
    cell.detailTextLabel.text = nil;
    // Set cell selection is blue style
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    // Set data for cell
    cell.rssCategory = rssCategory;
    
    cell.textLabel.text = rssCategory.title;    
    
    if (m_rssFeed.category == rssCategory) {
        // Select the cell
        [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
    
    return cell;
}

// Customize the background color of the rows
- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell 
forRowAtIndexPath: (NSIndexPath*)indexPath
{
    cell.backgroundColor = indexPath.row % 2 
    ? [UIColor colorWithRed: 0.3 green: 0.3 blue: 0.3 alpha: 0.25] 
    : [UIColor whiteColor];
    for (UIView* view in cell.contentView.subviews) {
        view.backgroundColor = [UIColor clearColor];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientatisons
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)releaseRateButtons
{
    if (m_rateButtons) {
        for (int i = 0; i < [m_rateButtons count]; i++) {
            id rateButton = [m_rateButtons objectAtIndex:i];
            if (rateButton) {
                [rateButton release];
                rateButton = nil;
            }
        }        
    }
    
    [m_rateButtons removeAllObjects];
    [m_rateButtons release];
}

- (void)createRateButtons
{
    [self releaseRateButtons];
    
    m_rateButtons = [[NSMutableArray alloc] init];
    
    CGRect baseBound = [m_rateLabel bounds];
    CGRect leftBound = [m_rateLabel convertRect:baseBound toView:self.view];
    
    double x = leftBound.origin.x + leftBound.size.width + 16;
    double y = leftBound.origin.y - 10;
    
    // Create a new dynamic buttons
    for (int i = 0; i < 5; i++) {
        CGRect frame = CGRectMake(x, y, 42, 42);
        RateButton *rateButton = [[RateButton buttonWithType:UIButtonTypeCustom] retain];
        rateButton.frame = frame;
        //[rateButton setTitle:(NSString *)@"Rate" forState:(UIControlState)UIControlStateNormal];
        [rateButton addTarget:self action:@selector(rateButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [rateButton setRateSize:Size48];
        [rateButton setState:UnRating];
        
        rateButton.data = i;
        
        [self.view addSubview:rateButton];
        [m_rateButtons addObject:rateButton];
        
        x += 50;
    }
}

- (void)setRateValue:(int)rateValue
{
    int rateButtonCount = [m_rateButtons count];
    
    if (rateValue < 0 || rateValue >= rateButtonCount) {
        rateValue = -1;
    }
    
    if ((m_rateValue == rateValue) && (m_rateValue != 0) && (m_rateValue != rateButtonCount-1)) {
        // Nothing changes
        return;
    }
    
    if (m_rateValue == rateValue && m_rateValue == 0) {
        RateButton *rateButton = (RateButton *)[m_rateButtons objectAtIndex:0];
        if (!rateButton)
            return;
        RateState rateState = [rateButton rateState];
        if (rateState == Rating) {
            // Rating = 0
            m_rateValue = -1;
        }        
    } else if (m_rateValue == rateValue && m_rateValue == rateButtonCount-1) {
        RateButton *rateButton = (RateButton *)[m_rateButtons objectAtIndex:(rateButtonCount-1)];
        if (!rateButton)
            return;
        RateState rateState = [rateButton rateState];
        if (rateState == Rating) {
            // Rating = 0
            m_rateValue = -1;
        }        
    } else
        m_rateValue = rateValue;
    
    int i = 0;
    RateButton *rateButton = nil;
    for (i = 0; i <= m_rateValue; i++) {
        rateButton = (RateButton *)[m_rateButtons objectAtIndex:i];
        if (!rateButton)
            continue;
        [rateButton setState:Rating];
    }
    
    for (i = m_rateValue+1; i < rateButtonCount; i++) {
        rateButton = (RateButton *)[m_rateButtons objectAtIndex:i];
        if (!rateButton)
            continue;
        [rateButton setState:UnRating];
    }
}

- (void)rateButtonClicked:(id)sender
{
    if (!sender || ![sender isKindOfClass:[RateButton class]])
        return;
    
    int rateValue = ((RateButton *)sender).data;
    [self setRateValue:rateValue];
    
    NSLog(@"new button clicked!!! %d", rateValue);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return TRUE;
}

- (BOOL)textView:(UITextView *)txtView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if( [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location == NSNotFound ) {
        return YES;
    }
    
    [txtView resignFirstResponder];
    return NO;
}

- (void)saveAction:(id)sender
{
#pragma unused(sender)
    NSString *title = [self.titleTextField text];
    
    if ([title isEqualToString:@""]) {
        // Open a alert with an OK button
        NSString *alertString = [NSString stringWithFormat:@"Title must not be empty"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:alertString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        return;
    }
    
    NSString *link = [self.linkTextField text];
    NSString *website = [self.websiteTextField text];
    NSString *description = [self.descriptionTextView text];
    
    ReaderModel *readerModel = [ReaderModel instance];
    RssFeedPK *rssFeedPK = [[RssFeedPK alloc] initWithTitle:title];
    
    RssCategory *rssCategory = [readerModel.rssCategoryModel rssCategoryAtIndex:0];    
    NSIndexPath *indexPath = [m_rssCategoryTableView indexPathForSelectedRow];   
    if (indexPath) {
        CategoryViewCell *cell = (CategoryViewCell *)[m_rssCategoryTableView cellForRowAtIndexPath:indexPath];
        if (cell)
            rssCategory = cell.rssCategory;
    }
    
    if (self.viewMode == CreateNewMode) {        
        RssFeed *rssFeed = [[RssFeed alloc] initWithRssFeedPK:rssFeedPK];
        rssFeed.title = title;
        rssFeed.link = link;
        rssFeed.description = description;
        rssFeed.website = website;
        rssFeed.rate = m_rateValue;        
        [readerModel updateRssFeedCategoryOf:rssFeed To:rssCategory];
        
        if (![readerModel addRssFeed:rssFeed]) {
            // Open a alert with an OK button
            NSString *alertString = [NSString stringWithFormat:@"This RSS Feed is existing"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:alertString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
            return;
        }
    } else if (self.viewMode == UpdateMode) {
        if (!m_rssFeed)
            return;
        
        RssFeedModel *rssFeedModel = readerModel.rssFeedModel;
        
        // Update RSS Feed
        RssFeedPK *currentRssFeedPK = [m_rssFeed rssFeedPK];
        
        if ((![rssFeedPK isEqual:currentRssFeedPK]) && [rssFeedModel getRssFeedByPK:rssFeedPK] != nil) {
            // Open a alert with an OK button
            NSString *alertString = [NSString stringWithFormat:@"The RSS Feed is existing. Please enter another title name"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:alertString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
            return;
        }
        
        m_rssFeed.title = title;
        m_rssFeed.link = link;
        m_rssFeed.description = description;
        m_rssFeed.website = website;
        m_rssFeed.rate = m_rateValue;
        [readerModel updateRssFeedCategoryOf:m_rssFeed To:rssCategory];
        
        // Reset RssFeedPK
        [m_rssFeed rssFeedPK].title = title;
    }
    
    // Tell the delegate about the update.    
    if ((self.delegate != nil) && [self.delegate respondsToSelector:@selector(didUpdate:)] ) {
        [self.delegate didSave:self];
    }
}

@end

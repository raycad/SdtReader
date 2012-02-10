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
@synthesize categoryButton          = m_categoryButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    
    [self refreshView];
}

- (void)refreshView
{
    ReaderModel *readerModel = [ReaderModel instance];
    m_selectedRssCategory = [readerModel.rssCategoryModel rssCategoryAtIndex:0];
    
    if (m_rssFeed) {
        m_selectedRssCategory = m_rssFeed.rssCategory;
        RssCategory *rssCategory = nil;
        int section = 0;
        for(int i = 0; i < [m_rssCategoryModel count]; i++) {        
            rssCategory = [m_rssCategoryModel rssCategoryAtIndex:i];
            if (rssCategory == m_selectedRssCategory) {
                if (i < 2)
                    break;
                
                // Swap to the second position
                [m_rssCategoryModel swapValueBetweenIndex:1 andIndex:i];
                break;
            }            		
        }
    }
    
    if (m_selectedRssCategory)
        [m_categoryButton setTitle:m_selectedRssCategory.title forState:UIControlStateNormal];
    
    [m_rssCategoryTableView reloadData];
}

- (void)viewDidUnload
{
    [self setTitleTextField:nil];
    [self setLinkTextField:nil];
    [self setWebsiteTextField:nil];
    [self setDescriptionTextView:nil];
    [self setRateLabel:nil];
    [self setRssCategoryTableView:nil];
    [self setCategoryButton:nil];
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
		cell = [[CategoryViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
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
    
    if (rssCategory == m_selectedRssCategory) {
        // Select cell
        [m_rssCategoryTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryViewCell *cell = (CategoryViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    assert(cell != nil);
    
    m_selectedRssCategory = cell.rssCategory;
    
    if (m_selectedRssCategory)
        [m_categoryButton setTitle:m_selectedRssCategory.title forState:UIControlStateNormal];
    
    if (m_categoryModalDialog)
        [m_categoryModalDialog dismissWithClickedButtonIndex:0 animated:YES];
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
                rateButton = nil;
            }
        }        
    }
    
    [m_rateButtons removeAllObjects];
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
        RateButton *rateButton = [RateButton buttonWithType:UIButtonTypeCustom];
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

- (void) animateViewMove:(BOOL)up
{
    const int   movementDistance    = 54;   // tweak as needed
    const float movementDuration    = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"animation" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    
    self.view.frame  = CGRectOffset(self.view.frame , 0, movement);
    [UIView commitAnimations];
}

/*- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateViewMove:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateViewMove:NO];
}*/

- (void)textViewDidBeginEditing:(UITextField *)textField
{
    [self animateViewMove:YES];
}

- (void)textViewDidEndEditing:(UITextField *)textField
{
    [self animateViewMove:NO];
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
        
        return;
    }
    
    NSString *link = [self.linkTextField text];
    NSString *website = [self.websiteTextField text];
    NSString *description = [self.descriptionTextView text];
    
    ReaderModel *readerModel = [ReaderModel instance];
    RssFeedPK *rssFeedPK = [[RssFeedPK alloc] initWithTitle:title];
    
    if (self.viewMode == CreateNewMode) {        
        RssFeed *rssFeed = [[RssFeed alloc] initWithRssFeedPK:rssFeedPK];
        rssFeed.title = title;
        rssFeed.link = link;
        rssFeed.description = description;
        rssFeed.website = website;
        rssFeed.rate = m_rateValue;     
        rssFeed.rssCategory = m_selectedRssCategory;
        //[readerModel updateRssFeedCategoryOf:rssFeed to:m_selectedRssCategory];
        
        if (![readerModel addRssFeed:rssFeed]) {
            // Open a alert with an OK button
            NSString *alertString = [NSString stringWithFormat:@"This RSS Feed is existing"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:alertString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
            return;
        }
        
        // Insert to DB
        [readerModel insertRssFeedToDb:rssFeed];
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
            
            return;
        }
        
        m_rssFeed.title = title;
        m_rssFeed.link = link;
        m_rssFeed.description = description;
        m_rssFeed.website = website;
        m_rssFeed.rate = m_rateValue;
        [readerModel updateRssFeedCategoryOf:m_rssFeed to:m_selectedRssCategory];
        
        // Reset RssFeedPK
        [m_rssFeed rssFeedPK].title = title;
        
        // Update to DB
        [readerModel updateRssFeedToDb:m_rssFeed];
    }
    
    // Tell the delegate about the update.    
    if ((self.delegate != nil) && [self.delegate respondsToSelector:@selector(didUpdate:)] ) {
        [self.delegate didSave:self];
    }
}

const int CategoryDialogTopMargin       = 18;
const int CategoryDialogLeftMargin      = 20;
const int CategoryTableViewTopMargin    = 45;
const int CategoryTableViewLeftMargin   = 20;
const int DeltaY                        = 25;
- (void)showCategoryModalDialog
{
    if (!m_categoryModalDialog) {
        m_categoryModalDialog = [[UIAlertView alloc] initWithTitle:@"Select Category" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        
        m_rssCategoryTableView = [[UITableView alloc] init]; 
        [m_rssCategoryTableView setBackgroundColor:[UIColor whiteColor]];
        m_rssCategoryTableView.delegate = self;
        m_rssCategoryTableView.dataSource = self;
        
        /*CGAffineTransform affineTransform = CGAffineTransformMakeTranslation(0, 20);
        [m_categoryModelDialog setTransform:affineTransform];*/
        
        [m_categoryModalDialog addSubview:m_rssCategoryTableView];
    }
    
    [m_categoryModalDialog show];
}

- (void)willPresentAlertView:(UIAlertView *)alertView 
{
    if (alertView == m_categoryModalDialog && m_categoryModalDialog != nil) {   
        CGRect boundRect = [self.view bounds];
        int boundWidth  = boundRect.size.width;
        int boundHeight = boundRect.size.height;
        CGRect frame;
        frame = CGRectMake(CategoryDialogLeftMargin, CategoryDialogTopMargin+15, boundWidth-2*CategoryDialogLeftMargin, boundHeight-2*CategoryDialogTopMargin);         
        m_categoryModalDialog.frame = frame;
        
        boundRect = [m_categoryModalDialog bounds];
        boundWidth  = boundRect.size.width;
        boundHeight = boundRect.size.height;
        frame = CGRectMake(CategoryTableViewLeftMargin, CategoryTableViewTopMargin, boundWidth-2*CategoryTableViewLeftMargin, boundHeight-2*CategoryTableViewTopMargin-DeltaY);         
        m_rssCategoryTableView.frame = frame;
        
        // iterate through the subviews in order to find the button and resize it
        for(UIView *view in m_categoryModalDialog.subviews) {
            if([[view class] isSubclassOfClass:[UIControl class]]) {
                view.frame = CGRectMake(view.frame.origin.x,
                                           boundHeight-view.frame.size.height-18,
                                           view.frame.size.width-4,
                                           view.frame.size.height-2);
            }
        }
    }
}

- (IBAction)categoryButtonClicked:(id)sender
{
    [self showCategoryModalDialog];
}

@end

//
//  RssCategoryViewController.m
//  SdtReader
//
//  Created by raycad on 11/9/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import "RssCategoryViewController.h"
#import "Common.h"
#import "RssFeedViewCell.h"
#import "RssStoryListViewController.h"
#import "RssFeedDetailViewController.h"
#import "RateButton.h"

@implementation RssCategoryViewController
@synthesize searchBar = m_searchBar;
@synthesize viewSelectionModeButton = m_viewSelectionModeButton;
@synthesize editSelectionModeButton = m_editSelectionModeButton;
@synthesize viewSelectionModeLabel = m_viewSelectionModeLabel;
@synthesize editSelectionModeLabel = m_editSelectionModeLabel;
@synthesize rssFeedTableView = m_rssFeedTableView;

- (id)init
{
    //self = [super initWithStyle:UITableViewStyleGrouped];
    self = [super init];
    if (self != nil) {       
        // Initialize the reader model
        m_readerModel = [ReaderModel instance];
        m_rssFeedModel = [[RssFeedModel alloc] init];     
        
        // Set up our navigation bar.
        self.title = RssCategoryTitle;        
        self.tabBarItem.image = [UIImage imageNamed:@"rss_grey.png"]; 
        
        m_rateValue = -1;
        m_searchMode = SearchByTitle;
        m_selectionMode = ViewSelectionMode;
    }
    
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 67;
}

- (void)dealloc
{
    [self releaseRateButtons];
    [m_rssFeedModel release];
    [m_searchBar release];
    [m_rssFeedTableView release];
    [m_viewSelectionModeButton release];
    [m_editSelectionModeButton release];
    [m_viewSelectionModeLabel release];
    [m_editSelectionModeLabel release];
    [super dealloc];
}

- (void)loadDataFromDB
{
    if (m_readerModel.rssFeedModel == nil) {
        RssFeedModel *rssFeedModel = [[RssFeedModel alloc] init];
        
        NSString    *title;
        NSString    *link;
        NSString    *website;
        NSString    *description;   
        NSString    *category;
        RssFeedPK   *rssFeedPK;
        RssFeed     *rssFeed;
        
        title = [NSString stringWithFormat:@"CNN - Top Stories (gg)"];
        rssFeedPK = [[RssFeedPK alloc] initWithTitle:title];
        rssFeed = [[RssFeed alloc] initWithRssFeedPK:rssFeedPK];
        link = @"http://rss.cnn.com/rss/cnn_topstories.rss";
        website = @"cnn.com";
        description = @"CNN";
        category = @"Entertainment";
        rssFeed.title = title;
        rssFeed.link = link;
        rssFeed.website = website;
        rssFeed.description = description;
        rssFeed.category = category;
        rssFeed.rate = 4;
        if ([rssFeedModel addRssFeed:rssFeed]) {
            NSLog(@"Added rss feed sucessfully");
        }
        [title release];
        [link release];
        [website release];
        [description release];
        [category release];
        [rssFeedPK release];
        [rssFeed release];  
        
        title = [NSString stringWithFormat:@"MSDN"];
        rssFeedPK = [[RssFeedPK alloc] initWithTitle:title];
        rssFeed = [[RssFeed alloc] initWithRssFeedPK:rssFeedPK];
        link = @"http://feeds2.feedburner.com/TheMdnShow";
        website = @"msdn.com";
        description = @"MSDN";
        category = @"Education";
        rssFeed.title = title;
        rssFeed.link = link;
        rssFeed.website = website;
        rssFeed.description = description;
        rssFeed.category = category;
        rssFeed.rate = 0;
        if ([rssFeedModel addRssFeed:rssFeed]) {
            NSLog(@"Added rss feed sucessfully");
        }
        [title release];
        [link release];
        [website release];
        [description release];
        [category release];
        [rssFeedPK release];
        [rssFeed release];http:
        
        title = [NSString stringWithFormat:@"BBC Top Stories"];
        rssFeedPK = [[RssFeedPK alloc] initWithTitle:title];
        rssFeed = [[RssFeed alloc] initWithRssFeedPK:rssFeedPK];
        link = @"http://feeds.bbci.co.uk/news/rss.xml";
        website = @"bbc.com";
        description = @"BBC";
        category = @"Entertainment";
        rssFeed.title = title;
        rssFeed.link = link;
        rssFeed.website = website;
        rssFeed.description = description;
        rssFeed.category = category;
        rssFeed.rate = 2;
        if ([rssFeedModel addRssFeed:rssFeed]) {
            NSLog(@"Added rss feed sucessfully");
        }
        [title release];
        [link release];
        [website release];
        [description release];
        [category release];
        [rssFeedPK release];
        [rssFeed release]; 
        
        title = [NSString stringWithFormat:@"BBC"];
        rssFeedPK = [[RssFeedPK alloc] initWithTitle:title];
        rssFeed = [[RssFeed alloc] initWithRssFeedPK:rssFeedPK];
        link = @"http://newsrss.bbc.co.uk/rss/sportonline_world_edition/front_page/rss.xml";
        website = @"bbc.com";
        description = @"BBC";
        category = @"Travel";
        rssFeed.title = title;
        rssFeed.link = link;
        rssFeed.website = website;
        rssFeed.description = description;
        rssFeed.category = category;
        rssFeed.rate = -1;
        if ([rssFeedModel addRssFeed:rssFeed]) {
            NSLog(@"Added rss feed sucessfully");
        }
        [title release];
        [link release];
        [website release];
        [description release];
        [category release];
        [rssFeedPK release];
        [rssFeed release];        
                
        title = [NSString stringWithFormat:@"BBC Education"];
        rssFeedPK = [[RssFeedPK alloc] initWithTitle:title];
        rssFeed = [[RssFeed alloc] initWithRssFeedPK:rssFeedPK];
        link = @"http://feeds.bbci.co.uk/news/education/rss.xml";
        website = @"bbc.com";
        description = @"BBC";
        category = @"Education";
        rssFeed.title = title;
        rssFeed.link = link;
        rssFeed.website = website;
        rssFeed.description = description;
        rssFeed.category = category;
        rssFeed.rate = 2;
        if ([rssFeedModel addRssFeed:rssFeed]) {
            NSLog(@"Added rss feed sucessfully");
        }
        [title release];
        [link release];
        [website release];
        [description release];
        [category release];
        [rssFeedPK release];
        [rssFeed release]; 
        
        title = [NSString stringWithFormat:@"BBC Politics"];
        rssFeedPK = [[RssFeedPK alloc] initWithTitle:title];
        rssFeed = [[RssFeed alloc] initWithRssFeedPK:rssFeedPK];
        link = @"http://feeds.bbci.co.uk/news/politics/rss.xml";
        website = @"bbc.com";
        description = @"BBC";
        category = @"Politics";
        rssFeed.title = title;
        rssFeed.link = link;
        rssFeed.website = website;
        rssFeed.description = description;
        rssFeed.category = category;
        rssFeed.rate = 4;
        if ([rssFeedModel addRssFeed:rssFeed]) {
            NSLog(@"Added rss feed sucessfully");
        }
        [title release];
        [link release];
        [website release];
        [description release];
        [category release];
        [rssFeedPK release];
        [rssFeed release]; 
        
        // Set data model
        m_readerModel.rssFeedModel = rssFeedModel;
        
        [rssFeedModel release];
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Configure the table view    
    m_rssFeedTableView.editing = YES;
    m_rssFeedTableView.allowsSelectionDuringEditing = YES;
    
    // Hide the navigation bar
    [self hideNavigationBar];
    
    UITabBarItem *tbi = [self tabBarItem];
    //[tbi setTitle:@"abc"];
    UIImage *i = [UIImage imageNamed:@"star-white32.png"];
    [tbi setImage:i];
    
    [self loadDataFromDB];
    
    // Reload data
    [self refreshData];
    
    [self updateSelectionMode];
}

- (void)didRateButtonClicked:(NSObject *)object
{
    if (m_searchMode != SearchByRate) {
        NSIndexPath *selectedIndexPath = [m_rssFeedTableView indexPathForSelectedRow];    
        NSIndexPath *indexPath = [m_rssFeedTableView indexPathForCell:(UITableViewCell *)object];
        
        if (indexPath != selectedIndexPath)
            return;
        
        // Reset selection to avoid break draw rate buttons
        [m_rssFeedTableView deselectRowAtIndexPath:selectedIndexPath animated:NO];
        
        [m_rssFeedTableView selectRowAtIndexPath:selectedIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    } else {
        [self refreshData];
    }
}

- (void)viewRssFeedAtCell:(UITableViewCell *)cell
{
    if (!cell)
        return;
    
    RssFeedViewCell *rssFeedViewCell = (RssFeedViewCell *)cell;
    if (!rssFeedViewCell)
        return;
    
    RssFeed *rssFeed = rssFeedViewCell.rssFeed;
    if (!rssFeed)
        return;
    
    NSString *rssLink = rssFeed.link;
    if (!rssLink || [rssLink isEqualToString:@""]) {
        // Open a alert with an OK button
        NSString *alertString = [NSString stringWithFormat:@"RSS link is empty. Please enter the link"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:alertString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }
    
    RssStoryListViewController *rssStoryListViewController = [[[RssStoryListViewController alloc] init] autorelease];
    
    rssStoryListViewController.rssFeed = rssFeed;
    rssStoryListViewController.delegate = self;
    
    [[self navigationController] pushViewController:rssStoryListViewController animated:YES];
    //[self showNavigationBar];
    
    // Parse RSS Feeds
    [rssStoryListViewController parseRssFeed];
}

- (void)editRssFeedAtCell:(UITableViewCell *)cell
{
    if (!cell)
        return;
    
    RssFeedViewCell *rssFeedViewCell = (RssFeedViewCell *)cell;
    if (!rssFeedViewCell)
        return;
    
    RssFeed *rssFeed = rssFeedViewCell.rssFeed;
    if (!rssFeed)
        return;    
    
    RssFeedDetailViewController *rssFeedDetailViewController = [[[RssFeedDetailViewController alloc] init] autorelease];
    assert(rssFeedDetailViewController != nil);        
    rssFeedDetailViewController.delegate = self;  
    rssFeedDetailViewController.rssFeed = rssFeed;
    rssFeedDetailViewController.viewMode = UpdateMode;
    [rssFeedDetailViewController presentModallyOn:self];
}

- (IBAction)viewRssFeed:(id)sender 
{
    m_selectionMode = EditSelectionMode;
    
    [self updateSelectionMode];
}

- (IBAction)editRssFeed:(id)sender
{
    m_selectionMode = ViewSelectionMode;
    
    [self updateSelectionMode];
}

- (IBAction)addRssFeed:(id)sender 
{
    RssFeedDetailViewController *rssFeedDetailViewController = [[[RssFeedDetailViewController alloc] init] autorelease];
    assert(rssFeedDetailViewController != nil);        
    rssFeedDetailViewController.delegate = self;  
    rssFeedDetailViewController.viewMode = CreateNewMode;
    [rssFeedDetailViewController presentModallyOn:self];
}

- (void)refreshData
{
    if (m_searchMode == SearchByTitle) {
        NSString *searchText = m_searchBar.text;
        if([searchText isEqualToString:@""] || (searchText == nil)){
            [m_rssFeedModel copyDataFrom:m_readerModel.rssFeedModel];        
        } else {    
            // Filter course by title
            RssFeedModel *rssFeedModel = [m_readerModel.rssFeedModel searchByTitle:searchText];
            if (rssFeedModel == nil)
                [m_rssFeedModel clear];
            else {
                [m_rssFeedModel copyDataFrom:rssFeedModel];
                //[rssFeedModel release]; // Cause the crash
            }
        }
    } else if (m_searchMode == SearchByRate) {
        // Filter course by rate
        RssFeedModel *rssFeedModel = [m_readerModel.rssFeedModel searchByRate:m_rateValue];
        if (rssFeedModel == nil)
            [m_rssFeedModel clear];
        else {
            [m_rssFeedModel copyDataFrom:rssFeedModel];
            //[rssFeedModel release]; // Cause the crash
        }
    }
    
    /*NSString *title = [NSString stringWithFormat:@"%@ (%d)", RssReaderTitle, [m_rssFeedModel count]];
    self.title = title;*/
    
    [m_rssFeedTableView reloadData];
}

- (void)viewDidUnload
{
    m_searchBar = nil;
    m_rssFeedTableView = nil;
    
    [self setViewSelectionModeButton:nil];
    [self setEditSelectionModeButton:nil];
    [self setViewSelectionModeLabel:nil];
    [self setEditSelectionModeLabel:nil];
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
    return [m_rssFeedModel count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    RssFeedViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[[RssFeedViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
        // Show row with the AccessoryDisclosureIndicator
		cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	}
    
    int row = indexPath.row;
    //int total = [m_rssFeedModel count]; 
    
    // Set up the cell...
    RssFeed *rssFeed = [m_rssFeedModel rssFeedAtIndex:row];
    if (!rssFeed)
        return nil;
	
    // Reset it to default values.
    
    cell.editingAccessoryView = nil;
    cell.detailTextLabel.text = nil;
    // Set cell selection is blue style
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.delegate = self;
    
    NSString *thumbnailFile;
    if (row%3 == 0)
        thumbnailFile = @"rss_yellow.png";
    else if (row%3 == 1)
        thumbnailFile = @"rss_green.png";
    else
        thumbnailFile = @"rss_blue.png";
    
    cell.thumbnailImageView.image = [UIImage imageNamed:thumbnailFile]; 
    
    // Set data for cell
    cell.rssFeed = rssFeed;
    
    // Update data
    [cell updateData];    
        
    return cell;
}

// Customize the background color of the rows
- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell 
forRowAtIndexPath: (NSIndexPath*)indexPath
{
    cell.backgroundColor = indexPath.row % 2 
    ? [UIColor colorWithRed: 0.3 green: 0.3 blue: 0.3 alpha: 0.3] 
    : [UIColor whiteColor];
    for (UIView* view in cell.contentView.subviews) {
        view.backgroundColor = [UIColor clearColor];
    }
}

//This defines for each row its editing style, i.e. whether it shows a remove sign (Red circle with subtract sign) or 
//and add sign (Green circle with addition sign). I have hard coded the first row (the one that says "New Item") to display the add sign and all others to display the subtract sign. 
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

//This method is invoked when the user has finished editing one of the rows of the table. The three parameters
//respectivly proivide, the table being edited, the style of the row being edited (Add or Delete) and the row being 
//edited. If the style is delete we remove the corresponding item from the data source and then delete the row from 
///the view. If the style was add we add another element to the data source and relode the data into the table view.
//In reality add item will probably load a new view which allows the user to enter text but that is left to another 
//tutorial for now we are hard coding the text to be added.   
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    RssFeedModel *rssFeedModel = m_readerModel.rssFeedModel;
    // If row is deleted, remove it from the list.
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        RssFeedViewCell *cell = (RssFeedViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        assert(cell != nil);
        RssFeed *rssFeed = cell.rssFeed;
        assert(rssFeed != nil);
        if ([rssFeedModel removeRssFeed:rssFeed]) {
            [self refreshData];
            //[m_rssFeedTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            NSLog(@"Remove course button was clicked");
        }
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    assert(cell != nil);
    
    if (m_selectionMode == ViewSelectionMode)
        [self viewRssFeedAtCell:cell];
    else if (m_selectionMode == EditSelectionMode)
        [self editRssFeedAtCell:cell];    
}

- (void)presentCourseViewModally
// Displays the options view so that the user can add a new number to the 
// list of numbers to add up.
{
}

- (void)didSave:(NSObject *)object
{
#pragma unused(object)
    assert(object != nil);
    
    /*RssFeedDetailViewController *rssFeedDetailViewController = (RssFeedDetailViewController *)object;*/      
    [self dismissModalViewControllerAnimated:YES];
    
    [self refreshData];
}

- (void)didCancel:(NSObject *)object
// Called when the user taps Cancel in the options view.
{
#pragma unused(object)
    assert(object != nil);
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didUpdate:(NSObject *)object
// Called when the user taps Cancel in the options view.
{
#pragma unused(object)
    assert(object != nil);
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    [self refreshData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    // only show the status bar’s cancel button while in edit mode
    m_searchBar.showsCancelButton = YES;
    m_searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    m_searchBar.showsCancelButton = NO;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchBar != m_searchBar)
        return;
    
    [self refreshData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [m_searchBar resignFirstResponder];
    m_searchBar.text = @"";
    
    [self refreshData];
}

// called when Search (in our case “Done”) button pressed
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)updateSelectionMode
{
    if (m_selectionMode == ViewSelectionMode) {
        [m_viewSelectionModeLabel setHidden:NO];
        [m_viewSelectionModeButton setHidden:NO];
        
        [m_editSelectionModeLabel setHidden:YES];
        [m_editSelectionModeButton setHidden:YES];
    } else if (m_selectionMode == EditSelectionMode) {
        [m_viewSelectionModeLabel setHidden:YES];
        [m_viewSelectionModeButton setHidden:YES];
        
        [m_editSelectionModeLabel setHidden:NO];
        [m_editSelectionModeButton setHidden:NO];
    }
}
@end

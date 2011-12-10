//
//  RssCategoryViewController.m
//  SdtReader
//
//  Created by raycad on 11/9/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import "RssCategoryViewController.h"
#import "Common.h"
#import "RssCategoryViewCell.h"
#import "RateButton.h"
#import "RssFeedViewController.h"
#import "RssCategoryDetailViewController.h"

@implementation RssCategoryViewController
@synthesize searchBar = m_searchBar;
@synthesize viewSelectionModeButton = m_viewSelectionModeButton;
@synthesize editSelectionModeButton = m_editSelectionModeButton;
@synthesize viewSelectionModeLabel = m_viewSelectionModeLabel;
@synthesize editSelectionModeLabel = m_editSelectionModeLabel;
@synthesize rssCategoryTableView = m_rssCategoryTableView;

- (id)init
{
    //self = [super initWithStyle:UITableViewStyleGrouped];
    self = [super init];
    if (self != nil) {       
        // Initialize the reader model
        m_readerModel = [ReaderModel instance];
        m_rssCategoryModel = [[RssCategoryModel alloc] init];             
                
        self.tabBarItem.title = RssCategoryTitle;
        self.tabBarItem.image = [UIImage imageNamed:RssCategoryTabBarIcon];
        
        m_searchMode = SearchByTitle;
        m_selectionMode = ViewSelectionMode;
    }
    
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (void)dealloc
{
    [m_rssCategoryModel release];
    [m_searchBar release];
    [m_rssCategoryTableView release];
    [m_viewSelectionModeButton release];
    [m_editSelectionModeButton release];
    [m_viewSelectionModeLabel release];
    [m_editSelectionModeLabel release];
    [super dealloc];
}

- (void)refreshView
{
    if (m_searchMode == SearchByTitle) {
        NSString *searchText = m_searchBar.text;
        if([searchText isEqualToString:@""] || (searchText == nil)){
            [m_rssCategoryModel copyDataFrom:m_readerModel.rssCategoryModel];        
        } else {    
            // Filter course by title
            RssCategoryModel *rssCategoryModel = [m_readerModel.rssCategoryModel searchByTitle:searchText];
            if (rssCategoryModel == nil)
                [m_rssCategoryModel clear];
            else {
                [m_rssCategoryModel copyDataFrom:rssCategoryModel];
                //[rssCategoryModel release]; // Cause the crash
            }
        }
    } 
    
    [m_rssCategoryTableView reloadData];
}

- (void)refreshData
{
    // Reload date view
    [self refreshView];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Configure the table view    
    m_rssCategoryTableView.editing = YES;
    m_rssCategoryTableView.allowsSelectionDuringEditing = YES;
    
    // Hide the navigation bar
    [self hideNavigationBar];
    
    /*UITabBarItem *tbi = [self tabBarItem];
    [tbi setTitle:RssCategoryTitle];
    UIImage *i = [UIImage imageNamed:RssCategoryTabBarIcon];
    [tbi setImage:i];*/
    
    [self refreshData];
    
    [self updateSelectionMode];
}

- (void)didRateButtonClicked:(NSObject *)object
{
    if (m_searchMode != SearchByRate) {
        NSIndexPath *selectedIndexPath = [m_rssCategoryTableView indexPathForSelectedRow];    
        NSIndexPath *indexPath = [m_rssCategoryTableView indexPathForCell:(UITableViewCell *)object];
        
        if (indexPath != selectedIndexPath)
            return;
        
        // Reset selection to avoid break draw rate buttons
        [m_rssCategoryTableView deselectRowAtIndexPath:selectedIndexPath animated:NO];
        
        [m_rssCategoryTableView selectRowAtIndexPath:selectedIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    } else {
        [self refreshView];
    }
}

- (void)viewDidUnload
{
    m_searchBar = nil;
    m_rssCategoryTableView = nil;
    
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
    return [m_rssCategoryModel count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    RssCategoryViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[[RssCategoryViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
        // Show row with the AccessoryDisclosureIndicator
		cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	}
    
    int row = indexPath.row;
    //int total = [m_rssCategoryModel count]; 
    
    // Set up the cell...
    RssCategory *rssCategory = [m_rssCategoryModel rssCategoryAtIndex:row];
    if (!rssCategory)
        return nil;
	
    // Reset it to default values.
    
    cell.editingAccessoryView = nil;
    cell.detailTextLabel.text = nil;
    // Set cell selection is blue style
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Set data for cell
    cell.rssCategory = rssCategory;
    
    // Update data
    [cell updateData];    
        
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
    // If row is deleted, remove it from the list.
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        RssCategoryViewCell *cell = (RssCategoryViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        assert(cell != nil);
        RssCategory *rssCategory = cell.rssCategory;
        assert(rssCategory != nil);
        if ([m_readerModel removeRssCategory:rssCategory]) {
            // Delete from DB
            [m_readerModel deleteRssCategoryFromDb:rssCategory];
            
            [self refreshData];
            //[m_rssCategoryTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
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
        [self viewRssCategoryAtCell:cell];
    else if (m_selectionMode == EditSelectionMode)
        [self editRssCategoryAtCell:cell];    
}

- (void)didSave:(NSObject *)object
{
#pragma unused(object)
    assert(object != nil);
    
    /*RssCategoryDetailViewController *rssCategoryDetailViewController = (RssCategoryDetailViewController *)object;*/      
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
    
    [self refreshView];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [m_searchBar resignFirstResponder];
    m_searchBar.text = @"";
    
    [self refreshView];
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

- (IBAction)viewRssCategory:(id)sender 
{
    m_selectionMode = EditSelectionMode;
    
    [self updateSelectionMode];
}

- (IBAction)editRssCategory:(id)sender
{
    m_selectionMode = ViewSelectionMode;
    
    [self updateSelectionMode];
}

- (IBAction)addRssCategory:(id)sender 
{
    RssCategoryDetailViewController *rssCategoryDetailViewController = [[[RssCategoryDetailViewController alloc] init] autorelease];
     assert(rssCategoryDetailViewController != nil);        
     rssCategoryDetailViewController.delegate = self;  
     rssCategoryDetailViewController.viewMode = CreateNewMode;
     [rssCategoryDetailViewController presentModallyOn:self];
}

- (void)viewRssCategoryAtCell:(UITableViewCell *)cell
{
    if (!cell)
        return;
    
    RssCategoryViewCell *rssCategoryViewCell = (RssCategoryViewCell *)cell;
    if (!rssCategoryViewCell)
        return;
    
    RssCategory *rssCategory = rssCategoryViewCell.rssCategory;
    if (!rssCategory)
        return;   
    
    RssFeedViewController *rssFeedViewController = [[[RssFeedViewController alloc] init] autorelease];
    rssFeedViewController.rssCategory = rssCategoryViewCell.rssCategory;
    rssFeedViewController.delegate = self;
    assert(rssFeedViewController != nil);        
    [rssFeedViewController presentModallyOn:self];
}

- (void)editRssCategoryAtCell:(UITableViewCell *)cell
{
    if (!cell)
        return;
    
    RssCategoryViewCell *rssCategoryViewCell = (RssCategoryViewCell *)cell;
    if (!rssCategoryViewCell)
        return;
    
    RssCategory *rssCategory = rssCategoryViewCell.rssCategory;
    if (!rssCategory)
        return;    
    
    RssCategoryDetailViewController *rssCategoryDetailViewController = [[[RssCategoryDetailViewController alloc] init] autorelease];
    assert(rssCategoryDetailViewController != nil);        
    rssCategoryDetailViewController.delegate = self;  
    rssCategoryDetailViewController.rssCategory = rssCategory;
    rssCategoryDetailViewController.viewMode = UpdateMode;
    [rssCategoryDetailViewController presentModallyOn:self];
}

- (void)didBackView:(id)sender
{
    [self refreshData];
}
@end

//
//  RssReaderViewController.m
//  SdtReader
//
//  Created by raycad on 11/9/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import "RssReaderViewController.h"
#import "Common.h"
#import "RssFeedViewCell.h"

@implementation RssReaderViewController
@synthesize searchBar = m_searchBar;
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
        self.title = RssReaderTitle;        
        self.tabBarItem.image = [UIImage imageNamed:@"Newspaper_Feed_48x48.png"];        
    }
    
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)dealloc
{
    [m_rssFeedModel release];
    [m_searchBar release];
    [m_rssFeedTableView release];
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
        RssFeedPK   *rssFeedPK;
        RssFeed     *rssFeed;
        
        title = [NSString stringWithFormat:@"CNN - Top Stories"];
        rssFeedPK = [[RssFeedPK alloc] initWithTitle:title];
        rssFeed = [[RssFeed alloc] initWithRssFeedPK:rssFeedPK];
        link = @"http://rss.cnn.com/rss/cnn_topstories.rss";
        website = @"cnn.com";
        description = @"CNN";
        rssFeed.title = title;
        rssFeed.link = link;
        rssFeed.website = website;
        rssFeed.description = description;
        if ([rssFeedModel addRssFeed:rssFeed]) {
            NSLog(@"Added rss feed sucessfully");
        }
        [title release];
        [link release];
        [website release];
        [description release];
        [rssFeedPK release];
        [rssFeed release];  
        
        title = [NSString stringWithFormat:@"CNN"];
        rssFeedPK = [[RssFeedPK alloc] initWithTitle:title];
        rssFeed = [[RssFeed alloc] initWithRssFeedPK:rssFeedPK];
        link = @"http://rss.cnn.com/rss/cnn_topstories.rss";
        website = @"cnn.com";
        description = @"CNN";
        rssFeed.title = title;
        rssFeed.link = link;
        rssFeed.website = website;
        rssFeed.description = description;
        if ([rssFeedModel addRssFeed:rssFeed]) {
            NSLog(@"Added rss feed sucessfully");
        }
        [title release];
        [link release];
        [website release];
        [description release];
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
    
    if (m_viewMode == CreateNewMode) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(editRssFeed)];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addRssFeed)];
    }
    
    [self loadDataFromDB];
    
    // Reload data
    [self refreshData];
}

- (void)refreshData
{
    NSString *searchText = m_searchBar.text;
    if([searchText isEqualToString:@""] || (searchText == nil)){
        [m_rssFeedModel copyDataFrom:m_readerModel.rssFeedModel];
        
        [m_rssFeedTableView reloadData];
        return;
    }
    
    // Filter course by title
    RssFeedModel *rssFeedModel = [m_readerModel.rssFeedModel searchByTitle:searchText];
    if (rssFeedModel == nil)
        [m_rssFeedModel clear];
    else {
        [m_rssFeedModel copyDataFrom:rssFeedModel];
        //[rssFeedModel release]; // Cause the crash
    }
    
    [m_rssFeedTableView reloadData];
}

- (void)viewDidUnload
{
    [m_searchBar release];
    m_searchBar = nil;
    [m_rssFeedTableView release];
    m_rssFeedTableView = nil;
    
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
    
    // Set up the cell...
    RssFeed *rssFeed = [m_rssFeedModel rssFeedAtIndex:indexPath.row];
    if (!rssFeed)
        return nil;
	
    // Reset it to default values.
    
    cell.editingAccessoryView = nil;
    cell.detailTextLabel.text = nil;
    // Set cell selection is blue style
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    // Set up the cell…
    cell.titleLabel.text = [rssFeed title];
    cell.thumbnailImageView.image = [UIImage imageNamed:@"rss_feeds.jpg"];
    
    // Set data for cell
    cell.rssFeed = rssFeed;
    
    return cell;
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
    /*if (m_rssFeedTableView == tableView && (m_viewMode != SelectMode)) {
        // Navigation logic may go here. Create and push another view controller.
        CourseViewController *courseViewController = [[CourseViewController alloc] init];
        
        CourseViewCell *cell = (CourseViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        assert(cell != nil);
        Course *course = cell.course;
        assert(course != nil);
        
        courseViewController.course = course;
        courseViewController.viewMode = UpdateMode;
        courseViewController.delegate = self;
        
        [[self navigationController] pushViewController:courseViewController animated:YES];
        [courseViewController release];
    }*/
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
    @try{
        [m_rssFeedModel copyDataFrom:m_readerModel.rssFeedModel];
        
        [m_rssFeedTableView reloadData];
    }
    @catch(NSException *e){
    }
    [m_searchBar resignFirstResponder];
    m_searchBar.text = @"";
}

// called when Search (in our case “Done”) button pressed
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

@end

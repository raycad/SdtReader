//
//  RssStoryListViewController.m
//  SdtReader
//
//  Created by raycad on 11/11/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import "RssStoryListViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "RssStoryViewCell.h"

@implementation RssStoryListViewController
@synthesize storyListTableView          = m_storyListTableView;
@synthesize totalStoriesLabel           = m_totalStoriesLabel;
@synthesize rssFeed                     = m_rssFeed;
@synthesize searchBar                   = m_searchBar;

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
    [m_storyListTableView release];
    [m_rssFeed release];
    //[m_rssStoryModel release];
    [m_filterRssStoryModel release];
    [m_totalStoriesLabel release];
    //[m_rssParser release];
    [m_searchBar release];
    [super dealloc];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    m_filterRssStoryModel = [[RssStoryModel alloc] init];
    m_rssStoryModel = [[RssStoryModel alloc] init];
    m_rssParser = [[RssParser alloc] init];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backView)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Show Story" style:UIBarButtonItemStylePlain target:self action:@selector(showStory)];
}

- (void)backView
{
    if ((self.delegate != nil) && [self.delegate respondsToSelector:@selector(hideNavigationBar)]) {
        [self.delegate hideNavigationBar];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showStory
{
    
}

- (void)viewDidUnload
{
    [self setStoryListTableView:nil];
    [self setTotalStoriesLabel:nil];
    [self setSearchBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)textView:(UITextView *)txtView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if( [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location == NSNotFound ) {
        return YES;
    }
    
    [txtView resignFirstResponder];
    return NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    return [m_filterRssStoryModel count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    RssStoryViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[[RssStoryViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
        // Show row with the AccessoryDisclosureIndicator
		cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	}
    
    int row = indexPath.row;
    
    RssStory *rssStory = [m_filterRssStoryModel rssStoryAtIndex:row];
    if (!rssStory)
        return nil;

    // Reset it to default values.
    cell.editingAccessoryView = nil;
    cell.detailTextLabel.text = nil;
    // Set cell selection is blue style
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    NSString *thumbnailFile;
    if (row%3 == 0)
        thumbnailFile = @"rss_story_yellow.png";
    else if (row%3 == 1)
        thumbnailFile = @"rss_story_green.png";
    else
        thumbnailFile = @"rss_story_blue.png";    
        
    // Set data for cell
    cell.rssStory = rssStory;
    cell.titleLabel.text = rssStory.title;
    cell.descriptionLabel.text = rssStory.description;
    cell.thumbnailImageView.image = [UIImage imageNamed:thumbnailFile];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (m_storyListTableView == tableView) {
        /*CourseViewCell *cell = (CourseViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        assert(cell != nil);
        Course *course = cell.course;
        assert(course != nil);
        
        courseViewController.course = course;
        courseViewController.viewMode = UpdateMode;
        courseViewController.delegate = self;
        
        [[self navigationController] pushViewController:courseViewController animated:YES];
        [courseViewController release];*/
        
        RssStory *rssStory = [m_filterRssStoryModel rssStoryAtIndex:indexPath.row];
        if (!rssStory)
            return;
    }
}

- (void)parseRssFeed
{
    if (!m_rssFeed)
        return;
    
    NSString *rssFeedLink = m_rssFeed.link;
    if (!rssFeedLink || rssFeedLink == @"")
        return;
    
    [m_filterRssStoryModel clear];        
    
    m_rssParser.rssFeedLink = rssFeedLink;
    m_rssParser.delegate = self;
    [m_rssParser startProcess];
    
    [m_rssParser release];
 }

//Delegate method for blog parser will get fired when the process is completed
- (void)processCompleted
{
	[m_rssStoryModel copyDataFrom:m_rssParser.rssStoryModel];    

    [self refreshData];    
}

-(void)processHasErrors
{
	//Might be due to Internet
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Unable to download rss. Please check if you are connected to internet."
												   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
	[alert show];	
	[alert release];
	//[self toggleToolBarButtons:YES];
}

- (void)refreshData
{
    NSString *searchText = m_searchBar.text;
    if([searchText isEqualToString:@""] || (searchText == nil)){
        [m_filterRssStoryModel copyDataFrom:m_rssStoryModel];        
    } else {    
        // Filter course by title
        RssStoryModel *rssStoryModel = [m_rssStoryModel searchByTitle:searchText];
        if (rssStoryModel == nil)
            [m_filterRssStoryModel clear];
        else {
            [m_filterRssStoryModel copyDataFrom:rssStoryModel];
            //[rssFeedModel release]; // Cause the crash
        }
    }
    
    // Update the total stories
    m_totalStoriesLabel.text = [NSString stringWithFormat:@"%d", [m_filterRssStoryModel count]];
    
    [m_storyListTableView reloadData];
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

@end

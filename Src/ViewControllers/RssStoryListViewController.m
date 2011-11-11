//
//  RssStoryListViewController.m
//  SdtReader
//
//  Created by raycad on 11/11/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import "RssStoryListViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Parser.h"

@implementation RssStoryListViewController
@synthesize storyListTableView          = m_storyListTableView;
@synthesize headlineTextView            = m_headlineTextView;
@synthesize totalStoriesLabel           = m_totalStoriesLabel;
@synthesize rssFeed                     = m_rssFeed;
@synthesize activityIndicator           = m_activityIndicator;

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
    [m_headlineTextView release];
    [m_rssFeed release];
    [m_rssStoryModel release];
    [m_totalStoriesLabel release];
    [m_activityIndicator release];
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
    
    m_rssStoryModel = nil;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backView)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Show Story" style:UIBarButtonItemStylePlain target:self action:@selector(showStory)];
    
    // Set default parameters   
    [m_headlineTextView.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
    [m_headlineTextView.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [m_headlineTextView.layer setBorderWidth: 1.0];
    [m_headlineTextView.layer setCornerRadius:10.0f];
    [m_headlineTextView.layer setMasksToBounds:YES];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	indicator.hidesWhenStopped = YES;
	[indicator stopAnimating];
	self.activityIndicator = indicator;
	[indicator release];
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
    [self setHeadlineTextView:nil];
    [self setTotalStoriesLabel:nil];
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
    return [m_rssStoryModel count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
 	}
    
    int row = indexPath.row;
    
    RssStory *rssStory = [m_rssStoryModel rssStoryAtIndex:row];
    if (!rssStory)
        return nil;

    // Reset it to default values.
    cell.editingAccessoryView = nil;
    cell.detailTextLabel.text = nil;
    // Set cell selection is blue style
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    // Set data for cell
    cell.text = rssStory.title;
    
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
        
        RssStory *rssStory = [m_rssStoryModel rssStoryAtIndex:indexPath.row];
        if (!rssStory)
            return;

        m_headlineTextView.text = rssStory.description;
    }
}

- (void)parseRssFeed
{
    if (!m_rssFeed)
        return;
    
    NSString *rssFeedLink = m_rssFeed.link;
    if (!rssFeedLink || rssFeedLink == @"")
        return;
    
    [m_rssStoryModel release];
    m_rssStoryModel = [[RssStoryModel alloc] init];
    
    [m_activityIndicator startAnimating];
    
    Parser *rssParser = [[Parser alloc] init];
    [rssParser parseRssFeed:rssFeedLink withDelegate:self];
    
    [rssParser release];
}

- (void)receivedItems:(NSArray *)items
{
    for (int i = 0; i < [items count]; i++) {
        NSObject *item = [items objectAtIndex:i];
        if (!item)
            continue;
        RssStory *rssStory = [[RssStory alloc] init];
        NSString *tmp = nil;
        tmp = [item objectForKey:@"title"];
        rssStory.title = [tmp copy];
        tmp = [item objectForKey:@"description"];
        rssStory.description = [tmp copy];
        
        [m_rssStoryModel addRssStory:rssStory];
        [rssStory release];
    }
    
	[self.storyListTableView reloadData];
    
    // Update the total stories
    m_totalStoriesLabel.text = [NSString stringWithFormat:@"%d stories", [m_rssStoryModel count]];
    
	[m_activityIndicator stopAnimating];
}

@end

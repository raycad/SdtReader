//
//  RssStoryListViewController.m
//  SdtReader
//
//  Created by raycad on 11/11/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import "RssStoryListViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation RssStoryListViewController
@synthesize storyListTableView          = m_storyListTableView;
@synthesize headlineTextView            = m_headlineTextView;
@synthesize rssFeed                     = m_rssFeed;

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
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backView)];
    
    // Set default parameters   
    [m_headlineTextView.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
    [m_headlineTextView.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [m_headlineTextView.layer setBorderWidth: 1.0];
    [m_headlineTextView.layer setCornerRadius:10.0f];
    [m_headlineTextView.layer setMasksToBounds:YES];
}

- (void)backView
{
    if ((self.delegate != nil) && [self.delegate respondsToSelector:@selector(hideNavigationBar)]) {
        [self.delegate hideNavigationBar];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [self setStoryListTableView:nil];
    [self setHeadlineTextView:nil];
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
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
 	}
    
    int row = indexPath.row;

    // Reset it to default values.
    cell.editingAccessoryView = nil;
    cell.detailTextLabel.text = nil;
    // Set cell selection is blue style
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    // Set data for cell
    cell.text = @"test";
    
    return cell;
}

@end

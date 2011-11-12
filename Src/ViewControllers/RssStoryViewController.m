//
//  RssStoryViewController.m
//  SdtReader
//
//  Created by raycad on 11/12/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import "RssStoryViewController.h"

@implementation RssStoryViewController

@synthesize webView     = m_webView;
@synthesize rssStory    = m_rssStory;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithRssStory:(RssStory *)rssStory
{
    if ((self = [super init])) {
        // Initialize parameters
        [m_rssStory autorelease]; // Use this to avoid releasing itself
        m_rssStory = [rssStory retain];
    }
    return self; 
}

- (void)dealloc
{
    [m_webView release];
    [m_rssStory release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //m_webView.userInteractionEnabled = NO;
    self.navigationItem.leftBarButtonItem  = [[[UIBarButtonItem alloc] initWithTitle:@"Back View" style:UIBarButtonItemStylePlain target:self action:@selector(backViewAction:)] autorelease]; 
    assert(self.navigationItem.leftBarButtonItem != nil);
    self.navigationItem.rightBarButtonItem  = [[[UIBarButtonItem alloc] initWithTitle:@"Back Page" style:UIBarButtonItemStylePlain target:self action:@selector(goBackPageAction:)] autorelease]; 
    assert(self.navigationItem.rightBarButtonItem != nil);
    
    [self reload];
}

- (void)goBackPageAction:(id)sender
{
#pragma unused(sender)
    [m_webView goBack];
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)reload
{
    if (!m_rssStory)
        return;
    
    NSLog(m_rssStory.linkUrl);
    
    //Create a URL request for fromideatoapp.com
    NSURL *storyURL = [NSURL URLWithString:m_rssStory.linkUrl];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:storyURL];
    
    [m_webView loadRequest:request];
}
@end

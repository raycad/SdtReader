//
//  RssStoryViewController.m
//  SdtReader
//
//  Created by raycad on 11/12/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import "RssStoryViewController.h"
#import "Common.h"

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
        m_rssStory = rssStory;
    }
    return self; 
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    m_activityIndicatorView = [[UIActivityIndicatorView alloc]     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    m_activityIndicatorView.center = self.view.center;
    [self.view addSubview: m_activityIndicatorView];
    
    //m_webView.userInteractionEnabled = NO;
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:RssStoryTitle style:UIBarButtonItemStylePlain target:self action:@selector(backViewAction:)]; 
    assert(self.navigationItem.leftBarButtonItem != nil);
    self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:@"Back Page" style:UIBarButtonItemStylePlain target:self action:@selector(goBackPageAction:)]; 
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

- (void)showLoadingIndicator:(BOOL)show
{
    if (show) {
        self.title = @"Loading ..."; 
        [m_activityIndicatorView startAnimating];
    } else {
        self.title = @"";
        [m_activityIndicatorView stopAnimating];
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = show;
}

-(void)webViewDidStartLoad:(UIWebView *) portal 
{
    /*UIActivityIndicatorView *actInd = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    UIBarButtonItem *actItem = [[UIBarButtonItem alloc] initWithCustomView:actInd];
    
    self.navigationItem.rightBarButtonItem = actItem;
    
    [actInd startAnimating];
    [actInd release];
    [actItem release];*/
    
    [self showLoadingIndicator:YES];
}

-(void)webViewDidFinishLoad:(UIWebView *) portal
{
    //self.navigationItem.rightBarButtonItem = nil;
    [self showLoadingIndicator:NO];
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

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

@synthesize webView                 = m_webView;
@synthesize rssStory                = m_rssStory;
@synthesize loadingLabel            = m_loadingLabel;
@synthesize backWebPageButton       = m_backWebPageButton;
@synthesize forwardWebPageButton    = m_forwardWebPageButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)backViewButtonClicked:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)browserButtonClicked:(id)sender
{
    NSString *link = m_rssStory.linkUrl;
    if (!link)
        return;
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:link]];
}

- (void)refreshWebPageState
{
    if ([m_webView canGoBack]) {
        [m_backWebPageButton setEnabled:YES];
    } else {
        [m_backWebPageButton setEnabled:NO];
    }
    
    if ([m_webView canGoForward]) {
        [m_forwardWebPageButton setEnabled:YES];
    } else {
        [m_forwardWebPageButton setEnabled:NO];
    }
}

- (IBAction)backWebPageButtonClicked:(id)sender 
{
    [m_webView goBack];
    
    //[self refreshWebPageState];
}

- (IBAction)forwardWebPageButtonClicked:(id)sender
{
    [m_webView goForward];
    
    //[self refreshWebPageState];
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
    
    self.navigationController.navigationBarHidden = YES;
    
    m_activityIndicatorView = [[UIActivityIndicatorView alloc]     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    m_activityIndicatorView.center = self.view.center;
    [self.view addSubview: m_activityIndicatorView];
    
    m_webView.contentMode = UIViewContentModeScaleAspectFit;
    
    //m_webView.userInteractionEnabled = NO;
    /*self.navigationItem.leftBarButtonItem  = [[[UIBarButtonItem alloc] initWithTitle:RssStoryTitle style:UIBarButtonItemStylePlain target:self action:@selector(backViewAction:)] autorelease]; 
    assert(self.navigationItem.leftBarButtonItem != nil);
    self.navigationItem.rightBarButtonItem  = [[[UIBarButtonItem alloc] initWithTitle:@"Back Page" style:UIBarButtonItemStylePlain target:self action:@selector(goBackPageAction:)] autorelease]; 
    assert(self.navigationItem.rightBarButtonItem != nil);*/
    
    [self reload];
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [self setLoadingLabel:nil];
    [self setBackWebPageButton:nil];
    [self setForwardWebPageButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    
    //[self refreshWebPageState];
}

- (void)showLoadingIndicator:(BOOL)show
{
    if (show) {
        [m_loadingLabel setHidden:NO]; 
        [m_activityIndicatorView startAnimating];
    } else {
        [m_loadingLabel setHidden:YES]; 
        [m_activityIndicatorView stopAnimating];
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = show;
}
@end

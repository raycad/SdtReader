//
//  SplashViewController.m
//  SdtReader
//
//  Created by raycad on 11/21/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import "SplashViewController.h"

@implementation SplashViewController

@synthesize timer               = m_timer;
@synthesize splashImageView     = m_splashImageView;
@synthesize delegate            = m_delegate;
@synthesize loadingLabel        = m_loadingLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView 
{
	// Init the view
	CGRect appFrame = [[UIScreen mainScreen] applicationFrame];
	UIView *view = [[UIView alloc] initWithFrame:appFrame];
	view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
	self.view = view;
		
    CGRect boundRect = [view bounds];
    
	m_splashImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newsreader.jpg"]];
	m_splashImageView.frame = CGRectMake(0, 0, boundRect.size.width, boundRect.size.height);
	[self.view addSubview:m_splashImageView];
    
    m_loadingLabel = [[UILabel alloc] init];
    m_loadingLabel.frame = CGRectMake(0, boundRect.size.height/2, boundRect.size.width, 30);
    m_loadingLabel.textAlignment = UITextAlignmentCenter;
    
    //m_loadingLabel.font = [UIFont fontNamesForFamilyName:@"font-family: Arial; font-size: 20px; font-weight: bold; font-style : italic;"];
    
    m_loadingLabel.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:19];
    
    // Transparent background
    m_loadingLabel.backgroundColor = [UIColor clearColor];
    m_loadingLabel.textColor = [UIColor blueColor];
    m_loadingLabel.text = @"SdtReader is loading...";
    
	[self.view addSubview:m_loadingLabel];
	
	m_timer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(fadeScreen) userInfo:nil repeats:NO];
}

-(void)onTimer
{
	NSLog(@"LOAD");
}

- (void)fadeScreen
{
	[UIView beginAnimations:nil context:nil]; // begins animation block
	[UIView setAnimationDuration:0.75];        // sets animation duration
	[UIView setAnimationDelegate:self];        // sets delegate for this block
	[UIView setAnimationDidStopSelector:@selector(finishedFading)];   // calls the finishedFading method when the animation is done (or done fading out)	
	self.view.alpha = 0.0;       // Fades the alpha channel of this view to "0.0" over the animationDuration of "0.75" seconds
	[UIView commitAnimations];   // commits the animation block.  This Block is done.
}

- (void) finishedFading
{	
	[UIView beginAnimations:nil context:nil]; // begins animation block
	[UIView setAnimationDuration:0.75];        // sets animation duration
	self.view.alpha = 1.0;   // fades the view to 1.0 alpha over 0.75 seconds
	[UIView commitAnimations];   // commits the animation block.  This Block is done.
	[m_splashImageView removeFromSuperview];
    
    if ((self.delegate != nil) && [self.delegate respondsToSelector:@selector(didHideSplash:)] ) {
        [self.delegate didHideSplash:self];
    }
}

@end

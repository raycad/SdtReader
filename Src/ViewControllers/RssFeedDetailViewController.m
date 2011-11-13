//
//  RssFeedDetailViewController.m
//  SdtReader
//
//  Created by raycad on 11/12/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import "RssFeedDetailViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation RssFeedDetailViewController

@synthesize rssFeed                 = m_rssFeed;
@synthesize titleTextField          = m_titleTextField;
@synthesize linkTextField           = m_linkTextField;
@synthesize websiteTextField        = m_websiteTextField;
@synthesize descriptionTextView     = m_descriptionTextView;
@synthesize rate1Button             = m_rate1Button;
@synthesize rate2Button             = m_rate2Button;
@synthesize rate3Button             = m_rate3Button;
@synthesize rate4Button             = m_rate4Button;
@synthesize rate5Button             = m_rate5Button;

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
    [m_rssFeed release];
    [m_titleTextField release];
    [m_linkTextField release];
    [m_websiteTextField release];
    [m_rate1Button release];
    [m_rate2Button release];
    [m_rate3Button release];
    [m_rate4Button release];
    [m_rate5Button release];
    [m_descriptionTextView release];
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
    // Do any additional setup after loading the view from its nib.
    
    // Set default parameters   
    [m_descriptionTextView.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
    [m_descriptionTextView.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [m_descriptionTextView.layer setBorderWidth: 1.0];
    [m_descriptionTextView.layer setCornerRadius:10.0f];
    [m_descriptionTextView.layer setMasksToBounds:YES];
}

- (void)viewDidUnload
{
    [self setTitleTextField:nil];
    [self setLinkTextField:nil];
    [self setWebsiteTextField:nil];
    [self setRate1Button:nil];
    [self setRate2Button:nil];
    [self setRate3Button:nil];
    [self setRate4Button:nil];
    [self setRate5Button:nil];
    [self setDescriptionTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)setRate:(int)rate
{
    if (rate < 1 || rate > 5)
        return;
    
    UIImage *rateImage = [UIImage imageNamed:@"star-gold48.png"];
    UIImage *unRateImage = [UIImage imageNamed:@"star-white48.png"];
    
    m_rate1Button.imageView.image = rateImage;
    m_rate2Button.imageView.image = rateImage;
    m_rate3Button.imageView.image = rateImage;
    m_rate4Button.imageView.image = rateImage;
    m_rate1Button.imageView.image = unRateImage;
}

- (IBAction)rate1Clicked:(id)sender 
{
    [self setRate:1];
}

- (IBAction)rate2Clicked:(id)sender 
{
    [self setRate:2];
}

- (IBAction)rate3Clicked:(id)sender 
{
    [self setRate:3];
}

- (IBAction)rate4Clicked:(id)sender
{
    [self setRate:4];
}

- (IBAction)rate5Clicked:(id)sender
{
    [self setRate:5];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return TRUE;
}

- (BOOL)textView:(UITextView *)txtView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if( [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location == NSNotFound ) {
        return YES;
    }
    
    [txtView resignFirstResponder];
    return NO;
}
@end

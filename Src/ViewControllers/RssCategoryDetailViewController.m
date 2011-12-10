//
//  RssCategoryDetailViewController.m
//  SdtReader
//
//  Created by raycad on 11/12/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import "RssCategoryDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "RateButton.h"
#import "RssCategoryModel.h"
#import "ReaderModel.h"

@implementation RssCategoryDetailViewController

@synthesize rssCategory             = m_rssCategory;
@synthesize titleTextField          = m_titleTextField;
@synthesize descriptionTextView     = m_descriptionTextView;

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
    [m_rssCategory release];
    [m_titleTextField release];
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
    
    if (m_rssCategory) {
        // Set data
        m_titleTextField.text       = m_rssCategory.title;
        m_descriptionTextView.text  = m_rssCategory.description;
    }
}

- (void)viewDidUnload
{
    [self setTitleTextField:nil];
    [self setDescriptionTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientatisons
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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

- (void)saveAction:(id)sender
{
#pragma unused(sender)
    NSString *title = [self.titleTextField text];
    
    if ([title isEqualToString:@""]) {
        // Open a alert with an OK button
        NSString *alertString = [NSString stringWithFormat:@"Title must not be empty"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:alertString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        return;
    }
    
    NSString *description = [self.descriptionTextView text];
    
    ReaderModel *readerModel = [ReaderModel instance];
    RssCategoryPK *rssCategoryPK = [[RssCategoryPK alloc] initWithTitle:title];
    
    if (self.viewMode == CreateNewMode) {        
        RssCategory *rssCategory = [[RssCategory alloc] initWithRssCategoryPK:rssCategoryPK];
        rssCategory.title = title;
        rssCategory.description = description;
        
        if (![readerModel addRssCategory:rssCategory]) {
            // Open a alert with an OK button
            NSString *alertString = [NSString stringWithFormat:@"This RSS Category is existing"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:alertString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
            return;
        }
        
        // Insert to DB
        [readerModel insertRssCategoryToDb:rssCategory];
    } else if (self.viewMode == UpdateMode) {
        if (!m_rssCategory)
            return;
        
        RssCategoryModel *rssCategoryModel = readerModel.rssCategoryModel;
        
        // Update RSS Category
        RssCategoryPK *currentRssCategoryPK = [m_rssCategory rssCategoryPK];
        
        if ((![rssCategoryPK isEqual:currentRssCategoryPK]) && [rssCategoryModel getRssCategoryByPK:rssCategoryPK] != nil) {
            // Open a alert with an OK button
            NSString *alertString = [NSString stringWithFormat:@"The RSS Category is existing. Please enter another title name"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:alertString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
            return;
        }
        
        m_rssCategory.title = title;
        m_rssCategory.description = description;
        
        // Reset CategoryPK
        [m_rssCategory rssCategoryPK].title = title;
        
        // Update to DB
        [readerModel updateRssCategoryToDb:m_rssCategory];
    }
    
    // Tell the delegate about the update.    
    if ((self.delegate != nil) && [self.delegate respondsToSelector:@selector(didUpdate:)] ) {
        [self.delegate didSave:self];
    }
}

@end

//
//  SdtViewController.m
//  SdtReader
//
//  Created by raycad on 11/7/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import "SdtViewController.h"

@implementation SdtViewController

@synthesize viewMode = m_viewMode;

- (id)init
{
    self = [super init];
    if (self != nil) {
        m_viewMode = None;
        m_saveButton = nil;
        m_cancelButton = nil;
    }
    
    return self;
}

- (void)presentModallyOn:(UIViewController *)parent
{
    UINavigationController *nav;        
    // Create a navigation controller with us as its root.    
    nav = [[[UINavigationController alloc] initWithRootViewController:self] autorelease];
    assert(nav != nil);    
        
    // Present the navigation controller on the specified parent 
    // view controller.    
    [parent presentModalViewController:nav animated:YES]; 
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ((m_viewMode == CreateNewMode) || (m_viewMode == UpdateMode)) {        
        // Set up the Save & Cancel buttons on the right & left of the navigation bar.    
        /*self.navigationItem.leftBarButtonItem  = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction:)] autorelease];
        assert(self.navigationItem.leftBarButtonItem != nil);
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave   target:self action:@selector(saveAction:)] autorelease];
        assert(self.navigationItem.rightBarButtonItem != nil); */
        
        // Hide the navigation bar
        [self hideNavigationBar];
        
        CGRect rect = self.view.bounds;
        int buttonSize = 40;        
        
        CGRect frame = CGRectMake(5, 5, buttonSize, buttonSize);
        m_cancelButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        m_cancelButton.frame = frame;
        UIImage *buttonImage = [UIImage imageNamed:@"cancel_icon.png"];        
        [m_cancelButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [m_cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:m_cancelButton];
        
        frame = CGRectMake(rect.size.width-5-buttonSize, 5, buttonSize, buttonSize);
        m_saveButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        m_saveButton.frame = frame;
        buttonImage = [UIImage imageNamed:@"save_icon.png"];        
        [m_saveButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [m_saveButton addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:m_saveButton];
        
    } else if (m_viewMode == SelectMode) {
        // Do something
    } 
}

- (void)hideNavigationBar 
{    
    self.navigationController.navigationBarHidden = YES;
}

- (void)showNavigationBar 
{    
    self.navigationController.navigationBarHidden = NO;
}

- (void)dealloc
{
    [m_saveButton release];
    [m_cancelButton release];
    [super dealloc];
}

@end

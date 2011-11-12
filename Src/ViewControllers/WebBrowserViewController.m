//
//  WebBrowserViewController.m
//  SdtReader
//
//  Created by raycad on 11/6/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import "WebBrowserViewController.h"

@implementation WebBrowserViewController

@synthesize delegate = m_delegate;

- (void)goBackPageAction:(id)sender
{
#pragma unused(sender)
    // Tell the delegate about the save.
    if ((self.delegate != nil) && [self.delegate respondsToSelector:@selector(didGoBackPage:)]) {
        [self.delegate didGoBackPage:self];
    }
}

- (void)backViewAction:(id)sender
{
#pragma unused(sender)
    
    // Tell the delegate about the cancellation.    
    if ((self.delegate != nil) && [self.delegate respondsToSelector:@selector(didBackView:)] ) {
        [self.delegate didBackView:self];
    }
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
    
    self.navigationItem.leftBarButtonItem  = [[[UIBarButtonItem alloc] initWithTitle:@"Back View" style:UIBarButtonItemStylePlain target:self action:@selector(backViewAction:)] autorelease]; 
    assert(self.navigationItem.leftBarButtonItem != nil);
    self.navigationItem.rightBarButtonItem  = [[[UIBarButtonItem alloc] initWithTitle:@"Back Page" style:UIBarButtonItemStylePlain target:self action:@selector(goBackPageAction:)] autorelease]; 
    assert(self.navigationItem.rightBarButtonItem != nil);     
}

- (void)dealloc
{
    [m_delegate release];
    [super dealloc];
}

@end

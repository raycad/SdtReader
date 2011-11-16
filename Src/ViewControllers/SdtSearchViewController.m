//
//  SdtSearchViewController.m
//  SdtReader
//
//  Created by raycad on 11/7/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import "SdtSearchViewController.h"

@implementation SdtSearchViewController

- (id)init
{
    self = [super init];
    if (self != nil) {
        
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
    [super dealloc];
}

@end

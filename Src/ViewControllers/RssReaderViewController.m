//
//  RssReaderViewController.m
//  SdtReader
//
//  Created by raycad on 11/9/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import "RssReaderViewController.h"
#import "Common.h"

@implementation RssReaderViewController

- (id)init
{
    //self = [super initWithStyle:UITableViewStyleGrouped];
    self = [super init];
    if (self != nil) {        
        // Set up our navigation bar.
        self.title = RssReaderTitle;        
        self.tabBarItem.image = [UIImage imageNamed:@"Newspaper_Feed_32x32.png"];        
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(editSource)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addSource)];
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

@end

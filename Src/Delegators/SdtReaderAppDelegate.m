//
//  SdtReaderAppDelegate.m
//  SdtReader
//
//  Created by raycad on 11/9/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import "SdtReaderAppDelegate.h"
#import "RssFeedViewController.h"
#import "RssCategoryViewController.h"
#import "Common.h"

@implementation SdtReaderAppDelegate

@synthesize window              = m_window;
@synthesize tabBarController    = m_tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Initialize view controller map
    m_viewControllerMap = [[NSMutableDictionary alloc] init];
    m_tabBarController = [[UITabBarController alloc] init];
    
    // Rss Feeds
    id rssFeedViewController = [self getViewControllerByIdString:(id)RssFeedListViewControllerIdString];    
    UINavigationController *rssFeedNavigationController = [[UINavigationController alloc] init];
    [rssFeedNavigationController pushViewController:rssFeedViewController animated:NO]; 
    
    // Rss Category
    id rssCategoryViewController = [self getViewControllerByIdString:(id)RssCategoryListViewControllerIdString];    
    UINavigationController *rssCategoryNavigationController = [[UINavigationController alloc] init];
    [rssCategoryNavigationController pushViewController:rssCategoryViewController animated:NO];
    
    m_tabBarController.viewControllers = [NSArray arrayWithObjects:rssFeedNavigationController, rssCategoryNavigationController, nil];    
    
    // Add sub view to the window
    [self.window addSubview:[self.tabBarController view]];
    
    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    
    [rssFeedViewController release];
    [rssFeedNavigationController release];
    
    return YES;
}

- (id)createViewControllerByIdString:(NSString *)viewControllerIdString
{
    id viewController = nil;
    if (viewControllerIdString == RssFeedListViewControllerIdString) {
        viewController = [[RssFeedViewController alloc] init];
    } else if (viewControllerIdString == RssCategoryListViewControllerIdString) {
        viewController = [[RssCategoryViewController alloc] init];
    } else
        return nil;
    
    return viewController;
}

- (id)getViewControllerByIdString:(NSString *)viewControllerIdString
{
    if (!m_viewControllerMap)
        return nil;
    
    id viewController = [m_viewControllerMap objectForKey:viewControllerIdString];
    if (!viewController) {
        // Create the view controller
        viewController = [self createViewControllerByIdString:viewControllerIdString];
        // Map the view controller
        [m_viewControllerMap setObject:viewController forKey:viewControllerIdString];    
        [viewController release];
    }
    
    return viewController;
}

- (void)releaseMemory
{       
    // Free momery of view controllers
    id viewController;
    NSArray *keys = [m_viewControllerMap allKeys];
    for (NSString *key in keys) {
        viewController = [m_viewControllerMap objectForKey:key];
        if (viewController) 
            [viewController release];
    }
    [m_viewControllerMap removeAllObjects];
    
    [m_window release];
    [m_viewControllerMap release];
    [m_tabBarController release];
}

- (void)dealloc
{
    [self releaseMemory];
    [super dealloc];
}

@end

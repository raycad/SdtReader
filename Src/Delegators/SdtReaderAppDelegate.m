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
#import "SplashViewController.h"

@implementation SdtReaderAppDelegate

@synthesize window              = m_window;
@synthesize tabBarController    = m_tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Show the splash screen
    [self showSplash];
    
    return YES;
}

- (void)initialize
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
    
    m_tabBarController.delegate = self;
    
    // Add sub view to the window
    [self.window addSubview:[self.tabBarController view]];
    
    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    
    [rssFeedViewController release];
    [rssFeedNavigationController release];
    
    [rssCategoryViewController release];
    [rssCategoryNavigationController release];
}

- (void)showSplash
{    
    m_splashViewController = [[SplashViewController alloc] init];
    m_splashViewController.delegate = self;
    
    // Override point for customization after app launch    
    [self.window addSubview:[m_splashViewController view]];
	
    [self.window makeKeyAndVisible];    
}

- (void)didHideSplash:(NSObject *)object
{
    for (int i = 0; i < [[self.window subviews] count]; i++ ) {
        [[[self.window subviews] objectAtIndex:i] removeFromSuperview];
    }
    
    [self initialize];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if (tabBarController != m_tabBarController)
        return;
    
    NSUInteger index = [tabBarController selectedIndex];
    UIViewController *readerVC = [[m_viewControllerMap allValues] objectAtIndex:index];
    
    if ((readerVC != nil) && [readerVC respondsToSelector:@selector(refreshData)]) {
        [readerVC refreshData];
    }
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
    
    [m_splashViewController release];    
    [m_viewControllerMap release];
    [m_tabBarController release];
    [m_window release];
}

- (void)dealloc
{
    [self releaseMemory];
    [super dealloc];
}

@end

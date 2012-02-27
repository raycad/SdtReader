//
//  AppDelegate.m
//  SdtReader
//
//  Created by raycad sun on 2/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "RssReaderViewController.h"
#import "Common.h"

@implementation AppDelegate

@synthesize window              = m_window;
@synthesize tabBarController    = m_tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Initialize view controller map
    m_viewControllerMap = [[NSMutableDictionary alloc] init];
    m_tabBarController = [[UITabBarController alloc] init];
    
    id rssFeedViewController = [self getViewControllerByIdString:(id)RssReaderViewControllerIdString];    
    UINavigationController *rssFeedNavigationController = [[UINavigationController alloc] init];
    [rssFeedNavigationController pushViewController:rssFeedViewController animated:NO]; 
    
    m_tabBarController.viewControllers = [NSArray arrayWithObjects:rssFeedNavigationController, nil];    
    m_tabBarController.delegate = self;
    self.window.rootViewController = m_tabBarController;
    
    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (id)createViewControllerByIdString:(NSString *)viewControllerIdString
{
    id viewController = nil;
    if (viewControllerIdString == RssReaderViewControllerIdString) {
        viewController = [[RssReaderViewController alloc] init];
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
    }
    
    return viewController;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end

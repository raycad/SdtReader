//
//  AppDelegate.h
//  SdtReader
//
//  Created by raycad sun on 2/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SplashViewController.h"

@interface AppDelegate : NSObject <UIApplicationDelegate> {
    NSMutableDictionary     *m_viewControllerMap;
    
    SplashViewController    *m_splashViewController;
}

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, strong) IBOutlet UITabBarController *tabBarController;

- (id)getViewControllerByIdString:(NSString *)viewControllerIdString;

- (void)initialize;
- (void)showSplash;
@end

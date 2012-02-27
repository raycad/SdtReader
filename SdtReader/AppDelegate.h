//
//  AppDelegate.h
//  SdtReader
//
//  Created by raycad sun on 2/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    NSMutableDictionary *m_viewControllerMap;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) UITabBarController *tabBarController;

- (id)getViewControllerByIdString:(NSString *)viewControllerIdString;

@end

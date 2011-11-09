//
//  SdtReaderAppDelegate.h
//  SdtReader
//
//  Created by raycad on 11/9/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SdtReaderAppDelegate : NSObject <UIApplicationDelegate> {
    NSMutableDictionary *m_viewControllerMap;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

- (id)getViewControllerByIdString:(NSString *)viewControllerIdString;
@end

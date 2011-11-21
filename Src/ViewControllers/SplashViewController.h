//
//  SplashViewController.h
//  SdtReader
//
//  Created by raycad on 11/21/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SplashViewControllerDelegate;
@interface SplashViewController : UIViewController {
	NSTimer                             *m_timer;
	UIImageView                         *m_splashImageView;
    UILabel                             *m_loadingLabel;
    
    id<SplashViewControllerDelegate>    m_delegate;
}

@property(nonatomic, retain) NSTimer *timer;
@property(nonatomic, retain) UIImageView *splashImageView;

@property (nonatomic, retain) id<SplashViewControllerDelegate> delegate;
@property (nonatomic, retain) UILabel   *loadingLabel;
@end

@protocol SplashViewControllerDelegate <NSObject>
@required
- (void)didHideSplash:(NSObject *)object;
@end
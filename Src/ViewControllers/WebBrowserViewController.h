//
//  WebBrowserViewController.h
//  SdtReader
//
//  Created by raycad on 11/6/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WebBrowserViewControllerDelegate;

@interface WebBrowserViewController : UIViewController {
    id<WebBrowserViewControllerDelegate>   m_delegate;
}

@property (nonatomic, retain)id<WebBrowserViewControllerDelegate> delegate;

- (void)goBackPageAction:(id)sender;
- (void)backViewAction:(id)sender;

- (void)presentModallyOn:(UIViewController *)parent;
@end

@protocol WebBrowserViewControllerDelegate <NSObject>
@required
- (void)didGoBackPage:(NSObject *)object;
- (void)didBackView:(NSObject *)object;
@end

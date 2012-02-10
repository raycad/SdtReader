//
//  SdtViewController.h
//  SdtReader
//
//  Created by raycad on 11/7/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelessViewController.h"

typedef enum {
    None            = 0,
    CreateNewMode   = 1, // Save/Cancel buttons
    UpdateMode      = 2,
    SelectMode      = 3
} ViewMode; 

@interface SdtViewController : ModelessViewController {   
    ViewMode    m_viewMode;
    
    UIButton    *m_saveButton;
    UIButton    *m_cancelButton;
}

@property (nonatomic) ViewMode viewMode;

- (void)hideNavigationBar;
- (void)showNavigationBar;
- (void)refreshData;
@end

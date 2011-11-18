//
//  SdtSearchViewController.h
//  SdtReader
//
//  Created by raycad on 11/7/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SdtViewController.h"

typedef enum {
    SearchByTitle       = 0,
    SearchByRate        = 1, 
    SearchByCategory    = 2
} SearchMode; 

typedef enum {
    ViewSelectionMode   = 0,
    EditSelectionMode   = 1, 
} SelectionMode;

@interface SdtSearchViewController : SdtViewController {   
    SearchMode      m_searchMode;
    SelectionMode   m_selectionMode;
}

- (void)hideNavigationBar;
- (void)showNavigationBar;
@end

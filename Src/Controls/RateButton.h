//
//  RateButton.h
//  SdtReader
//
//  Created by raycad on 11/13/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    RateNone    = 0,
    Rating      = 1, 
    UnRating    = 2
} RateState; 

@interface RateButton : UIButton {
    int         m_data;
    
    RateState   m_rateState;
}

@property int data;

- (void)setState:(RateState)rateState;
- (RateState)rateState;
@end

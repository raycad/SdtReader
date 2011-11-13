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

typedef enum {
    Size16      = 0,
    Size32      = 1, 
    Size48      = 2
} RateSize;

@interface RateButton : UIButton {
    int         m_data;
    
    RateState   m_rateState;
    
    NSString    *m_rateImageName;
    NSString    *m_unrateImageName;
}

@property int data;

- (void)setRateSize:(RateSize)rateSize;

- (void)setState:(RateState)rateState;
- (RateState)rateState;
@end

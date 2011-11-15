//
//  RateButton.m
//  SdtReader
//
//  Created by raycad on 11/13/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import "RateButton.h"

@implementation RateButton

@synthesize data   = m_data;

- (id)init
{
    self = [super init];
    if (self) {
        m_rateState = RateNone;
    }
    
    return self;
}

- (void)setRateSize:(RateSize)rateSize
{    
    if (rateSize == Size24) {
        m_rateImageName = @"star-gold24.png";
        m_unrateImageName = @"star-white24.png";
    } else if (rateSize == Size32) {
        m_rateImageName = @"star-gold32.png";
        m_unrateImageName = @"star-white32.png";
    } else if (rateSize == Size48) {
        m_rateImageName = @"star-gold48.png";
        m_unrateImageName = @"star-white48.png";
    } else {
        m_rateImageName = @"star-gold16.png";
        m_unrateImageName = @"star-white16.png";
    }
}

- (void)setState:(RateState)rateState
{
    if (rateState == m_rateState)
        return;
    
    m_rateState = rateState;
    UIImage *rateButtonImage = nil;
    switch (m_rateState) {
        case Rating:
            rateButtonImage = [UIImage imageNamed:m_rateImageName];
            break;
            
        case UnRating:
            rateButtonImage = [UIImage imageNamed:m_unrateImageName];
            
        default:
            break;
    }
    
    if (rateButtonImage)
        [self setBackgroundImage:rateButtonImage forState:UIControlStateNormal];
}

- (RateState)rateState
{
    return m_rateState;
}

- (void)dealloc
{
    [m_rateImageName release];
    [m_unrateImageName release];
}
@end

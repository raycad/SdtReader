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

- (void)setState:(RateState)rateState
{
    if (rateState == m_rateState)
        return;
    
    m_rateState = rateState;
    UIImage *rateButtonImage = nil;
    switch (m_rateState) {
        case Rating:
            rateButtonImage = [UIImage imageNamed:@"star-gold48.png"];
            break;
            
        case UnRating:
            rateButtonImage = [UIImage imageNamed:@"star-white48.png"];
            
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
}
@end

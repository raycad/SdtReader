//
//  RssFeed.m
//  SdtReader
//
//  Created by raycad on 11/10/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import "RssFeed.h"

@implementation RssFeedPK

@synthesize title = m_title;

- (id)initWithTitle:(NSString *)title
{
    if ((self = [super init])) {
        // Initialize parameters
        m_title = title;
    }
    return self;   
}

- (BOOL)isEqual:(id)object
{
    if (object == self)
        return YES;
    
    if (!object || ![object isKindOfClass:[self class]])
        return NO;
    
    NSString *title = [(RssFeedPK *)object title];
    if (!title)
        return NO;
    
    if ([self.title isEqual:title])
        return YES;
    
    return NO;
}
@end

@implementation RssFeed

@synthesize title       = m_title;
@synthesize link        = m_link;
@synthesize website     = m_website;
@synthesize description = m_description;
@synthesize rate        = m_rate;

- (id)initWithRssFeedPK:(RssFeedPK *)rssFeedPK
{
    if ((self = [super init])) {
        // Initialize parameters
        m_rssFeedPK = rssFeedPK;
        m_rate = -1;
    }
    
    return self;
}

- (RssFeedPK *)rssFeedPK
{
    return m_rssFeedPK;
}

@end

//
//  Feed.m
//  SdtReader
//
//  Created by raycad on 11/10/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import "Feed.h"

@implementation FeedPK

@synthesize title = m_title;

- (id)initWithTitle:(NSString *)title
{
    if ((self = [super init])) {
        // Initialize parameters
        [m_title autorelease]; // Use this to avoid releasing itself
        m_title = [title retain];
    }
    return self;   
}

- (void)dealloc 
{
    // Don't release or autorelease the m_courseTitle since it might cause the crash. m_title has been set autorelease in the initWithTitle: function already.
    //[m_title release];
}

- (BOOL)isEqual:(id)object
{
    if (object == self)
        return YES;
    
    if (!object || ![object isKindOfClass:[self class]])
        return NO;
    
    NSString *title = [(FeedPK *)object title];
    if (!title)
        return NO;
    
    if ([self.title isEqual:title])
        return YES;
    
    return NO;
}
@end

@implementation Feed

@synthesize title       = m_title;
@synthesize link        = m_link;
@synthesize website     = m_website;
@synthesize description = m_description;

- (id)initWithFeedPK:(FeedPK *)feedPK
{
    if ((self = [super init])) {
        // Initialize parameters
        [m_feedPK autorelease]; // Use this to avoid releasing itself
        m_feedPK = [feedPK retain];
    }
    
    return self;
}

- (FeedPK *)feedPK
{
    return m_feedPK;
}

- (void)dealloc
{
    [m_title release];
    [m_link release];
    [m_website release];
    [m_description release];
    [super dealloc];
}
@end

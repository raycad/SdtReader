//
//  RssCategory.m
//  SdtReader
//
//  Created by raycad on 11/10/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import "RssCategory.h"

@implementation RssCategoryPK

@synthesize title   = m_title;

- (id)initWithTitle:(NSString *)title
{
    if ((self = [super init])) {
        // Initialize parameters
        m_title = title;
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
    
    NSString *title = [(RssCategoryPK *)object title];
    if (!title)
        return NO;
    
    if ([self.title isEqual:title])
        return YES;
    
    return NO;
}
@end

@implementation RssCategory

@synthesize rssCategoryId   = m_rssCategoryId;
@synthesize title           = m_title;
@synthesize description     = m_description;
@synthesize totalRssFeeds   = m_totalRssFeeds;

- (id)initWithRssCategoryPK:(RssCategoryPK *)rssCategoryPK
{
    if ((self = [super init])) {
        // Initialize parameters
        m_rssCategoryPK = rssCategoryPK;
        
        m_totalRssFeeds = 0;
    }
    
    return self;
}

- (RssCategoryPK *)rssCategoryPK
{
    return m_rssCategoryPK;
}

@end

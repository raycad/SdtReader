//
//  RssStory.m
//  SdtReader
//
//  Created by raycad on 11/10/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import "RssStory.h"

@implementation RssStory

@synthesize title       = m_title;
@synthesize description = m_description;
@synthesize linkUrl     = m_linkUrl;
@synthesize creator     = m_creator;
@synthesize guidUrl     = m_guidUrl;
@synthesize pubDate     = m_pubDate;
@synthesize mediaUrl    = m_mediaUrl;
@synthesize image       = m_image;

- (id)init
{
    if ((self = [super init])) {
        // Initialize parameters        
    }
    return self;   
}

- (void) dealloc
{
    [m_title release];
	[m_description release];
	[m_linkUrl release];
	[m_guidUrl release];
	[m_pubDate release];
	[m_mediaUrl release];
    [m_image release];
    [super dealloc];
}
@end

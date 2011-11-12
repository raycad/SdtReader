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

- (void) dealloc
{
    self.title = nil;
	self.description = nil;
	self.linkUrl = nil;
	self.guidUrl = nil;
	[self.pubDate release];
	self.mediaUrl = nil;
    [super release];
}
@end

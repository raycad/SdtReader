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
@synthesize link        = m_link;
@synthesize creator     = m_creator;
@synthesize date        = m_date;

- (void) dealloc
{
    [m_title release];
    [m_description release];
    [m_link release];
    [m_creator release];
    [m_date release];
    [super release];
}
@end

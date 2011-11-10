//
//  RssStoryModel.m
//  SdtReader
//
//  Created by raycad on 10/27/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import "RssStoryModel.h"

@implementation RssStoryModel

- (id)init
{
    self = [super init];
    if (self != nil) {
        // Initialize parameters
        m_rssStoryList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (BOOL)addRssStory:(RssStory *)rssStory
{
    [m_rssStoryList addObject:rssStory];
    
    return YES;
}

- (RssStory *)RssStoryAtIndex:(int)index
{
    return [m_rssStoryList objectAtIndex:index];
}

- (BOOL)copyDataFrom:(RssStoryModel *)other
{
    // Clear the current model
    [self clear];
    
    for (int i = 0; i < [other count]; i++) {
        [self addRssStory:[other rssStoryAtIndex:i]];
    }
    return YES;
}

- (void)clear
{
    [m_rssStoryList removeAllObjects];
}

- (int)count
{
    return [m_rssStoryList count];
}

- (void)dealloc
{
    [m_rssStoryList release];    
    [super dealloc];
}
@end

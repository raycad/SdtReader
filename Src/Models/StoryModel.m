//
//  StoryModel.m
//  SdtReader
//
//  Created by raycad on 10/27/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import "StoryModel.h"

@implementation StoryModel

- (id)init
{
    self = [super init];
    if (self != nil) {
        // Initialize parameters
        m_storyList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (BOOL)addStory:(Story *)story
{
    [m_storyList addObject:story];
    
    return YES;
}

- (Story *)storyAtIndex:(int)index
{
    return [m_storyList objectAtIndex:index];
}

- (BOOL)copyDataFrom:(StoryModel *)other
{
    // Clear the current model
    [self clear];
    
    for (int i = 0; i < [other count]; i++) {
        [self addStory:[other storyAtIndex:i]];
    }
    return YES;
}

- (void)clear
{
    [m_storyList removeAllObjects];
}

- (int)count
{
    return [m_storyList count];
}

- (void)dealloc
{
    [m_storyList release];    
    [super dealloc];
}
@end

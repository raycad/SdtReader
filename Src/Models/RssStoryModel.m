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

- (RssStory *)rssStoryAtIndex:(int)index
{
    return [m_rssStoryList objectAtIndex:index];
}

- (void)setValue:(RssStory *)rssStory atIndex:(int)index
{
    if (index < 0)
        return;
    if (index > [m_rssStoryList count]-1)
        return;
    
    [m_rssStoryList replaceObjectAtIndex:index withObject:rssStory];
}

- (void)swapValueBetweenIndex:(int)firstIndex andIndex:(int)secondIndex
{
    int count = [m_rssStoryList count];
    if (firstIndex < 0)
        return;
    if (firstIndex > count-1)
        return;
    
    if (secondIndex < 0)
        return;
    if (secondIndex > count-1)
        return;
    
    RssStory *firstStory = [m_rssStoryList objectAtIndex:firstIndex];
    RssStory *secondStory = [m_rssStoryList objectAtIndex:secondIndex];
    
    [m_rssStoryList replaceObjectAtIndex:firstIndex withObject:secondStory];
    [m_rssStoryList replaceObjectAtIndex:secondIndex withObject:firstStory];
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

- (RssStoryModel *)searchByTitle:(NSString *)searchText
{
    RssStoryModel *rssStoryModel = [[RssStoryModel alloc] init];
    RssStory *rssStory = nil;
    for (int i = 0; i < [self count]; i++) {
        rssStory = [self rssStoryAtIndex:i];
        
        NSRange range = [rssStory.title rangeOfString:searchText options:NSCaseInsensitiveSearch];
        if (range.location != NSNotFound) {
            [rssStoryModel addRssStory:rssStory];
        }        
        /*NSComparisonResult result = [rssStory.title compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        if (result == NSOrderedSame) {
            [rssStoryModel addRssStory:rssStory];
        }*/
    }
    
    if ([rssStoryModel count] == 0)
        return nil;
    
    return rssStoryModel;
}

@end

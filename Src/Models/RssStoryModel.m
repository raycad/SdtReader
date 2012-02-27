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
}

@end

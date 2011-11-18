//
//  RssFeedModel.m
//  SdtReader
//
//  Created by raycad on 10/27/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import "RssFeedModel.h"

@implementation RssFeedModel

- (id)init
{
    self = [super init];
    if (self != nil) {
        // Initialize parameters
        m_rssFeedList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (BOOL)addRssFeed:(RssFeed *)rssFeed
{
    if ([self getRssFeedByPK:[rssFeed rssFeedPK]])
        return NO; // The feed is existing
    
    [m_rssFeedList addObject:rssFeed];
    
    return YES;
}

- (RssFeed *)getRssFeedByPK:(RssFeedPK *)rssFeedPK
{
    if (rssFeedPK == nil)
        return nil;
    
    for (int i = 0; i < [m_rssFeedList count]; i++) {
        RssFeed *rssFeed = [m_rssFeedList objectAtIndex:i];
        if ([rssFeedPK isEqual:[rssFeed rssFeedPK]])
            return rssFeed;
    }
    
    return nil;
}

- (BOOL)removeRssFeedByPK:(RssFeedPK *)rssFeedPK
{
    for (int i = 0; i < [m_rssFeedList count]; i++) {
        RssFeed *rssFeed = [m_rssFeedList objectAtIndex:i];
        if ([rssFeedPK isEqual:[rssFeed rssFeedPK]]) {
            [m_rssFeedList removeObjectAtIndex:i];
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)removeRssFeedByIndex:(int)index
{
    @try {
        [m_rssFeedList removeObjectAtIndex:index];
    } @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        return NO;
    } @finally {
        NSLog(@"finally");
        return YES;
    }    
}

- (BOOL)removeRssFeed:(RssFeed *)rssFeed
{
    for (int i = 0; i < [m_rssFeedList count]; i++) {
        RssFeed *rssFeedTmp = [m_rssFeedList objectAtIndex:i];
        if (rssFeedTmp == rssFeed) {
            [m_rssFeedList removeObjectAtIndex:i];
            return YES;
        }
    }
    return NO;
}

- (RssFeed *)rssFeedAtIndex:(int)index
{
    return [m_rssFeedList objectAtIndex:index];
}

- (BOOL)copyDataFrom:(RssFeedModel *)other
{
    // Clear the current model
    [self clear];
    
    for (int i = 0; i < [other count]; i++) {
        [self addRssFeed:[other rssFeedAtIndex:i]];
    }
    return YES;
}

- (RssFeedModel *)searchByCategoryTitle:(NSString *)searchText
{
    return nil;
}

- (RssFeedModel *)searchByCategory:(RssCategory *)rssCategory
{
    RssFeedModel *rssFeedModel = [[RssFeedModel alloc] init];
    RssFeed *rssFeed = nil;
    for (int i = 0; i < [self count]; i++) {
        rssFeed = [self rssFeedAtIndex:i];
        if (rssFeed.category == rssCategory) {
            [rssFeedModel addRssFeed:rssFeed];
        }  
    }
    
    if ([rssFeedModel count] == 0)
        return nil;
    
    return [rssFeedModel autorelease];
}

- (RssFeedModel *)searchByTitle:(NSString *)searchText
{
    RssFeedModel *rssFeedModel = [[RssFeedModel alloc] init];
    RssFeed *rssFeed = nil;
    for (int i = 0; i < [self count]; i++) {
        rssFeed = [self rssFeedAtIndex:i];
        NSRange range = [rssFeed.title rangeOfString:searchText options:NSCaseInsensitiveSearch];
        if (range.location != NSNotFound) {
            [rssFeedModel addRssFeed:rssFeed];
        }  
        /*NSComparisonResult result = [rssFeed.title compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        if (result == NSOrderedSame) {
            [rssFeedModel addRssFeed:rssFeed];
        }*/
    }
        
    if ([rssFeedModel count] == 0)
        return nil;

    return [rssFeedModel autorelease];
}

- (RssFeedModel *)searchByRate:(int)rate
{
    RssFeedModel *rssFeedModel = [[RssFeedModel alloc] init];
    RssFeed *rssFeed = nil;
    for (int i = 0; i < [self count]; i++) {
        rssFeed = [self rssFeedAtIndex:i];
        if (rate == rssFeed.rate) {
            [rssFeedModel addRssFeed:rssFeed];
        }  
    }
    
    if ([rssFeedModel count] == 0)
        return nil;
    
    return [rssFeedModel autorelease];
}

- (void)clear
{
    [m_rssFeedList removeAllObjects];
}

- (int)count
{
    return [m_rssFeedList count];
}

- (void)dealloc
{
    [m_rssFeedList release];    
    [super dealloc];
}
@end

//
//  FeedModel.m
//  SdtReader
//
//  Created by raycad on 10/27/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import "FeedModel.h"

@implementation FeedModel

- (id)init
{
    self = [super init];
    if (self != nil) {
        // Initialize parameters
        m_feedList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (BOOL)addFeed:(Feed *)feed
{
    if ([self getFeedByPK:[feed feedPK]])
        return NO; // The course is existing
    
    [m_feedList addObject:feed];
    
    return YES;
}

- (Feed *)getFeedByPK:(FeedPK *)feedPK
{
    if (feedPK == nil)
        return nil;
    
    for (int i = 0; i < [m_feedList count]; i++) {
        Feed *feed = [m_feedList objectAtIndex:i];
        if ([feedPK isEqual:[feed feedPK]])
            return feed;
    }
    
    return nil;
}

- (BOOL)removeFeedByPK:(FeedPK *)feedPK
{
    for (int i = 0; i < [m_feedList count]; i++) {
        Feed *feed = [m_feedList objectAtIndex:i];
        if ([feedPK isEqual:[feed feedPK]]) {
            [m_feedList removeObjectAtIndex:i];
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)removeFeedByIndex:(int)index
{
    @try {
        [m_feedList removeObjectAtIndex:index];
    } @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        return NO;
    } @finally {
        NSLog(@"finally");
        return YES;
    }    
}

- (BOOL)removeFeed:(Feed *)feed
{
    for (int i = 0; i < [m_feedList count]; i++) {
        Feed *feedTmp = [m_feedList objectAtIndex:i];
        if (feedTmp == feed) {
            [m_feedList removeObjectAtIndex:i];
            return YES;
        }
    }
    return NO;
}

- (Feed *)feedAtIndex:(int)index
{
    return [m_feedList objectAtIndex:index];
}

- (BOOL)copyDataFrom:(FeedModel *)other
{
    // Clear the current model
    [self clear];
    
    for (int i = 0; i < [other count]; i++) {
        [self addFeed:[other feedAtIndex:i]];
    }
    return YES;
}

- (FeedModel *)searchByTitle:(NSString *)searchText
{
    FeedModel *feedModel = [[FeedModel alloc] init];
    Feed *feed = nil;
    for (int i = 0; i < [self count]; i++) {
        feed = [self feedAtIndex:i];
        NSComparisonResult result = [feed.title compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        if (result == NSOrderedSame) {
            [feedModel addFeed:feed];
        }
    }
        
    if ([feedModel count] == 0)
        return nil;

    return [feedModel autorelease];
}

- (void)clear
{
    [m_feedList removeAllObjects];
}

- (int)count
{
    return [m_feedList count];
}

- (void)dealloc
{
    [m_feedList release];    
    [super dealloc];
}
@end

//
//  RssCategoryModel.m
//  SdtReader
//
//  Created by raycad on 10/27/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import "RssCategoryModel.h"

@implementation RssCategoryModel

- (id)init
{
    self = [super init];
    if (self != nil) {
        // Initialize parameters
        m_rssCategoryList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (BOOL)addRssCategory:(RssCategory *)rssCategory
{
    if ([self getRssCategoryByPK:[rssCategory rssCategoryPK]])
        return NO; // The feed is existing
    
    [m_rssCategoryList addObject:rssCategory];
    
    return YES;
}

- (RssCategory *)getRssCategoryByPK:(RssCategoryPK *)rssCategoryPK
{
    if (rssCategoryPK == nil)
        return nil;
    
    for (int i = 0; i < [m_rssCategoryList count]; i++) {
        RssCategory *rssCategory = [m_rssCategoryList objectAtIndex:i];
        if ([rssCategoryPK isEqual:[rssCategory rssCategoryPK]])
            return rssCategory;
    }
    
    return nil;
}

- (BOOL)removeRssCategoryByPK:(RssCategoryPK *)rssCategoryPK
{
    for (int i = 0; i < [m_rssCategoryList count]; i++) {
        RssCategory *rssCategory = [m_rssCategoryList objectAtIndex:i];
        if ([rssCategoryPK isEqual:[rssCategory rssCategoryPK]]) {
            [m_rssCategoryList removeObjectAtIndex:i];
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)removeRssCategoryByIndex:(int)index
{
    @try {
        [m_rssCategoryList removeObjectAtIndex:index];
    } @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        return NO;
    } @finally {
        NSLog(@"finally");
        return YES;
    }    
}

- (BOOL)removeRssCategory:(RssCategory *)rssCategory
{
    for (int i = 0; i < [m_rssCategoryList count]; i++) {
        RssCategory *rssCategoryTmp = [m_rssCategoryList objectAtIndex:i];
        if (rssCategoryTmp == rssCategory) {
            [m_rssCategoryList removeObjectAtIndex:i];
            return YES;
        }
    }
    return NO;
}

- (RssCategory *)rssCategoryAtIndex:(int)index
{
    return [m_rssCategoryList objectAtIndex:index];
}

- (BOOL)copyDataFrom:(RssCategoryModel *)other
{
    // Clear the current model
    [self clear];
    
    for (int i = 0; i < [other count]; i++) {
        [self addRssCategory:[other rssCategoryAtIndex:i]];
    }
    return YES;
}

- (RssCategoryModel *)searchByTitle:(NSString *)searchText
{
    RssCategoryModel *rssCategoryModel = [[RssCategoryModel alloc] init];
    RssCategory *rssCategory = nil;
    for (int i = 0; i < [self count]; i++) {
        rssCategory = [self rssCategoryAtIndex:i];
        NSRange range = [rssCategory.title rangeOfString:searchText options:NSCaseInsensitiveSearch];
        if (range.location != NSNotFound) {
            [rssCategoryModel addRssCategory:rssCategory];
        }  
   }
        
    if ([rssCategoryModel count] == 0)
        return nil;

    return [rssCategoryModel autorelease];
}

- (void)clear
{
    [m_rssCategoryList removeAllObjects];
}

- (int)count
{
    return [m_rssCategoryList count];
}

- (void)dealloc
{
    [m_rssCategoryList release];    
    [super dealloc];
}
@end

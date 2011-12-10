//
//  RssFeedDAO.h
//  SdtReader
//
//  Created by raycad on 12/10/11.
//  Copyright (c) 2011 seedotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RssFeed.h"

@interface RssFeedDAO : NSObject

+ (void) getAllRssFeeds;

/**
 * Insert an RSS Feed to database
 * Returns TRUE if successful and then update the rss category, otherwise returns FALSE
 */
+ (BOOL) insertRssFeed:(RssFeed *)rssFeed;

+ (BOOL) updateRssFeed:(RssFeed *)rssFeed;

+ (BOOL) deleteRssFeed:(RssFeed *)rssFeed;

+ (BOOL) deleteRssFeedsByRssCategoryId:(int)categoryId;

@end

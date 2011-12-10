//
//  RssCategoryDAO.h
//  SdtReader
//
//  Created by raycad on 12/10/11.
//  Copyright (c) 2011 seedotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RssCategoryModel.h"

@interface RssCategoryDAO : NSObject

+ (void) getAllRssCategories;

/**
 * Insert an RSS Category to database
 * Returns TRUE if successful and then update the rss category, otherwise returns FALSE
 */
+ (BOOL) insertRssCategory:(RssCategory *)rssCategory;

+ (BOOL) updateRssCategory:(RssCategory *)rssCategory;

+ (BOOL) deleteRssCategory:(RssCategory *)rssCategory;

@end

//
//  ReaderModel.h
//  SdtReader
//
//  Created by raycad on 11/5/11.
//  Copyright 2011 seedotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RssFeedModel.h"
#import "RssCategoryModel.h"
#import <sqlite3.h> // Import the SQLite database framework

@interface ReaderModel : NSObject {
    RssFeedModel        *m_rssFeedModel; 
    RssCategoryModel    *m_rssCategoryModel;
    
    NSString            *m_databasePath;
    sqlite3             *m_database;
}

// Declare the singleton
+ (ReaderModel *)instance;

@property (nonatomic, retain) RssFeedModel      *rssFeedModel;
@property (nonatomic, retain) RssCategoryModel  *rssCategoryModel;

- (sqlite3 *)getDatabase;

- (BOOL)initialize;

- (BOOL)addRssFeed:(RssFeed *)rssFeed;
- (BOOL)removeRssFeedByPK:(RssFeedPK *)rssFeedPK;
- (BOOL)removeRssFeedByIndex:(int)index;
- (BOOL)removeRssFeedByCategory:(RssCategory *)rssCategory;
- (BOOL)removeRssFeed:(RssFeed *)rssFeed;
- (void)updateRssFeedCategoryOf:(RssFeed *)rssFeed to:(RssCategory *)toCategory;
- (BOOL)insertRssFeedToDb:(RssFeed *)rssFeed;
- (BOOL)updateRssFeedToDb:(RssFeed *)rssFeed;
- (BOOL)deleteRssFeedFromDb:(RssFeed *)rssFeed;

- (BOOL)addRssCategory:(RssCategory *)rssCategory;
- (BOOL)removeRssCategoryByPK:(RssCategoryPK *)rssCategoryPK;
- (BOOL)removeRssCategoryByIndex:(int)index;
- (BOOL)removeRssCategory:(RssCategory *)rssCategory;
- (BOOL)insertRssCategoryToDb:(RssCategory *)rssCategory;
- (BOOL)updateRssCategoryToDb:(RssCategory *)rssCategory;
- (BOOL)deleteRssCategoryFromDb:(RssCategory *)rssCategory;

@end

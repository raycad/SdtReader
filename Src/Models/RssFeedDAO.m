//
//  RssFeedDAO.m
//  SdtReader
//
//  Created by raycad on 12/10/11.
//  Copyright (c) 2011 seedotech. All rights reserved.
//

#import "RssFeedDAO.h"
#import "ReaderModel.h"

@implementation RssFeedDAO

+ (void) getAllRssFeeds
{
    @try {
        ReaderModel         *readerModel        = [ReaderModel instance];
        RssCategoryModel    *rssCategoryModel   = [readerModel rssCategoryModel];
        
        sqlite3 *database = [readerModel getDatabase];
        
        int             rssFeedId = 0;
        int             rssCategoryId = 0;
        NSString        *title;
        NSString        *link;
        NSString        *website;
        NSString        *description;   
        RssFeedPK       *rssFeedPK;
        RssFeed         *rssFeed;
        int             rate = 0;
                
        // Setup the SQL Statement and compile it for faster access
        const char *sqlStatement = "select * from rssfeed";
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            // Loop through the results and add them to the feeds array
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                // Read the data from the result row
                rssFeedId = [[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)] intValue];
                rssCategoryId = [[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)] intValue];
                title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
                link = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
                website = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
                description = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)];
                rate = [[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)] intValue];
                
                rssFeedPK               = [[RssFeedPK alloc] initWithTitle:title];
                rssFeed                 = [[RssFeed alloc] initWithRssFeedPK:rssFeedPK];
                rssFeed.rssFeedId       = rssFeedId;
                rssFeed.title           = title;
                rssFeed.link            = link;
                rssFeed.website         = website;
                rssFeed.description     = description;
                rssFeed.rssCategory     = [rssCategoryModel getCategoryById:rssCategoryId];
                rssFeed.rate            = rate;
                if ([readerModel addRssFeed:rssFeed]) {
                    NSLog(@"Added rss feed sucessfully");
                }
            }
        }
        // Release the compiled statement from memory
        sqlite3_finalize(compiledStatement);
    } @catch (NSException *e) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[e name] message:[e reason] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

+ (BOOL) insertRssFeed:(RssFeed *)rssFeed
{
    @try {
        ReaderModel     *readerModel = [ReaderModel instance];
        sqlite3 *database = [readerModel getDatabase];
        
        int categoryId = 0;
        RssCategory *rssCategory = rssFeed.rssCategory;
        if (rssCategory)
            categoryId = rssCategory.rssCategoryId;
        
        const char *sql = "insert into rssfeed(category_id, title, link, website, description, rate) values(?, ?, ?, ?, ?, ?)";
        sqlite3_stmt *queryStatement;
        if(sqlite3_prepare_v2(database, sql, -1, &queryStatement, NULL) != SQLITE_OK)
            NSAssert1(0, @"Error while creating the statement. '%s'", sqlite3_errmsg(database));
        
        sqlite3_bind_int64(queryStatement, 1, categoryId);
        sqlite3_bind_text(queryStatement, 2, [[rssFeed title] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(queryStatement, 3, [[rssFeed link] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(queryStatement, 4, [[rssFeed website] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(queryStatement, 5, [[rssFeed description] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int64(queryStatement, 6, rssFeed.rate);
                
        if(SQLITE_DONE != sqlite3_step(queryStatement)) {
            NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
            // Release the compiled statement from memory
            sqlite3_finalize(queryStatement);
            return FALSE;
        } else {
            // SQLite provides a method to get the last primary key inserted by using sqlite3_last_insert_rowid
            int rssFeedId = sqlite3_last_insert_rowid(database);
            rssFeed.rssFeedId = rssFeedId;
        }
        
        // Release the compiled statement from memory
        sqlite3_finalize(queryStatement);
    } @catch (NSException *e) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[e name] message:[e reason] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return FALSE;
    }
    
    return TRUE;
}

+ (BOOL) updateRssFeed:(RssFeed *)rssFeed
{
    @try {
        ReaderModel     *readerModel = [ReaderModel instance];
        sqlite3 *database = [readerModel getDatabase];
        
        int categoryId = 0;
        RssCategory *rssCategory = rssFeed.rssCategory;
        if (rssCategory)
            categoryId = rssCategory.rssCategoryId;
        
        const char *sql = "update rssfeed set category_id = ?, title = ?, link = ?, website = ?, description = ?, rate = ? where id = ?";
        sqlite3_stmt *queryStatement;
        if(sqlite3_prepare_v2(database, sql, -1, &queryStatement, NULL) != SQLITE_OK)
            NSAssert1(0, @"Error while creating the statement. '%s'", sqlite3_errmsg(database));
        
        sqlite3_bind_int64(queryStatement, 1, categoryId);
        sqlite3_bind_text(queryStatement, 2, [[rssFeed title] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(queryStatement, 3, [[rssFeed link] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(queryStatement, 4, [[rssFeed website] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(queryStatement, 5, [[rssFeed description] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int64(queryStatement, 6, rssFeed.rate);
        sqlite3_bind_int64(queryStatement, 7, rssFeed.rssFeedId);
        
        if(SQLITE_DONE != sqlite3_step(queryStatement)) {
            NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
            // Release the compiled statement from memory
            sqlite3_finalize(queryStatement);
            return FALSE;
        } 
        
        // Release the compiled statement from memory
        sqlite3_finalize(queryStatement);
    } @catch (NSException *e) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[e name] message:[e reason] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return FALSE;
    }
    
    return TRUE;
}

+ (BOOL) deleteRssFeed:(RssFeed *)rssFeed
{
    @try {
        ReaderModel     *readerModel = [ReaderModel instance];
        sqlite3 *database = [readerModel getDatabase];
        
        const char *sql = "delete from rssfeed where id = ?";
        sqlite3_stmt *queryStatement;
        if(sqlite3_prepare_v2(database, sql, -1, &queryStatement, NULL) != SQLITE_OK)
            NSAssert1(0, @"Error while creating the statement. '%s'", sqlite3_errmsg(database));
        
        sqlite3_bind_int64(queryStatement, 1, rssFeed.rssFeedId);
        
        if(SQLITE_DONE != sqlite3_step(queryStatement)) {
            NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
            // Release the compiled statement from memory
            sqlite3_finalize(queryStatement);
            return FALSE;
        } 
        
        // Release the compiled statement from memory
        sqlite3_finalize(queryStatement);
    } @catch (NSException *e) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[e name] message:[e reason] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return FALSE;
    }
    
    return TRUE;
}

+ (BOOL) deleteRssFeedsByRssCategoryId:(int)categoryId
{
    @try {
        ReaderModel     *readerModel = [ReaderModel instance];
        sqlite3 *database = [readerModel getDatabase];
        
        const char *sql = "delete from rssfeed where category_id = ?";
        sqlite3_stmt *queryStatement;
        if(sqlite3_prepare_v2(database, sql, -1, &queryStatement, NULL) != SQLITE_OK)
            NSAssert1(0, @"Error while creating the statement. '%s'", sqlite3_errmsg(database));
        
        sqlite3_bind_int64(queryStatement, 1, categoryId);
        
        if(SQLITE_DONE != sqlite3_step(queryStatement)) {
            NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
            // Release the compiled statement from memory
            sqlite3_finalize(queryStatement);
            return FALSE;
        } 
        
        // Release the compiled statement from memory
        sqlite3_finalize(queryStatement);
    } @catch (NSException *e) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[e name] message:[e reason] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return FALSE;
    }
    
    return TRUE;
}

@end

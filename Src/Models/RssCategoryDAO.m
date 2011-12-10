//
//  RssCategoryDAO.m
//  SdtReader
//
//  Created by raycad on 12/10/11.
//  Copyright (c) 2011 seedotech. All rights reserved.
//

#import "RssCategoryDAO.h"
#import "ReaderModel.h"

@implementation RssCategoryDAO

+ (void) getAllRssCategories
{
    @try {
        ReaderModel     *readerModel = [ReaderModel instance];
        sqlite3 *database = [readerModel getDatabase];
        
        int             rssCategoryId = 0;
        NSString        *title;
        NSString        *description;   
        RssCategoryPK   *rssCategoryPK;
        RssCategory     *rssCategory;
        
        // Open the database from the users filessytem
        // Setup the SQL Statement and compile it for faster access
        const char *sqlStatement = "select * from rsscategory";
        sqlite3_stmt *queryStatement;
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &queryStatement, NULL) == SQLITE_OK) {
            // Loop through the results and add them to the feeds array
            while(sqlite3_step(queryStatement) == SQLITE_ROW) {
                // Read the data from the result row
                rssCategoryId   = [[NSString stringWithUTF8String:(char *)sqlite3_column_text(queryStatement, 0)] intValue];
                title           = [NSString stringWithUTF8String:(char *)sqlite3_column_text(queryStatement, 1)];
                description     = [NSString stringWithUTF8String:(char *)sqlite3_column_text(queryStatement, 2)];
                
                rssCategoryPK   = [[RssCategoryPK alloc] initWithTitle:title];
                rssCategory     = [[RssCategory alloc] initWithRssCategoryPK:rssCategoryPK];
                rssCategory.rssCategoryId   = rssCategoryId;
                rssCategory.title           = title;
                rssCategory.description     = description;
                if ([readerModel addRssCategory:rssCategory]) {
                    NSLog(@"Added rss category sucessfully");
                }
                [title release];
                [description release];
                [rssCategoryPK release];
                [rssCategory release];
            }
        }
        // Release the compiled statement from memory
        sqlite3_finalize(queryStatement);
    } @catch (NSException *e) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[e name] message:[e reason] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    }
}

+ (BOOL) insertRssCategory:(RssCategory *)rssCategory
{
    @try {
        ReaderModel     *readerModel = [ReaderModel instance];
        sqlite3 *database = [readerModel getDatabase];
        
        const char *sql = "insert into rsscategory(title, description) values(?, ?)";
        sqlite3_stmt *queryStatement;
        if(sqlite3_prepare_v2(database, sql, -1, &queryStatement, NULL) != SQLITE_OK)
            NSAssert1(0, @"Error while creating the statement. '%s'", sqlite3_errmsg(database));
        
        sqlite3_bind_text(queryStatement, 1, [[rssCategory title] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(queryStatement, 2, [[rssCategory description] UTF8String], -1, SQLITE_TRANSIENT);
        //sqlite3_bind_double(queryStatement, 2, [price doubleValue]);
        
        if(SQLITE_DONE != sqlite3_step(queryStatement)) {
            NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
            // Release the compiled statement from memory
            sqlite3_finalize(queryStatement);
            return FALSE;
        } else {
            // SQLite provides a method to get the last primary key inserted by using sqlite3_last_insert_rowid
            int rssCategoryId = sqlite3_last_insert_rowid(database);
            rssCategory.rssCategoryId = rssCategoryId;
        }
        
        // Release the compiled statement from memory
        sqlite3_finalize(queryStatement);
    } @catch (NSException *e) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[e name] message:[e reason] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        return FALSE;
    }
    
    return TRUE;
}

+ (BOOL) updateRssCategory:(RssCategory *)rssCategory
{
    @try {
        ReaderModel     *readerModel = [ReaderModel instance];
        sqlite3 *database = [readerModel getDatabase];
        
        const char *sql = "update rsscategory set title = ?, description = ? where id = ?";
        sqlite3_stmt *queryStatement;
        if(sqlite3_prepare_v2(database, sql, -1, &queryStatement, NULL) != SQLITE_OK)
            NSAssert1(0, @"Error while creating the statement. '%s'", sqlite3_errmsg(database));
        
        sqlite3_bind_text(queryStatement, 1, [[rssCategory title] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(queryStatement, 2, [[rssCategory description] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int64(queryStatement, 3, rssCategory.rssCategoryId);
        
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
        return FALSE;
    }
    
    return TRUE;
}

+ (BOOL) deleteRssCategory:(RssCategory *)rssCategory
{
    @try {
        ReaderModel     *readerModel = [ReaderModel instance];
        sqlite3 *database = [readerModel getDatabase];
        
        const char *sql = "delete from rsscategory where id = ?";
        sqlite3_stmt *queryStatement;
        if(sqlite3_prepare_v2(database, sql, -1, &queryStatement, NULL) != SQLITE_OK)
            NSAssert1(0, @"Error while creating the statement. '%s'", sqlite3_errmsg(database));
        
        sqlite3_bind_int64(queryStatement, 1, rssCategory.rssCategoryId);
        
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
        return FALSE;
    }
    
    return TRUE;
}

@end

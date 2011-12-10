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

+ (void) getAllRssFeed
{
    @try {
        ReaderModel         *readerModel        = [ReaderModel instance];
        RssCategoryModel    *rssCategoryModel   = [readerModel rssCategoryModel];
        
        sqlite3 *database = [readerModel getDatabase];
        
        NSString        *title;
        NSString        *link;
        NSString        *website;
        NSString        *description;   
        RssFeedPK       *rssFeedPK;
        RssFeed         *rssFeed;
        int             rate = 0;
        int             rssCategoryId = 0;
        
        // Setup the SQL Statement and compile it for faster access
        const char *sqlStatement = "select * from rssfeed";
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            // Loop through the results and add them to the feeds array
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                // Read the data from the result row
                rssCategoryId = [[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)] intValue];
                title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
                link = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
                website = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
                description = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)];
                rate = [[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)] intValue];
                
                rssFeedPK           = [[RssFeedPK alloc] initWithTitle:title];
                rssFeed             = [[RssFeed alloc] initWithRssFeedPK:rssFeedPK];
                rssFeed.title       = title;
                rssFeed.link        = link;
                rssFeed.website     = website;
                rssFeed.description = description;
                rssFeed.rssCategory = [rssCategoryModel getCategoryById:rssCategoryId];
                rssFeed.rate        = rate;
                if ([readerModel addRssFeed:rssFeed]) {
                    NSLog(@"Added rss feed sucessfully");
                }
                [title          release];
                [link           release];
                [website        release];
                [description    release];
                [rssFeedPK      release];
                [rssFeed        release];  
            }
        }
        // Release the compiled statement from memory
        sqlite3_finalize(compiledStatement);
    } @catch (NSException *e) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[e name] message:[e reason] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    }
}

@end

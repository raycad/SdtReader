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

+ (void) getAllRssCategory
{
    @try {
        ReaderModel     *readerModel = [ReaderModel instance];
        sqlite3 *database = [readerModel getDatabase];
        
        int             id = 0;
        NSString        *title;
        NSString        *description;   
        RssCategoryPK   *rssCategoryPK;
        RssCategory     *rssCategory;
        
        // Open the database from the users filessytem
        // Setup the SQL Statement and compile it for faster access
        const char *sqlStatement = "select * from rsscategory";
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            // Loop through the results and add them to the feeds array
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                // Read the data from the result row
                id          = [[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)] intValue];
                title       = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
                description = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
                
                rssCategoryPK   = [[RssCategoryPK alloc] initWithTitle:title];
                rssCategory     = [[RssCategory alloc] initWithRssCategoryPK:rssCategoryPK];
                rssCategory.id  = id;
                rssCategory.title       = title;
                rssCategory.description = description;
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
        sqlite3_finalize(compiledStatement);
    } @catch (NSException *e) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[e name] message:[e reason] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    }
}

@end

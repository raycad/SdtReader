//
//  ReaderModel.m
//  SdtReader
//
//  Created by raycad on 11/5/11.
//  Copyright 2011 seedotech. All rights reserved.
//
#import "ReaderModel.h"
#import "Common.h"
#import <sqlite3.h> // Import the SQLite database framework

@implementation ReaderModel

@synthesize rssFeedModel = m_rssFeedModel;
@synthesize rssCategoryModel = m_rssCategoryModel;

static ReaderModel *_instance = nil;

+ (ReaderModel *)instance
{
	@synchronized([ReaderModel class]) {
		if (!_instance)
			[[self alloc] init];
        
		return _instance;
	}
    
	return nil;
}

+ (id)alloc
{
	@synchronized([ReaderModel class]) {
		NSAssert(_instance == nil, @"Attempted to allocate a second instance of a singleton.");
		_instance = [super alloc];
		return _instance;
	}
    
	return nil;
}

- (id)init {
	self = [super init];
	if (self != nil) {
		// Initialize parameters
        m_rssFeedModel = nil;
        m_rssCategoryModel = nil;
        
        [self initialize];
	}
    
	return self;
}

- (void) dealloc
{
    [m_rssFeedModel release];
    [m_rssCategoryModel release];
    [super dealloc];
}
 
- (void) checkAndCreateDatabase 
{
	// Check if the SQL database has already been saved to the users phone, if not then copy it over
	BOOL success = FALSE;
    
	// Create a FileManager object, we will use this to check the status
	// of the database and to copy it over if required
	NSFileManager *fileManager = [NSFileManager defaultManager];
    
	// Check if the database has already been created in the users filesystem
	success = [fileManager fileExistsAtPath:m_databasePath];
    
	// If the database already exists then return without doing anything
	if(success) 
        return;
    
	// If not then proceed to copy the database from the application to the users filesystem
    
	// Get the path to the database in the application package
	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:SdtReaderDBName];
    
	// Copy the database from the package to the users filesystem
    if (![fileManager copyItemAtPath:databasePathFromApp toPath:m_databasePath error:nil]) {
        NSLog(@"Could not create database");
    }
    
	[fileManager release];
}

- (void)loadRssCategoryFromDatabase {
    if (m_rssCategoryModel)
        [m_rssCategoryModel clear];
    else 
        m_rssCategoryModel = [[RssCategoryModel alloc] init];
    
	// Setup the database object
	sqlite3         *database;
    
    NSString        *title;
    NSString        *description;   
    RssCategoryPK   *rssCategoryPK;
    RssCategory     *rssCategory;
     
	// Open the database from the users filessytem
	if(sqlite3_open([m_databasePath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "select * from rsscategory";
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
				title       = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
				description = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
				
				rssCategoryPK = [[RssCategoryPK alloc] initWithTitle:title];
                rssCategory = [[RssCategory alloc] initWithRssCategoryPK:rssCategoryPK];
                rssCategory.title = title;
                rssCategory.description = description;
                if ([self addRssCategory:rssCategory]) {
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
        
	}
	sqlite3_close(database);    
}

- (void)loadRssFeedFromDatabase {
    if (m_rssFeedModel)
        [m_rssFeedModel clear];
    else 
        m_rssFeedModel = [[RssFeedModel alloc] init];
    
	// Setup the database object
	sqlite3 *database;
    
    NSString        *title;
    NSString        *link;
    NSString        *website;
    NSString        *description;   
    RssFeedPK       *rssFeedPK;
    RssFeed         *rssFeed;
    int             rate = 0;
    
	// Open the database from the users filessytem
	if(sqlite3_open([m_databasePath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "select * from rssfeed";
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
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
                rssFeed.category    = [m_rssCategoryModel rssCategoryAtIndex:1];
                rssFeed.rate        = rate;
                if ([self addRssFeed:rssFeed]) {
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
        
	}
	sqlite3_close(database);    
}

- (BOOL)initialize
{
    // Setup some globals
	NSString *databaseName = SdtReaderDBName;
    
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	m_databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    
	// Execute the "checkAndCreateDatabase" function
	[self checkAndCreateDatabase];
    
    [self loadRssCategoryFromDatabase];
    [self loadRssFeedFromDatabase];
    
     return YES;
}

- (BOOL)addRssFeed:(RssFeed *)rssFeed
{
    BOOL result = [m_rssFeedModel addRssFeed:rssFeed];
    if (result) {
        // Increase total rss feeds
        RssCategory *rssCategory = rssFeed.category;
        if (rssCategory)
            rssCategory.totalRssFeeds += 1;
    }
    
    return result;
}

- (BOOL)removeRssFeedByPK:(RssFeedPK *)rssFeedPK
{
    RssFeed *rssFeed = [m_rssFeedModel getRssFeedByPK:rssFeedPK];
    if (!rssFeed)
        return NO;
    RssCategory *rssCategory = rssFeed.category;
    
    BOOL result = [m_rssFeedModel removeRssFeedByPK:rssFeedPK];
    
    if (result && rssCategory) {
        // Decrease total rss feeds
        rssCategory.totalRssFeeds -= 1;
    }
    
    return result;
}

- (BOOL)removeRssFeedByIndex:(int)index
{
    RssFeed *rssFeed = [m_rssFeedModel rssFeedAtIndex:index];
    if (!rssFeed)
        return NO;
    
    RssCategory *rssCategory = rssFeed.category;
    BOOL result = [m_rssFeedModel removeRssFeedByIndex:index];
    
    if (result && rssCategory) {
        // Decrease total rss feeds
        rssCategory.totalRssFeeds -= 1;
    }
    
    return result;
}

- (BOOL)removeRssFeed:(RssFeed *)rssFeed
{
    if (!rssFeed)
        return NO;
    
    RssCategory *rssCategory = rssFeed.category;
    
    BOOL result = [m_rssFeedModel removeRssFeed:rssFeed];
    
    if (result && rssCategory) {
        // Decrease total rss feeds
        rssCategory.totalRssFeeds -= 1;
    }
    
    return result;
}

- (BOOL)removeRssFeedByCategory:(RssCategory *)rssCategory
{
    return [m_rssFeedModel removeRssFeedByCategory:rssCategory];
}

- (void)updateRssFeedCategoryOf:(RssFeed *)rssFeed to:(RssCategory *)toCategory
{
    assert(rssFeed != nil);
    
    RssCategory *fromCategory = rssFeed.category;
    
    if ([fromCategory isEqual:toCategory])
         return;
    
    int totalRssFeeds = 0;
    
    if (fromCategory) {
        totalRssFeeds = fromCategory.totalRssFeeds;
        fromCategory.totalRssFeeds = totalRssFeeds-1;
    }
    
    if (toCategory) {
        totalRssFeeds = toCategory.totalRssFeeds;
        toCategory.totalRssFeeds = totalRssFeeds+1;
    }
    
    // Update reference
    rssFeed.category = toCategory;
}

- (BOOL)addRssCategory:(RssCategory *)rssCategory
{
    return [m_rssCategoryModel addRssCategory:rssCategory];
}

- (BOOL)removeRssCategoryByPK:(RssCategoryPK *)rssCategoryPK
{
    RssCategory *rssCategory = [[m_rssCategoryModel getRssCategoryByPK:rssCategoryPK] retain];
    BOOL result = [m_rssCategoryModel removeRssCategoryByPK:rssCategoryPK];
    
    if (result)
        [self removeRssFeedByCategory:rssCategory];
    
    [rssCategory release];
    
    return result;
}

- (BOOL)removeRssCategoryByIndex:(int)index
{
    RssCategory *rssCategory = [[m_rssCategoryModel rssCategoryAtIndex:index] retain];
    
    BOOL result = [m_rssCategoryModel removeRssCategoryByIndex:index];
    if (result)
        [self removeRssFeedByCategory:rssCategory];
    
    [rssCategory release];
    
    return result;
}

- (BOOL)removeRssCategory:(RssCategory *)category
{
    RssCategory *rssCategory = [category retain];
    
    BOOL result = [m_rssCategoryModel removeRssCategory:rssCategory];
    if (result)
        [self removeRssFeedByCategory:rssCategory];
    
    [rssCategory release];
    
    return result;
}
@end

//
//  ReaderModel.m
//  SdtReader
//
//  Created by raycad on 11/5/11.
//  Copyright 2011 seedotech. All rights reserved.
//
#import "ReaderModel.h"
#import "Common.h"
#import "RssCategoryDAO.h"
#import "RssFeedDAO.h"

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
    
    sqlite3_close(m_database);
    
    [super dealloc];
}

- (void) checkAndCreateDatabase 
{
    @try {
        // Check if the SQL database has already been saved to the users phone, if not then copy it over
        BOOL success = FALSE;
        
        // Create a FileManager object, we will use this to check the status
        // of the database and to copy it over if required
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        // Check if the database has already been created in the users filesystem
        success = [fileManager fileExistsAtPath:m_databasePath];
        
        if(!success) {
            // If not then proceed to copy the database from the application to the users filesystem
            // Get the path to the database in the application package
            NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:SdtReaderDBName];
            
            // Copy the database from the package to the users filesystem
            if (![fileManager copyItemAtPath:databasePathFromApp toPath:m_databasePath error:nil]) {
                NSLog(@"Could not create database");
            }
        }
        
        [fileManager release];
        
        // Open the database from the users filessytem
        if(!sqlite3_open([m_databasePath UTF8String], &m_database) == SQLITE_OK) {
            NSLog(@"Could not open database");
        }
    } @catch (NSException *e) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[e name] message:[e reason] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    }
}

- (sqlite3 *)getDatabase
{
    return m_database;
}

- (void)loadRssCategoryFromDatabase {
    if (m_rssCategoryModel)
        [m_rssCategoryModel clear];
    else 
        m_rssCategoryModel = [[RssCategoryModel alloc] init];
    
	[RssCategoryDAO getAllRssCategories];
}

- (void)loadRssFeedFromDatabase {
    if (m_rssFeedModel)
        [m_rssFeedModel clear];
    else 
        m_rssFeedModel = [[RssFeedModel alloc] init];
    
	[RssFeedDAO getAllRssFeeds];
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
        RssCategory *rssCategory = rssFeed.rssCategory;
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
    RssCategory *rssCategory = rssFeed.rssCategory;
    
    BOOL result = [m_rssFeedModel removeRssFeedByPK:rssFeedPK];
    
    if (result && rssCategory) {
        // Decrease total rss feeds
        rssCategory.totalRssFeeds -= 1;
    }
    
    if (result)
        [rssFeed release];
    
    return result;
}

- (BOOL)removeRssFeedByIndex:(int)index
{
    RssFeed *rssFeed = [m_rssFeedModel rssFeedAtIndex:index];
    if (!rssFeed)
        return NO;
    
    RssFeedPK *rssFeedPK = rssFeed.rssFeedPK;
    
    return [self removeRssFeedByPK:rssFeedPK];
}

- (BOOL)removeRssFeed:(RssFeed *)rssFeed
{
    if (!rssFeed)
        return NO;
    
    RssFeedPK *rssFeedPK = rssFeed.rssFeedPK;
    
    return [self removeRssFeedByPK:rssFeedPK];
}

- (BOOL)removeRssFeedByCategory:(RssCategory *)rssCategory
{
    return [m_rssFeedModel removeRssFeedByCategory:rssCategory];
}

- (void)updateRssFeedCategoryOf:(RssFeed *)rssFeed to:(RssCategory *)toCategory
{
    assert(rssFeed != nil);
    
    RssCategory *fromCategory = rssFeed.rssCategory;
    
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
    rssFeed.rssCategory = toCategory;
}

- (BOOL)insertRssFeedToDb:(RssFeed *)rssFeed
{
    return [RssFeedDAO insertRssFeed:rssFeed];
}

- (BOOL)updateRssFeedToDb:(RssFeed *)rssFeed
{
    return [RssFeedDAO updateRssFeed:rssFeed];
}

- (BOOL)deleteRssFeedFromDb:(RssFeed *)rssFeed
{
    // Remove RSS Feed from database
    [RssFeedDAO deleteRssFeed:rssFeed];
    return TRUE;
}

- (BOOL)insertRssCategoryToDb:(RssCategory *)rssCategory
{
    return [RssCategoryDAO insertRssCategory:rssCategory];
}

- (BOOL)updateRssCategoryToDb:(RssCategory *)rssCategory
{
    return [RssCategoryDAO updateRssCategory:rssCategory];
}

- (BOOL)deleteRssCategoryFromDb:(RssCategory *)rssCategory
{
    // Remove RSS Category from database
    [RssCategoryDAO deleteRssCategory:rssCategory];
    
    // Remove RSS Feeds from database
    [RssFeedDAO deleteRssFeedsByRssCategoryId:rssCategory.rssCategoryId];
    
    return TRUE;
}

- (BOOL)addRssCategory:(RssCategory *)rssCategory
{
    return [m_rssCategoryModel addRssCategory:rssCategory];
}

- (BOOL)removeRssCategoryByPK:(RssCategoryPK *)rssCategoryPK
{
    RssCategory *rssCategory = [m_rssCategoryModel getRssCategoryByPK:rssCategoryPK];
    BOOL result = [m_rssCategoryModel removeRssCategoryByPK:rssCategoryPK];
    
    if (result) {
        result = [self removeRssFeedByCategory:rssCategory];
        [rssCategory release];
    }
    
    return result;
}

- (BOOL)removeRssCategoryByIndex:(int)index
{
    RssCategory     *rssCategory    = [m_rssCategoryModel rssCategoryAtIndex:index];
    RssCategoryPK   *rssCategoryPK  = rssCategory.rssCategoryPK;
    
    return [self removeRssCategoryByPK:rssCategoryPK];
}

- (BOOL)removeRssCategory:(RssCategory *)category
{
    RssCategoryPK   *rssCategoryPK  = category.rssCategoryPK;
    
    return [self removeRssCategoryByPK:rssCategoryPK];
}
@end

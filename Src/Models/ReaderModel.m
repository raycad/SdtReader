//
//  ReaderModel.m
//  SdtReader
//
//  Created by raycad on 11/5/11.
//  Copyright 2011 seedotech. All rights reserved.
//
#import "ReaderModel.h"


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

- (void)setDefaultRssCategories
{
    NSString    *title;
    NSString    *description;   
    RssCategoryPK   *rssCategoryPK;
    RssCategory     *rssCategory;
    
    title = [NSString stringWithFormat:@"Uncategorized"];
    rssCategoryPK = [[RssCategoryPK alloc] initWithTitle:title];
    rssCategory = [[RssCategory alloc] initWithRssCategoryPK:rssCategoryPK];
    description = @"";
    rssCategory.title = title;
    rssCategory.description = description;
    if ([self addRssCategory:rssCategory]) {
        NSLog(@"Added rss category sucessfully");
    }
    [title release];
    [description release];
    [rssCategoryPK release];
    [rssCategory release];
    
    title = [NSString stringWithFormat:@"Technology"];
    rssCategoryPK = [[RssCategoryPK alloc] initWithTitle:title];
    rssCategory = [[RssCategory alloc] initWithRssCategoryPK:rssCategoryPK];
    description = @"";
    rssCategory.title = title;
    rssCategory.description = description;
    if ([self addRssCategory:rssCategory]) {
        NSLog(@"Added rss category sucessfully");
    }
    [title release];
    [description release];
    [rssCategoryPK release];
    [rssCategory release];  
    
    title = [NSString stringWithFormat:@"Business"];
    rssCategoryPK = [[RssCategoryPK alloc] initWithTitle:title];
    rssCategory = [[RssCategory alloc] initWithRssCategoryPK:rssCategoryPK];
    description = @"";
    rssCategory.title = title;
    rssCategory.description = description;
    if ([self addRssCategory:rssCategory]) {
        NSLog(@"Added rss category sucessfully");
    }
    [title release];
    [description release];
    [rssCategoryPK release];
    [rssCategory release];
    
    title = [NSString stringWithFormat:@"Politics"];
    rssCategoryPK = [[RssCategoryPK alloc] initWithTitle:title];
    rssCategory = [[RssCategory alloc] initWithRssCategoryPK:rssCategoryPK];
    description = @"";
    rssCategory.title = title;
    rssCategory.description = description;
    if ([self addRssCategory:rssCategory]) {
        NSLog(@"Added rss category sucessfully");
    }
    [title release];
    [description release];
    [rssCategoryPK release];
    [rssCategory release];
    
    title = [NSString stringWithFormat:@"Education"];
    rssCategoryPK = [[RssCategoryPK alloc] initWithTitle:title];
    rssCategory = [[RssCategory alloc] initWithRssCategoryPK:rssCategoryPK];
    description = @"";
    rssCategory.title = title;
    rssCategory.description = description;
    if ([self addRssCategory:rssCategory]) {
        NSLog(@"Added rss category sucessfully");
    }
    [title release];
    [description release];
    [rssCategoryPK release];
    [rssCategory release];
    
    title = [NSString stringWithFormat:@"Games"];
    rssCategoryPK = [[RssCategoryPK alloc] initWithTitle:title];
    rssCategory = [[RssCategory alloc] initWithRssCategoryPK:rssCategoryPK];
    description = @"";
    rssCategory.title = title;
    rssCategory.description = description;
    if ([self addRssCategory:rssCategory]) {
        NSLog(@"Added rss category sucessfully");
    }
    [title release];
    [description release];
    [rssCategoryPK release];
    [rssCategory release];
    
    title = [NSString stringWithFormat:@"Sports"];
    rssCategoryPK = [[RssCategoryPK alloc] initWithTitle:title];
    rssCategory = [[RssCategory alloc] initWithRssCategoryPK:rssCategoryPK];
    description = @"";
    rssCategory.title = title;
    rssCategory.description = description;
    if ([self addRssCategory:rssCategory]) {
        NSLog(@"Added rss category sucessfully");
    }
    [title release];
    [description release];
    [rssCategoryPK release];
    [rssCategory release];
    
    title = [NSString stringWithFormat:@"Health"];
    rssCategoryPK = [[RssCategoryPK alloc] initWithTitle:title];
    rssCategory = [[RssCategory alloc] initWithRssCategoryPK:rssCategoryPK];
    description = @"";
    rssCategory.title = title;
    rssCategory.description = description;
    if ([self addRssCategory:rssCategory]) {
        NSLog(@"Added rss category sucessfully");
    }
    [title release];
    [description release];
    [rssCategoryPK release];
    [rssCategory release];
    
    title = [NSString stringWithFormat:@"Entertainment"];
    rssCategoryPK = [[RssCategoryPK alloc] initWithTitle:title];
    rssCategory = [[RssCategory alloc] initWithRssCategoryPK:rssCategoryPK];
    description = @"";
    rssCategory.title = title;
    rssCategory.description = description;
    if ([self addRssCategory:rssCategory]) {
        NSLog(@"Added rss category sucessfully");
    }
    [title release];
    [description release];
    [rssCategoryPK release];
    [rssCategory release];
    
    title = [NSString stringWithFormat:@"Travel"];
    rssCategoryPK = [[RssCategoryPK alloc] initWithTitle:title];
    rssCategory = [[RssCategory alloc] initWithRssCategoryPK:rssCategoryPK];
    description = @"";
    rssCategory.title = title;
    rssCategory.description = description;
    if ([self addRssCategory:rssCategory]) {
        NSLog(@"Added rss category sucessfully");
    }
    [title release];
    [description release];
    [rssCategoryPK release];
    [rssCategory release];
    
    title = [NSString stringWithFormat:@"Funny News"];
    rssCategoryPK = [[RssCategoryPK alloc] initWithTitle:title];
    rssCategory = [[RssCategory alloc] initWithRssCategoryPK:rssCategoryPK];
    description = @"";
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

- (void)loadRssCategoriesFromDB
{
    if (m_rssCategoryModel)
        [m_rssCategoryModel clear];
    else 
        m_rssCategoryModel = [[RssCategoryModel alloc] init];
    
    // test
    [self setDefaultRssCategories];
}

- (void)setDefaultRssFeeds
{
    NSString        *title;
    NSString        *link;
    NSString        *website;
    NSString        *description;   
    RssFeedPK       *rssFeedPK;
    RssFeed         *rssFeed;
    
    title = [NSString stringWithFormat:@"BBC News - Technology"];
    rssFeedPK = [[RssFeedPK alloc] initWithTitle:title];
    rssFeed = [[RssFeed alloc] initWithRssFeedPK:rssFeedPK];
    link = @"http://feeds.bbci.co.uk/news/technology/rss.xml";
    website = @"bbc.com";
    description = @"This is an RSS feed from the BBC News - Technology website. RSS feeds allow you to stay up to date with the latest news and features you want from BBC News - Technology.";
    rssFeed.title = title;
    rssFeed.link = link;
    rssFeed.website = website;
    rssFeed.description = description;
    rssFeed.category = [m_rssCategoryModel rssCategoryAtIndex:1];
    rssFeed.rate = 4;
    if ([self addRssFeed:rssFeed]) {
        NSLog(@"Added rss feed sucessfully");
    }
    [title release];
    [link release];
    [website release];
    [description release];
    [rssFeedPK release];
    [rssFeed release];  
    
    title = [NSString stringWithFormat:@"BBC News - Business"];
    rssFeedPK = [[RssFeedPK alloc] initWithTitle:title];
    rssFeed = [[RssFeed alloc] initWithRssFeedPK:rssFeedPK];
    link = @"http://feeds.bbci.co.uk/news/business/rss.xml";
    website = @"bbc.com";
    description = @"This is an RSS feed from the BBC News - Business website. RSS feeds allow you to stay up to date with the latest news and features you want from BBC News - Business.";
    rssFeed.title = title;
    rssFeed.link = link;
    rssFeed.website = website;
    rssFeed.description = description;
    rssFeed.category = [m_rssCategoryModel rssCategoryAtIndex:2];
    rssFeed.rate = 2;
    if ([self addRssFeed:rssFeed]) {
        NSLog(@"Added rss feed sucessfully");
    }
    [title release];
    [link release];
    [website release];
    [description release];
    [rssFeedPK release];
    [rssFeed release];http:
    
    title = [NSString stringWithFormat:@"BBC News - Politics"];
    rssFeedPK = [[RssFeedPK alloc] initWithTitle:title];
    rssFeed = [[RssFeed alloc] initWithRssFeedPK:rssFeedPK];
    link = @"http://feeds.bbci.co.uk/news/politics/rss.xml";
    website = @"bbc.com";
    description = @"This is an RSS feed from the BBC News - Politics website. RSS feeds allow you to stay up to date with the latest news and features you want from BBC News - Politics.";
    rssFeed.title = title;
    rssFeed.link = link;
    rssFeed.website = website;
    rssFeed.description = description;
    rssFeed.category = [m_rssCategoryModel rssCategoryAtIndex:3];
    rssFeed.rate = 3;
    if ([self addRssFeed:rssFeed]) {
        NSLog(@"Added rss feed sucessfully");
    }
    [title release];
    [link release];
    [website release];
    [description release];
    [rssFeedPK release];
    [rssFeed release]; 
    
    title = [NSString stringWithFormat:@"BBC News - Top Stories"];
    rssFeedPK = [[RssFeedPK alloc] initWithTitle:title];
    rssFeed = [[RssFeed alloc] initWithRssFeedPK:rssFeedPK];
    link = @"http://feeds.bbci.co.uk/news/rss.xml";
    website = @"bbc.com";
    description = @"This is an RSS feed from the BBC News - Home website. RSS feeds allow you to stay up to date with the latest news and features you want from BBC News - Home.";
    rssFeed.title = title;
    rssFeed.link = link;
    rssFeed.website = website;
    rssFeed.description = description;
    rssFeed.category = [m_rssCategoryModel rssCategoryAtIndex:0];
    rssFeed.rate = -1;
    if ([self addRssFeed:rssFeed]) {
        NSLog(@"Added rss feed sucessfully");
    }
    [title release];
    [link release];
    [website release];
    [description release];
    [rssFeedPK release];
    [rssFeed release];        
    
    title = [NSString stringWithFormat:@"BBC Education"];
    rssFeedPK = [[RssFeedPK alloc] initWithTitle:title];
    rssFeed = [[RssFeed alloc] initWithRssFeedPK:rssFeedPK];
    link = @"http://feeds.bbci.co.uk/news/education/rss.xml";
    website = @"bbc.com";
    description = @"BBC";
    rssFeed.title = title;
    rssFeed.link = link;
    rssFeed.website = website;
    rssFeed.description = description;
    rssFeed.category = [m_rssCategoryModel rssCategoryAtIndex:4];
    rssFeed.rate = 3;
    if ([self addRssFeed:rssFeed]) {
        NSLog(@"Added rss feed sucessfully");
    }
    [title release];
    [link release];
    [website release];
    [description release];
    [rssFeedPK release];
    [rssFeed release]; 
    
    title = [NSString stringWithFormat:@"CNN - Top Stories"];
    rssFeedPK = [[RssFeedPK alloc] initWithTitle:title];
    rssFeed = [[RssFeed alloc] initWithRssFeedPK:rssFeedPK];
    link = @"http://rss.cnn.com/rss/edition.rss";
    website = @"cnn.com";
    description = @"CNN";
    rssFeed.category = [m_rssCategoryModel rssCategoryAtIndex:0];
    rssFeed.title = title;
    rssFeed.link = link;
    rssFeed.website = website;
    rssFeed.description = description;
    rssFeed.rate = 1;
    if ([self addRssFeed:rssFeed]) {
        NSLog(@"Added rss feed sucessfully");
    }
    [title release];
    [link release];
    [website release];
    [description release];
    [rssFeedPK release];
    [rssFeed release]; 
}

- (void)loadRssFeedsFromDB
{
    if (m_rssFeedModel)
        [m_rssFeedModel clear];
    else 
        m_rssFeedModel = [[RssFeedModel alloc] init];
    
    // test
    [self setDefaultRssFeeds];
}

- (BOOL)initialize
{
    [self loadRssCategoriesFromDB];
    [self loadRssFeedsFromDB];
    
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

- (void)updateRssFeedCategoryOf:(RssFeed *)rssFeed To:(RssCategory *)to
{
    assert(rssFeed != nil);
    
    RssCategory *from = rssFeed.category;
    
    if ([from isEqual:to])
         return;
    
    int totalRssFeeds = 0;
    
    if (from) {
        totalRssFeeds = from.totalRssFeeds;
        from.totalRssFeeds = totalRssFeeds-1;
    }
    
    if (to) {
        totalRssFeeds = to.totalRssFeeds;
        to.totalRssFeeds = totalRssFeeds+1;
    }
    
    // Update reference
    rssFeed.category = to;
}

- (BOOL)addRssCategory:(RssCategory *)rssCategory
{
    return [m_rssCategoryModel addRssCategory:rssCategory];
}

- (BOOL)removeRssCategoryByPK:(RssCategoryPK *)rssCategoryPK
{
    RssCategory *rssCategory = [m_rssCategoryModel getRssCategoryByPK:rssCategoryPK];
    BOOL result = [m_rssCategoryModel removeRssCategoryByPK:rssCategoryPK];
    if (result)
        [self removeRssFeedByCategory:rssCategory];
    return result;
}

- (BOOL)removeRssCategoryByIndex:(int)index
{
    RssCategory *rssCategory = [m_rssCategoryModel rssCategoryAtIndex:index];
    BOOL result = [m_rssCategoryModel removeRssCategoryByIndex:index];
    if (result)
        [self removeRssFeedByCategory:rssCategory];
    return result;
}

- (BOOL)removeRssCategory:(RssCategory *)rssCategory
{
    BOOL result = [m_rssCategoryModel removeRssCategory:rssCategory];
    if (result)
        [self removeRssFeedByCategory:rssCategory];
    return result;
}
@end

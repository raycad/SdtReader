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

- (void)setDefaultRssFeeds
{
    NSString    *title;
    NSString    *link;
    NSString    *website;
    NSString    *description;   
    NSString    *category;
    RssFeedPK   *rssFeedPK;
    RssFeed     *rssFeed;
    
    title = [NSString stringWithFormat:@"CNN - Top Stories (gg)"];
    rssFeedPK = [[RssFeedPK alloc] initWithTitle:title];
    rssFeed = [[RssFeed alloc] initWithRssFeedPK:rssFeedPK];
    link = @"http://rss.cnn.com/rss/cnn_topstories.rss";
    website = @"cnn.com";
    description = @"CNN";
    category = @"Entertainment";
    rssFeed.title = title;
    rssFeed.link = link;
    rssFeed.website = website;
    rssFeed.description = description;
    rssFeed.category = category;
    rssFeed.rate = 4;
    if ([self addRssFeed:rssFeed]) {
        NSLog(@"Added rss feed sucessfully");
    }
    [title release];
    [link release];
    [website release];
    [description release];
    [category release];
    [rssFeedPK release];
    [rssFeed release];  
    
    title = [NSString stringWithFormat:@"MSDN"];
    rssFeedPK = [[RssFeedPK alloc] initWithTitle:title];
    rssFeed = [[RssFeed alloc] initWithRssFeedPK:rssFeedPK];
    link = @"http://feeds2.feedburner.com/TheMdnShow";
    website = @"msdn.com";
    description = @"MSDN";
    category = @"Education";
    rssFeed.title = title;
    rssFeed.link = link;
    rssFeed.website = website;
    rssFeed.description = description;
    rssFeed.category = category;
    rssFeed.rate = 0;
    if ([self addRssFeed:rssFeed]) {
        NSLog(@"Added rss feed sucessfully");
    }
    [title release];
    [link release];
    [website release];
    [description release];
    [category release];
    [rssFeedPK release];
    [rssFeed release];http:
    
    title = [NSString stringWithFormat:@"BBC Top Stories"];
    rssFeedPK = [[RssFeedPK alloc] initWithTitle:title];
    rssFeed = [[RssFeed alloc] initWithRssFeedPK:rssFeedPK];
    link = @"http://feeds.bbci.co.uk/news/rss.xml";
    website = @"bbc.com";
    description = @"BBC";
    category = @"Entertainment";
    rssFeed.title = title;
    rssFeed.link = link;
    rssFeed.website = website;
    rssFeed.description = description;
    rssFeed.category = category;
    rssFeed.rate = 2;
    if ([self addRssFeed:rssFeed]) {
        NSLog(@"Added rss feed sucessfully");
    }
    [title release];
    [link release];
    [website release];
    [description release];
    [category release];
    [rssFeedPK release];
    [rssFeed release]; 
    
    title = [NSString stringWithFormat:@"BBC"];
    rssFeedPK = [[RssFeedPK alloc] initWithTitle:title];
    rssFeed = [[RssFeed alloc] initWithRssFeedPK:rssFeedPK];
    link = @"http://newsrss.bbc.co.uk/rss/sportonline_world_edition/front_page/rss.xml";
    website = @"bbc.com";
    description = @"BBC";
    category = @"Travel";
    rssFeed.title = title;
    rssFeed.link = link;
    rssFeed.website = website;
    rssFeed.description = description;
    rssFeed.category = category;
    rssFeed.rate = -1;
    if ([self addRssFeed:rssFeed]) {
        NSLog(@"Added rss feed sucessfully");
    }
    [title release];
    [link release];
    [website release];
    [description release];
    [category release];
    [rssFeedPK release];
    [rssFeed release];        
    
    title = [NSString stringWithFormat:@"BBC Education"];
    rssFeedPK = [[RssFeedPK alloc] initWithTitle:title];
    rssFeed = [[RssFeed alloc] initWithRssFeedPK:rssFeedPK];
    link = @"http://feeds.bbci.co.uk/news/education/rss.xml";
    website = @"bbc.com";
    description = @"BBC";
    category = @"Education";
    rssFeed.title = title;
    rssFeed.link = link;
    rssFeed.website = website;
    rssFeed.description = description;
    rssFeed.category = category;
    rssFeed.rate = 2;
    if ([self addRssFeed:rssFeed]) {
        NSLog(@"Added rss feed sucessfully");
    }
    [title release];
    [link release];
    [website release];
    [description release];
    [category release];
    [rssFeedPK release];
    [rssFeed release]; 
    
    title = [NSString stringWithFormat:@"BBC Politics"];
    rssFeedPK = [[RssFeedPK alloc] initWithTitle:title];
    rssFeed = [[RssFeed alloc] initWithRssFeedPK:rssFeedPK];
    link = @"http://feeds.bbci.co.uk/news/politics/rss.xml";
    website = @"bbc.com";
    description = @"BBC";
    category = @"Politics";
    rssFeed.title = title;
    rssFeed.link = link;
    rssFeed.website = website;
    rssFeed.description = description;
    rssFeed.category = category;
    rssFeed.rate = 4;
    if ([self addRssFeed:rssFeed]) {
        NSLog(@"Added rss feed sucessfully");
    }
    [title release];
    [link release];
    [website release];
    [description release];
    [category release];
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

- (void)setDefaultRssCategories
{
    
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

- (BOOL)initialize
{
    [self loadRssCategoriesFromDB];
    [self loadRssFeedsFromDB];
    
     return YES;
}

- (BOOL)addRssFeed:(RssFeed *)rssFeed
{
    return [m_rssFeedModel addRssFeed:rssFeed];
}

- (BOOL)removeRssFeedByPK:(RssFeedPK *)rssFeedPK
{
    return [m_rssFeedModel removeRssFeedByPK:rssFeedPK];
}

- (BOOL)removeRssFeedByIndex:(int)index
{
    return [m_rssFeedModel removeRssFeedByIndex:index];
}

- (BOOL)removeRssFeed:(RssFeed *)rssFeed
{
    return [m_rssFeedModel removeRssFeed:rssFeed];
}

- (BOOL)addRssCategory:(RssCategory *)rssCategory
{
    return [m_rssCategoryModel addRssCategory:rssCategory];
}

- (BOOL)removeRssCategoryByPK:(RssCategoryPK *)rssCategoryPK
{
    return [m_rssCategoryModel removeRssCategoryByPK:rssCategoryPK];
}

- (BOOL)removeRssCategoryByIndex:(int)index
{
    return [m_rssCategoryModel removeRssCategoryByIndex:index];
}

- (BOOL)removeRssCategory:(RssCategory *)rssCategory
{
    return [m_rssCategoryModel removeRssCategory:rssCategory];
}
@end

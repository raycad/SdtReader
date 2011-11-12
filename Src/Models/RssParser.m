//
//  RssParser.m
//  SdtReader
//
//  Created by raycad on 8/15/09.
//  Copyright 2011 seedotech. All rights reserved.
//

#import "RssParser.h"

@implementation RssParser

@synthesize rssFeedLink         = m_rssFeedLink;
@synthesize currentRssStory     = m_currentRssStory;
@synthesize rssStoryModel       = m_rssStoryModel;
@synthesize delegate            = m_delegate;
@synthesize retrieverQueue      = m_retrieverQueue;
@synthesize currentItemValue    = m_currentItemValue;

- (id)init
{
	if(![super init]){
		return nil;
	}
    
	m_rssStoryModel = [[RssStoryModel alloc] init];
    
	return self;
}

- (NSOperationQueue *)retrieverQueue
{
	if(nil == m_retrieverQueue) {
		m_retrieverQueue = [[NSOperationQueue alloc] init];
		m_retrieverQueue.maxConcurrentOperationCount = 1;
	}
	return m_retrieverQueue;
}

- (void)startProcess
{
	SEL method = @selector(fetchAndParseRss);
	[self.rssStoryModel clear];
	NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self 
																	 selector:method 
																	   object:nil];
	[self.retrieverQueue addOperation:op];
	[op release];
}

-(BOOL)fetchAndParseRss
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
	//To suppress the leak in NSXMLParser
	[[NSURLCache sharedURLCache] setMemoryCapacity:0];
	[[NSURLCache sharedURLCache] setDiskCapacity:0];
	
	NSURL *url = [NSURL URLWithString:m_rssFeedLink];
	BOOL success = NO;
	NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
	[parser setDelegate:self];
	[parser setShouldProcessNamespaces:YES];
	[parser setShouldReportNamespacePrefixes:YES];
	[parser setShouldResolveExternalEntities:NO];
	success = [parser parse];
	[parser release];
	[pool drain];
	return success;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
	if(nil != qualifiedName){
		elementName = qualifiedName;
	}
	if ([elementName isEqualToString:@"item"]) {
		self.currentRssStory = [[[RssStory alloc] init] autorelease];
	}else if ([elementName isEqualToString:@"media:thumbnail"]) {
		self.currentRssStory.mediaUrl = [attributeDict valueForKey:@"url"];
	} else if([elementName isEqualToString:@"title"] || 
			  [elementName isEqualToString:@"description"] ||
			  [elementName isEqualToString:@"link"] ||
			  [elementName isEqualToString:@"guid"] ||
			  [elementName isEqualToString:@"pubDate"]) {
		self.currentItemValue = [NSMutableString string];
	} else {
		self.currentItemValue = nil;
	}	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName 
{
	if(nil != qName){
		elementName = qName;
	}
	if([elementName isEqualToString:@"title"]){
		self.currentRssStory.title = self.currentItemValue;
	}else if([elementName isEqualToString:@"description"]){
		self.currentRssStory.description = self.currentItemValue;
	}else if([elementName isEqualToString:@"link"]){
		self.currentRssStory.linkUrl = self.currentItemValue;
	}else if([elementName isEqualToString:@"guid"]){
		self.currentRssStory.guidUrl = self.currentItemValue;
	}else if([elementName isEqualToString:@"pubDate"]){
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
		self.currentRssStory.pubDate = [formatter dateFromString:self.currentItemValue];
		[formatter release];
	}else if([elementName isEqualToString:@"item"]){
        [m_rssStoryModel addRssStory:self.currentRssStory];
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if(nil != self.currentItemValue){
		[self.currentItemValue appendString:string];
	}
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
{
	//Not needed for now
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
	if(parseError.code != NSXMLParserDelegateAbortedParseError) {
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
		[(id)[self delegate] performSelectorOnMainThread:@selector(processHasErrors)
                                              withObject:nil
                                           waitUntilDone:NO];
	}
}


- (void)parserDidEndDocument:(NSXMLParser *)parser 
{
	[(id)[self delegate] performSelectorOnMainThread:@selector(processCompleted)
                                          withObject:nil
                                       waitUntilDone:NO];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

-(void)dealloc
{
	self.currentRssStory = nil;
	self.currentItemValue = nil;
	self.delegate = nil;
	
	[m_rssStoryModel release];
	[super dealloc];
}

@end
